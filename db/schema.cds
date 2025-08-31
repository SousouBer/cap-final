using { cuid, managed, Currency } from '@sap/cds/common';

namespace sap.capire.hotelbooking;

entity Hotels : cuid, managed {
  imageUrl: String;
  name: String @mandatory;
  description: String @mandatory;
  location: String @mandatory;
  score: Decimal default 0 @readonly;
  ownerFullName: String @mandatory;

  @mandatory
  @assert.format: '/^\S+@\S+\.\S+$/'
  @assert.format.message: 'Please, provide a valid email address'
  email: String;

  phone: String @mandatory;
  rooms: Composition of many Rooms on rooms.hotel = $self;
  reviews: Composition of many Reviews on reviews.hotel = $self;  
}

type Type : String enum {
  Single;
  Double;
}

entity Rooms : cuid, managed {
  imageUrl: String;
  number: Integer @mandatory;
  type: Type @mandatory;
  capacity: Integer @mandatory;
  price: Decimal @mandatory;
  currency: Currency default 'EUR';
  hotel: Association to Hotels @mandatory @assert.target;
  bookings: Composition of many Bookings on bookings.room = $self;
}

// Adding @assert.range:[1,5] would also work for rating element.
entity Reviews : cuid, managed {
  reviewerEmail : String @mandatory;
  date: Date @mandatory;
  description: String @mandatory;
  rating: Decimal @mandatory;
  hotel: Association to Hotels @assert.target;
}

type BookingStatus : String enum {
  Booked;
  Completed;
  Cancelled;
}

entity Bookings : cuid, managed {
  client: String @mandatory;
  bookingStatus: BookingStatus @readonly;
  startDate: Date @mandatory;
  endDate: Date @mandatory;
  totalPrice: Decimal @mandatory;
  room: Association to Rooms @mandatory @assert.target;
} 