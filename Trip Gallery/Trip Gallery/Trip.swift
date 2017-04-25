//
//  Trip.swift
//  Trip Gallery
//
//  Created by Jayne Pietraszkiewicz on 25/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import Foundation
import UIKit

class Trip {
    var tripDate : Date
    var tripDuration : Int
    var tripDestination : String
    var destinationImage : UIImage
    
    init(date : Date, duration : Int, destination : String, img : UIImage) {
        
        self.tripDate = date
        self.tripDuration = duration
        self.tripDestination = destination
        self.destinationImage = img
    }
}

class Utilities {
    static var dateFormatter = DateFormatter()
    static var trips : [Trip] = []
    static func loadTrips() {
        dateFormatter.dateFormat = "dd/mm/yy"
        trips = [
            Trip(date: dateFormatter.date(from: "24/04/17")!, duration: 2, destination: "Melbourne", img: UIImage(named: "Melbourne")!),
            Trip(date: dateFormatter.date(from: "24/05/17")!, duration: 2, destination: "Sydney", img: UIImage(named: "Sydney")!)
        ]
    }
}
