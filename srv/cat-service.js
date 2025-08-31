const cds = require("@sap/cds");

const dbPrefix = "sap.capire.hotelbooking";

class CatalogService extends cds.ApplicationService {
  async init() {
    const { Rooms, Reviews, Bookings } = this.entities;

    this.before(
      ["CREATE", "UPDATE", "DELETE"],
      ["Hotels", "Rooms"],
      (req) =>
        req.user.is("admin") ||
        req.reject(403, "Only admin has this permission")
    );

    this.before("READ", "Bookings", async (req) => {
      req.query.where({ client: req.user.id });
    });

    this.after("each", "Hotels", async (hotel) => {
      const hotelReviews = await SELECT.from("Reviews").where({
        hotel_ID: hotel.ID,
      });

      if (hotelReviews.length === 0) {
        hotel.score = 0;
      } else {
        const ratings = hotelReviews
          .map((review) => review.rating)
          .reduce((rating, acc) => rating + acc, 0);
        const avgRating = ratings / hotelReviews.length;

        hotel.score = avgRating;
      }
    });

    this.after("each", "Bookings", (booking) => {
      const currentDate = new Date();
      const bookingEndDate = new Date(booking.endDate);

      if (bookingEndDate < currentDate) {
        booking.bookingStatus = "Completed";
      }
    });

    this.before("makeReservation", "Rooms", async (req) => {
      const { fromDate, toDate } = req.data;
      const roomId = req.params[1].ID;

      const room = await SELECT.one.from(Rooms).where({ ID: roomId });

      const startDate = new Date(fromDate);
      const endDate = new Date(toDate);

      if (!room) {
        return req.error(404, `Room with ID ${roomId} not found`);
      }

      if (
        endDate - startDate < 0 ||
        new Date() >= new Date(startDate) ||
        new Date() > new Date(endDate)
      ) {
        return req.error(
          403,
          "Given date is incorrect. Please, choose days from today"
        );
      }

      if (endDate - startDate === 0) {
        return req.error(403, "Reservation should be more than one day.");
      }
    });

    // Make Reservation action
    this.on("makeReservation", "Rooms", async (req) => {
      const { fromDate, toDate } = req.data;

      const roomId = req.params[1].ID;
      const userEmail = req.user.id;

      const room = await SELECT.one.from(Rooms).where({ ID: roomId });

      const startDate = new Date(fromDate);
      const endDate = new Date(toDate);

      const milisecondsDifference = endDate - startDate;

      const days = Math.ceil(milisecondsDifference / (1000 * 60 * 60 * 24));

      const totalPrice = days * room.price;

      const booking = {
        room_ID: roomId,
        client: userEmail,
        startDate: fromDate,
        endDate: toDate,
        totalPrice,
        bookingStatus: "Booked",
      };
      console.log(booking);

      await INSERT.into("Bookings").entries(booking);

      req.notify({
        message: `Reservation made successfully, refresh the page to see the changes.`,
      });

      return true;
    });

    this.before("cancelReservation", "Bookings", async (req) => {
      const bookingId = req.params[0].ID;

      const booking = await SELECT.one.from(Bookings).where({ ID: bookingId });

      if (!booking) {
        return req.error(404, `Booking with ID ${bookingId} not found`);
      }

      const isCompleted = new Date() > new Date(booking.endDate);

      if (booking.bookingStatus === "Cancelled" || isCompleted) {
        return req.error(
          403,
          `The Booking with ID - ${bookingId} is already cancelled, or completed`
        );
      }
    });

    this.on("cancelReservation", "Bookings", async (req) => {
      const bookingId = req.params[0].ID;

      await UPDATE(Bookings, bookingId).with({ bookingStatus: "Cancelled" });

      req.notify({
        message: `Reservation cancelled. refresh the page to see the changes.`,
      });

      return true;
    });

    this.before("createReview", "Hotels", async (req) => {
      const { Rating, Text } = req.data;

      if (Rating <= 0 || Rating > 5) {
        return req.error(403, "Rating should be between 1 and 5");
      }

      if (Text === "") {
        return req.error(403, "You cannot enter an empty text");
      }
    });

    // Make Review action
    this.on("createReview", "Hotels", async (req) => {
      const { Rating, Text } = req.data;

      const hotelID = req.params[0].ID;
      const userID = req.user.id;

      await INSERT.into("Reviews").entries({
        hotel_ID: hotelID,
        reviewerEmail: userID,
        description: Text,
        rating: Rating,
        date: new Date(),
      });

      req.notify({
        message: `Review created, refresh the page to see the changes.`,
      });

      return true;
    });

    this.before("removeReview", async (req) => {
      const reviewId = req.params[1].ID;
      const userEmail = req.user.id;

      const review = await SELECT.one.from(Reviews).where({ ID: reviewId });

      if (!review) {
        return req.error(404, `Review with ID ${reviewId} not found`);
      }

      if (userEmail !== review.reviewerEmail) {
        return req.error(
          403,
          `Review with ID ${reviewId} is not yours, You are unable to delete it.`
        );
      }
    });

    this.on("removeReview", async (req) => {
      const reviewId = req.params[1].ID;

      await DELETE.from(Reviews).where({ ID: reviewId });
      req.notify({
        message: `Review deleted, refresh the page to see the changes.`,
      });

      return true;
    });

    await super.init();
  }
}

module.exports = CatalogService;
