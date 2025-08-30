const cds = require("@sap/cds");

const dbPrefix = "sap.capire.hotelbooking";

class CatalogService extends cds.ApplicationService {
  async init() {
    // Make Reservation action
    this.on("makeReservation", "Rooms", async (req) => {
      const { fromDate, toDate } = req.data;

      const roomId = req.params[1].ID;
      const userEmail = req.user.id;

      const { Rooms } = cds.entities(dbPrefix);

      const room = await SELECT.one.from(Rooms).where({ ID: roomId });

      if (!room) {
        return req.error(404, `Room with ID ${roomId} not found`);
      }

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

      console.log("test this", booking);

      // const availableRoom = await cds
      //   .transaction(req)
      //   .run(
      //     SELECT.one
      //       .from("Rooms")
      //       .where({ hotel_ID: hotelID, status: "available" })
      //   );

      // if (!availableRoom) return false;

      // await cds.transaction(req).run(
      //   INSERT.into("Reservations").entries({
      //     hotel_ID: hotelID,
      //     room_ID: availableRoom.ID,
      //     user_ID: userID,
      //     startDate: fromDate,
      //     endDate: toDate,
      //   })
      // );

      // await cds
      //   .transaction(req)
      //   .run(
      //     UPDATE("Rooms")
      //       .set({ status: "booked" })
      //       .where({ ID: availableRoom.ID })
      //   );

      return true;
    });

    // Make Review action
    this.on("createReview", "Hotels", async (req) => {
      const { Rating, Text } = req.data;

      const hotelID = req.params[0].ID;
      const userID = req.user.id;

      console.log("this is it", req);

      await INSERT.into("Reviews").entries({
        hotel_ID: hotelID,
        reviewerEmail: userID,
        description: Text,
        rating: Rating,
        date: new Date(),
      });
    });

    this.before("removeReview", async (req) => {
      const reviewId = req.params[1].ID;
      const userEmail = req.user.id;

      const { Reviews } = cds.entities(dbPrefix);

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

      const { Reviews } = cds.entities(dbPrefix);

      await DELETE.from(Reviews).where({ ID: reviewId });
      req.notify({ message: `Review deleted` });

      return true;
    });

    // Must call super.init() at the end
    await super.init();
  }
}

module.exports = CatalogService;
