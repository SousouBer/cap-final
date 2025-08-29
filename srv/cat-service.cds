using { sap.capire.hotelbooking as my } from '../db/schema';

service CatalogService @(path:'/browse') { 
    entity Users as projection on my.Users;

    @odata.draft.enabled
    entity Hotels as projection on my.Hotels actions {
        action createReview(Rating: Decimal, Text: String) returns Boolean;
    }

    entity Rooms    as projection on my.Rooms;
    entity Bookings as projection on my.Bookings;

    entity Reviews  as projection on my.Reviews;  

    action makeReservation(hotelID: UUID, userID: UUID, fromDate: Date, toDate: Date) returns Boolean;
    

}

annotate CatalogService with @(requires: 'admin');