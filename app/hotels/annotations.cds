using CatalogService as service from '../../srv/cat-service';
using from '@sap/cds/common';

annotate service.Hotels with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'location',
                Value : location,
            },
            {
                $Type : 'UI.DataField',
                Value : score,
                Label : '{i18n>Score}',
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
            Target : '@UI.DataPoint#score',
        },
    ],
    UI.DataPoint #rating : {
        Value : rating,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.SelectionFields : [
        location,
        score,
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
            Action : 'CatalogService.EntityContainer/createReview',
            Label : 'createReview',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.createReview',
            Label : '{i18n>LeaveAReview}',
        },
    ],
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
        {
            $Type : 'UI.DataField',
            Value : currency.symbol,
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : '{i18n>Status}',
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
                $Type : 'UI.DataField',
                Value : price,
                Label : '{i18n>Price}',
            },
            {
                $Type : 'UI.DataField',
                Value : currency_code,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'CatalogService.EntityContainer/makeReservation',
                Label : '{i18n>BookTheRoom}',
            },
        ],
    },
);

annotate service.Rooms with {
    imageUrl @UI.IsImageURL : true
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
            Value : reviewer.name,
            Label : '{i18n>ReviewerName}',
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
