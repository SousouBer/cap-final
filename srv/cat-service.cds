using { sap.capire.hotelbooking as my } from '../db/schema';

service CatalogService @(path:'/browse') { 
    entity Users    as projection on my.Users;
    entity Hotels   as projection on my.Hotels;
    entity Rooms    as projection on my.Rooms;
    entity Bookings as projection on my.Bookings;
    entity Reviews  as projection on my.Reviews;  
}