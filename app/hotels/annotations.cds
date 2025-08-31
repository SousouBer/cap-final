using CatalogService as service from '../../srv/cat-service';
using from '@sap/cds/common';

annotate service.Hotels with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : imageUrl,
                Label : '{i18n>ImageUrl}',
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Name}',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Description}',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Location}',
                Value : location,
            },
            {
                $Type : 'UI.DataField',
                Value : ownerFullName,
                Label : '{i18n>OwnerFullName}',
            },
            {
                $Type : 'UI.DataField',
                Value : phone,
                Label : '{i18n>Phone}',
            },
            {
                $Type : 'UI.DataField',
                Value : email,
                Label : '{i18n>Email}',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>HotelRooms}',
            ID : 'i18nHotelRooms',
            Target : 'rooms/@UI.LineItem#i18nHotelRooms',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Reviews}',
            ID : 'i18nReviews',
            Target : 'reviews/@UI.LineItem#i18nReviews',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : imageUrl,
            Label : '{i18n>Image}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Name}',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Description}',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Location}',
            Value : location,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#score1',
            Label : '{i18n>Score}',
        },
    ],
    UI.DataPoint #rating : {
        Value : rating,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.SelectionFields : [
        location,
    ],
    UI.DataPoint #rating1 : {
        $Type : 'UI.DataPointType',
        Value : rating,
        Title : '{i18n>Rating}',
        TargetValue : 5,
        Visualization : #Rating,
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'score',
            Target : '@UI.DataPoint#rating3',
        },
    ],
    UI.DataPoint #name : {
        $Type : 'UI.DataPointType',
        Value : name,
        Title : '{i18n>Name}',
    },
    UI.DataPoint #location : {
        $Type : 'UI.DataPointType',
        Value : location,
        Title : '{i18n>Location}',
    },
    UI.DataPoint #description : {
        $Type : 'UI.DataPointType',
        Value : description,
        Title : '{i18n>Description}',
    },
    UI.DataPoint #rating2 : {
        $Type : 'UI.DataPointType',
        Value : rating,
        Title : '{i18n>Rating}',
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : '{i18n>HotelDetails}',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : description,
        },
        ImageUrl : imageUrl,
    },
    UI.FieldGroup #i18nTheListOfRooms : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : rooms.number,
                Label : '{i18n>RoomNumber}',
            },
            {
                $Type : 'UI.DataField',
                Value : rooms.capacity,
                Label : '{i18n>Capacity}',
            },
            {
                $Type : 'UI.DataField',
                Value : rooms.type,
                Label : '{i18n>Type}',
            },
            {
                $Type : 'UI.DataField',
                Value : rooms.price,
                Label : 'Price',
            },
            {
                $Type : 'UI.DataField',
                Value : rooms.currency_code,
            },
            {
                $Type : 'UI.DataField',
                Value : rooms.currency.symbol,
            },
            {
                $Type : 'UI.DataField',
                Value : rooms.status,
                Label : '{i18n>Status}',
            },
        ],
    },
    UI.DataPoint #rating3 : {
        $Type : 'UI.DataPointType',
        Value : score,
        Title : '{i18n>Score}',
        TargetValue : 5,
        Visualization : #Rating,
    },
    UI.DataPoint #score : {
        Value : score,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.createReview',
            Label : '{i18n>LeaveAReview}',
        },
    ],
    Communication.Contact #contact : {
        $Type : 'Communication.ContactType',
        fn : ownerFullName,
    },
    UI.DataPoint #score1 : {
        Value : score,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>AvailableHotels}',
    },
);

annotate service.Hotels with {
    owner @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Users',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : owner_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'surname',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'phone',
            },
        ],
    }
};

annotate service.Hotels with {
    location @(
        Common.Label : '{i18n>Location}',
        Common.FieldControl : #Mandatory,
        )
};

annotate service.Hotels with {
    rating @Common.Label : '{i18n>Rating}'
};

annotate service.Rooms with @(
    UI.LineItem #i18nHotelRooms : [
        {
            $Type : 'UI.DataField',
            Value : imageUrl,
            Label : '{i18n>Preview}',
        },
        {
            $Type : 'UI.DataField',
            Value : number,
            Label : 'Number',
        },
        {
            $Type : 'UI.DataField',
            Value : type,
            Label : '{i18n>Type}',
        },
        {
            $Type : 'UI.DataField',
            Value : capacity,
            Label : '{i18n>Capacity}',
        },
        {
            $Type : 'UI.DataField',
            Value : price,
            Label : '{i18n>Price}',
        },
        {
            $Type : 'UI.DataField',
            Value : currency_code,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>RoomDetails}',
            ID : 'i18nRoomDetails',
            Target : '@UI.FieldGroup#i18nRoomDetails',
        },
    ],
    UI.FieldGroup #i18nMakeAReservation : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
    UI.SelectionPresentationVariant #i18nHotelRooms : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#i18nHotelRooms',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
    UI.SelectionPresentationVariant #i18nHotelRooms1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#i18nHotelRooms',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : imageUrl,
                    Descending : false,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
    UI.HeaderInfo : {
        TypeName : '{i18n>SelectedRoomsDetails}',
        TypeNamePlural : '',
        Title : {
            $Type : 'UI.DataField',
            Value : number,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : '{i18n>SelectedRoomNumber}',
        },
        ImageUrl : imageUrl,
    },
    UI.FieldGroup #i18nRoomDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : number,
                Label : '{i18n>RoomNumber}',
            },
            {
                $Type : 'UI.DataField',
                Value : type,
                Label : '{i18n>Type}',
            },
            {
                $Type : 'UI.DataField',
                Value : capacity,
                Label : '{i18n>Capacity}',
            },
            {
                $Type : 'UI.DataFieldForAnnotation',
                Target : '@UI.ConnectedFields#connected',
                Label : '{i18n>Price}',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'CatalogService.makeReservation',
                Label : '{i18n>MakeAReservation}',
            },
        ],
    },
    UI.ConnectedFields #connected : {
        $Type : 'UI.ConnectedFieldsType',
        Template : '{price}-{currency_code}',
        Data : {
            $Type : 'Core.Dictionary',
            price : {
                $Type : 'UI.DataField',
                Value : price,
            },
            currency_code : {
                $Type : 'UI.DataField',
                Value : currency_code,
            },
        },
    },
    UI.HeaderFacets : [
        
    ],
    UI.FieldGroup #RoomDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : imageUrl,
                Label : '{i18n>ImageUrl}',
            },
            {
                $Type : 'UI.DataField',
                Value : number,
                Label : 'Room Number',
            },
            {
                $Type : 'UI.DataField',
                Value : type,
                Label : 'Type',
            },
            {
                $Type : 'UI.DataField',
                Value : capacity,
                Label : 'Capacity',
            },
            {
                $Type : 'UI.DataField',
                Value : price,
                Label : '{i18n>Price}',
            },
            {
                $Type : 'UI.DataField',
                Value : currency_code,
            },
        ],
    },
);

annotate service.Rooms with {
    imageUrl @(
        Common.FieldControl : #Optional,
        UI.IsImageURL : true,
    )
};

annotate service.Reviews with @(
    UI.LineItem #i18nReviews : [
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#rating1',
            Label : '{i18n>Rating}',
        },
        {
            $Type : 'UI.DataField',
            Value : date,
            Label : '{i18n>Date}',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : '{i18n>Text}',
        },
        {
            $Type : 'UI.DataField',
            Value : reviewerEmail,
            Label : '{i18n>ReviewerEmail}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.removeReview',
            Label : '{i18n>RemoveAReview}',
            Inline : true,
            Criticality : #Negative,
            @UI.Importance : #High,
        },
    ],
    UI.DataPoint #score : {
        Value : score,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.DataPoint #rating : {
        Value : rating,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.DataPoint #rating1 : {
        Value : rating,
        Visualization : #Rating,
        TargetValue : 5,
    },
);
annotate service.Hotels with {
    imageUrl @(
        Common.FieldControl : #Mandatory,
        )
};

annotate service.Hotels with {
    name @Common.FieldControl : #Mandatory
};

annotate service.Hotels with {
    description @(
        Common.FieldControl : #Mandatory,
        UI.MultiLineText : true,
    )
};

annotate service.Hotels with {
    ownerFullName @Common.FieldControl : #Mandatory
};

annotate service.Hotels with {
    phone @Common.FieldControl : #Mandatory
};

annotate service.Hotels with {
    email @Common.FieldControl : #Mandatory
};

annotate service.Bookings with @(
    UI.LineItem #tableView : [
        {
            $Type : 'UI.DataField',
            Value : room.imageUrl,
            Label : '{i18n>RoomImage}',
        },
        {
            $Type : 'UI.DataField',
            Value : room.number,
            Label : '{i18n>RoomNumber}',
        },
        {
            $Type : 'UI.DataField',
            Value : room.capacity,
            Label : '{i18n>Capacity}',
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
            Label : '{i18n>CheckinDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
            Label : '{i18n>CheckoutDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : room.hotel.location,
        },
        {
            $Type : 'UI.DataField',
            Value : room.hotel.phone,
            Label : '{i18n>Phone}',
        },
        {
            $Type : 'UI.DataField',
            Value : totalPrice,
            Label : '{i18n>TotalPrice}',
        },
        {
            $Type : 'UI.DataField',
            Value : bookingStatus,
            Label : '{i18n>Status}',
        },
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>YourBookings}',
    },
    UI.LineItem #tableView1 : [
        {
            $Type : 'UI.DataField',
            Value : room.imageUrl,
            Label : '{i18n>RoomImage}',
        },
        {
            $Type : 'UI.DataField',
            Value : room.number,
            Label : '{i18n>RoomNumber}',
        },
        {
            $Type : 'UI.DataField',
            Value : room.capacity,
            Label : '{i18n>Capacity}',
        },
        {
            $Type : 'UI.DataField',
            Value : room.hotel.location,
        },
        {
            $Type : 'UI.DataField',
            Value : room.hotel.phone,
            Label : '{i18n>HotelPhone}',
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
            Label : '{i18n>CheckinDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
            Label : '{i18n>CheckoutDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : totalPrice,
            Label : '{i18n>TotalPrice}',
        },
        {
            $Type : 'UI.DataField',
            Value : bookingStatus,
            Label : '{i18n>Status}',
        },
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView1',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>YourBookings}',
    },
    UI.LineItem #tableView2 : [
        {
            $Type : 'UI.DataField',
            Value : room.imageUrl,
            Label : 'Room Image',
        },
        {
            $Type : 'UI.DataField',
            Value : room.number,
            Label : 'Room Number',
        },
        {
            $Type : 'UI.DataField',
            Value : room.capacity,
            Label : 'Capacity',
        },
        {
            $Type : 'UI.DataField',
            Value : room.hotel.location,
        },
        {
            $Type : 'UI.DataField',
            Value : room.hotel.phone,
            Label : 'Hotel Phone',
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
            Label : 'Check-in Date',
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
            Label : 'Check-out Date',
        },
        {
            $Type : 'UI.DataField',
            Value : totalPrice,
            Label : 'Total Price',
        },
        {
            $Type : 'UI.DataField',
            Value : bookingStatus,
            Label : 'Booking Status',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.cancelReservation',
            Label : 'Cancel the Reservation',
            Inline : true,
            Criticality : #Negative,
            @UI.Importance : #High,
        },
    ],
    UI.SelectionPresentationVariant #tableView2 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView2',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>YourBookings}',
    },
);

annotate service.Rooms with {
    number @Common.FieldControl : #Mandatory
};

annotate service.Rooms with {
    type @Common.FieldControl : #Mandatory
};

annotate service.Rooms with {
    capacity @Common.FieldControl : #Mandatory
};

annotate service.Rooms with {
    price @Common.FieldControl : #Mandatory
};

annotate service.Rooms with {
    currency @Common.FieldControl : #Mandatory
};

