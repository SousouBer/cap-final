sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sap/capire/hotelbooking/hotels/test/integration/FirstJourney',
		'sap/capire/hotelbooking/hotels/test/integration/pages/HotelsList',
		'sap/capire/hotelbooking/hotels/test/integration/pages/HotelsObjectPage'
    ],
    function(JourneyRunner, opaJourney, HotelsList, HotelsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sap/capire/hotelbooking/hotels') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheHotelsList: HotelsList,
					onTheHotelsObjectPage: HotelsObjectPage
                }
            },
            opaJourney.run
        );
    }
);