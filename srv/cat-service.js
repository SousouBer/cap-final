const cds = require("@sap/cds");

const dbPrefix = "sap.capire.hotelbooking";

class CatalogService extends cds.ApplicationService {
  async init() {
    const { Rooms, Reviews, Bookings } = this.entities;

    this.before("makeReservation", "Rooms", async (req) => {
      const { fromDate, toDate } = req.data;
      const roomId = req.params[1].ID;

      const room = await SELECT.one.from(Rooms).where({ ID: roomId });

      const startDate = new Date(fromDate);
      const endDate = new Date(toDate);

      if (!room) {
        return req.error(404, `Room with ID ${roomId} not found`);
      }

      if (endDate - startDate < 0) {
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

      if (
        booking.bookingStatus === "Cancelled" ||
        booking.bookingStatus === "Ongoing"
      ) {
        return req.error(
          403,
          `The Booking with ID - ${bookingId} is already cancelled, or ongoing`
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
