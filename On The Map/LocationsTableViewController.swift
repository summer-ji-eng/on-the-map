//
//  LocationsTableViewController.swift
//  On The Map
//
//  Created by Yang Ji on 8/31/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {
    
    //MARK: Properties
    
    private let otmDataSource = SharedData.sharedDataSource()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = otmDataSource
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LocationsTableViewController.studentLocationDidUpdate), name: "\(parseClient.Methods.StudentLocation)\(parseClient.Notifications.LocationsUpdatedError)", object: nil)
        
    }
    
    //MARK: Data Source
    func studentLocationDidUpdate() {
        tableView.reloadData()
    }
    
    // MARK: Display Alert
    
    private func displayAlert(message: String) {
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: AppConstant.AlertActions.Dismiss, style: .Cancel, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }

    //MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let studentMediaURL = otmDataSource.studentLocations[indexPath.row].student.mediaURL
        
        if let url = NSURL(string: studentMediaURL) {
            if UIApplication.sharedApplication().canOpenURL(url) {
                UIApplication.sharedApplication().openURL(url)
            } else {
                displayAlert(AppConstant.Errors.CannotOpenURL)
            }
        }
        
    }

}