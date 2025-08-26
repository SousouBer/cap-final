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
                Label : 'rating',
                Value : rating,
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
            Label : '{i18n>TheListOfRooms}',
            ID : 'i18nTheListOfRooms',
            Target : '@UI.FieldGroup#i18nTheListOfRooms',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>HotelRooms}',
            ID : 'i18nHotelRooms',
            Target : 'rooms/@UI.LineItem#i18nHotelRooms',
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
            Target : '@UI.DataPoint#rating',
            Label : '{i18n>Rating}',
        },
    ],
    UI.DataPoint #rating : {
        Value : rating,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.SelectionFields : [
        location,
        rating,
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
            ID : 'rating',
            Target : '@UI.DataPoint#rating1',
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
    ]
);

annotate service.Rooms with {
    imageUrl @UI.IsImageURL : true
};

