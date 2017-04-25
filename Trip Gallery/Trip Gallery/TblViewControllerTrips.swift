//
//  TblViewControllerTrips.swift
//  Trip Gallery
//
//  Created by Jayne Pietraszkiewicz on 25/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

class TblViewControllerTrips: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.loadTrips()
        // push the table view below the bar
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // how many sections in my table - currently I want one section
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // how many rows trips in my array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Utilities.trips.count;
    }

    // fill the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        cell.textLabel?.text = "\(Utilities.trips[indexPath.row].tripDestination), \(Utilities.trips[indexPath.row].tripDuration)"
        cell.detailTextLabel?.text = "\(Utilities.dateFormatter.string(from: Utilities.trips[indexPath.row].tripDate))"
        cell.imageView?.image = Utilities.trips[indexPath.row].destinationImage
        return cell
    }
    
    // Trigger the segue for the selected cell, and send the trip object to the details view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueTripDetails", sender: Utilities.trips[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // I created a segue from the cell to the Trip Info and changed the identifier to segueTripDetails
        
        if segue.identifier == "segueTripDetails" {
            (segue.destination as! TbleViewControllerTripInfo).trip = (sender as! Trip)
        }
    }
    
    // called in the unwind segue - exit Trip Info
    @IBAction func unWindSegue(segue : UIStoryboardSegue)
    {
            self.tableView.reloadData()
    }

    
    // editing table view - tap laft on the table to see
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Utilities.trips.remove(at: indexPath.row)
            // Delete the row from the data source
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
