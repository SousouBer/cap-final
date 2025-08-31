using { cuid, managed, Currency } from '@sap/cds/common';

namespace sap.capire.hotelbooking;

entity Hotels : cuid, managed {
  imageUrl: String;
  name: String;
  description: String;
  location: String;
  score: Decimal;
  ownerFullName: String;
  email: String;
  phone: String;
  rooms: Composition of many Rooms on rooms.hotel = $self;
  reviews: Composition of many Reviews on reviews.hotel = $self;  
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
  imageUrl: String;
  number: Integer;
  type: Type;
  status: Status;
  capacity: Integer;
  price: Decimal;
  currency: Currency;
  hotel: Association to Hotels;
}

entity Reviews : cuid, managed {
  reviewerEmail : String;
  date: Date;
  description: String;
  rating: Decimal;
  hotel: Association to Hotels;
}

type BookingStatus : String enum {
  Booked;
  Ongoing;
  Cancelled;
}

entity Bookings : cuid, managed {
  client: String;
  bookingStatus: BookingStatus;
  startDate: Date;
  endDate: Date;
  totalPrice: Decimal;
  room: Association to Rooms;
} 