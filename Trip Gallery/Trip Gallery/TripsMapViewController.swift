//
//  TripsMapViewController.swift
//  Trip Gallery
//
//  Created by Jayne Pietraszkiewicz on 25/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import MapKit

class TripsMapViewController: UIViewController, LocationObserver, MKMapViewDelegate {

    @IBOutlet weak var tripsMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load trips from the Utilities class
        Utilities.loadTrips()
        // set the mapkitview delegate to the TripsMapViewController
        self.tripsMap.delegate = self
        
        // centre the map around current user location
        tripsMap.setCenter(tripsMap.userLocation.coordinate, animated: true)
        
        // add a pin to the map for each trip
        for i in 0 ... Utilities.trips.count - 1 {
            let trip = Utilities.trips[i]
            
            // CLGeocoder helps to convert trip destination to coordinates
            CLGeocoder().geocodeAddressString(trip.tripDestination, completionHandler:  {
                // this is a closure (function), called after resolving the coordinates of the destination
                (placeMark, error) in
                let tripLocation = placeMark![0].location?.coordinate
                self.tripsMap.addAnnotation(TripAnnotation(tripId: i, trip: trip, coordinate: tripLocation!))
                }
            )
        
        }
        
        LocationService.shared.registerLocationObserver(locationObserver: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // get id of the annotationView (same as TableCell last week)
        let reuseId = "tripAnnotation"
        
        // if this annotation to view is not TripAnnotation don't continue
        let tripAnnotation : TripAnnotation? = (annotation as? TripAnnotation)
        if tripAnnotation == nil {
            return nil
        }
        
        // get a reusable AnnotationView item
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        // if nil, means first time to use this annotation
        if annotationView == nil {
            // creat a new object, and set image, and add a button to show more details
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            annotationView?.image = tripAnnotation?.img
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            annotationView?.canShowCallout = true
            
        } else {
            annotationView!.annotation = tripAnnotation
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // I get the selected annotationView, get annotation included, and get TripId
        // TripId is the index of the trip in the trips array
        let selectedTrip = Utilities.trips[(view.annotation as! TripAnnotation).tridId]
        
        // init the tripInfo viewController. Note "tripInfo" is the view controller ID
        // to do so you need to select the trip Info screen and set its identifier
        let tripInfoVC = (self.storyboard?.instantiateViewController(withIdentifier: "tripInfo") as! TbleViewControllerTripInfo)
        
        // now pass the selectTrip
        tripInfoVC.trip = selectedTrip
        
        // show the trip info screen
        self.present(tripInfoVC, animated: true, completion: nil)
    }
    
    func locationDidChange(newLocations: [CLLocation]) {
        self.tripsMap.setCenter(newLocations[0].coordinate, animated: true)
    }

}
