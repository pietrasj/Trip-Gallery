//
//  TbleViewControllerTripInfo.swift
//  Trip Gallery
//
//  Created by Jayne Pietraszkiewicz on 25/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

class TbleViewControllerTripInfo: UITableViewController {

    var trip : Trip?
    
    @IBOutlet weak var tripDate: UITextField!
    @IBOutlet weak var tripDuration: UITextField!
    @IBOutlet weak var tripDestination: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    // save changes if the user modified the trip data
    @IBAction func saveTripInfo(_ sender: Any) {
        trip!.tripDate = Utilities.dateFormatter.date(from: tripDate.text!)!
        trip!.tripDuration = Int(tripDuration.text!)!
        trip!.tripDestination = tripDestination.text!
    }
    
    // set the trip details as passed from the trips list view
    override func viewWillAppear(_ animated: Bool) {
        if trip != nil {
            tripDate.text = Utilities.dateFormatter.string(for: trip!.tripDate)
            tripDestination.text = trip!.tripDestination
            tripDuration.text = "\(trip!.tripDuration)"
            print(trip!.tripDate)
            print(trip!.tripDestination)
        }
    }

}
