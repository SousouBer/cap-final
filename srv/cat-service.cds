using { sap.capire.hotelbooking as my } from '../db/schema';

service CatalogService @(requires: 'authenticated-user', path:'/browse') { 
    @odata.draft.enabled
    @restrict: [
        { grant: ['*'], to: 'admin'},
        { grant: ['*'], to: 'user' }]
    entity Hotels as projection on my.Hotels actions {
        action createReview(Rating: Decimal, Text: String) returns Boolean;
    }

    entity Rooms    as projection on my.Rooms;
    entity Bookings as projection on my.Bookings;

    entity Reviews  as projection on my.Reviews actions {
        action removeReview() returns Boolean; 
    };  

    action makeReservation(hotelID: UUID, userID: UUID, fromDate: Date, toDate: Date) returns Boolean;
    

}

