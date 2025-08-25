using { cuid, managed, Currency } from '@sap/cds/common';

namespace sap.capire.hotelbooking;

type Role : String enum {
    Client;
    Admin;
    Owner;
}

entity Users : cuid {
  name: String;
  surname: String;
  email: String;
  phone: String;
  role: Role;
}

entity Hotels : cuid, managed {
  name: String;
  description: String;
  location: String;
  rating: Decimal;
  owner: Association to Users;
}

type Type : String enum {
  Single;
  Double;
}

type Status : String enum {
  Available;
  Booked;
}

entity Rooms : cuid, managed {
  number: Integer;
  type: Type;
  status: Status;
  capacity: Integer;
  price: Decimal;
  currency: Currency;
  hotel: Association to Hotels;
}

entity Reviews : cuid, managed {
  reviewer : Association to Users;
  hotel: Association to Hotels;
  description: String;
  score: Decimal;
}

type BookingStatus : String enum {
  Booked;
  Ongoing;
  Cancelled;
}

entity Bookings : cuid, managed {
  client: Association to Users;
  room: Association to Rooms;
  bookingStatus: BookingStatus;
  startDate: Date;
  endDate: Date;
  totalPrice: Decimal;
} 