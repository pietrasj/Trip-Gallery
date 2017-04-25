//
//  TripAnnotation.swift
//  Trip Gallery
//
//  Created by Jayne Pietraszkiewicz on 25/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import MapKit

class TripAnnotation: NSObject, MKAnnotation {

    var tridId : Int
    var title : String?
    var subtitle : String?
    var coordinate : CLLocationCoordinate2D
    var img : UIImage?
    
    init(tripId : Int, trip : Trip, coordinate : CLLocationCoordinate2D) {
        self.tridId = tripId
        self.title = trip.tripDestination
        self.subtitle = "\(trip.tripDate)"
        self.coordinate = coordinate
        self.img = trip.destinationImage
    }
}
