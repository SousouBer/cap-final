const cds = require("@sap/cds");

class CatalogService extends cds.ApplicationService {
  async init() {
    // Make Reservation action
    this.on("makeReservation", async (req) => {
      const { hotelID, userID, fromDate, toDate } = req.data;

      const availableRoom = await cds
        .transaction(req)
        .run(
          SELECT.one
            .from("Rooms")
            .where({ hotel_ID: hotelID, status: "available" })
        );

      if (!availableRoom) return false;

      await cds.transaction(req).run(
        INSERT.into("Reservations").entries({
          hotel_ID: hotelID,
          room_ID: availableRoom.ID,
          user_ID: userID,
          startDate: fromDate,
          endDate: toDate,
        })
      );

      await cds
        .transaction(req)
        .run(
          UPDATE("Rooms")
            .set({ status: "booked" })
            .where({ ID: availableRoom.ID })
        );

      return true;
    });

    // Make Review action
    this.on("createReview", "Hotels", async (req) => {
      const { Rating, Text } = req.data;

      const hotelID = req.params[0].ID;
      const userID = req.user.ID;

      console.log(req.user);

      await INSERT.into("Reviews").entries({
        hotel_ID: hotelID,
        reviewer_ID: userID,
        description: Text,
        rating: Rating,
        date: new Date(),
      });
    });

    // Must call super.init() at the end
    await super.init();
  }
}

module.exports = CatalogService;
