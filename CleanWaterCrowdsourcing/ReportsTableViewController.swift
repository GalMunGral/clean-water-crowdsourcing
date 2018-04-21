//
//  ReportsTableViewController.swift
//  CleanWaterCrowdsourcing
//
//  Created by Wenqi He on 7/8/17.
//  Copyright © 2017 Wenqi He. All rights reserved.
//

import UIKit
import CoreLocation

class ReportsTableViewController: UITableViewController {
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var qualityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.tabBarController!.tabBar.frame.size.height, right: 0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func refreshControllActivated(_ sender: UIRefreshControl) {
        self.tableView.reloadData()
        sender.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return appDelegate.reports.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath)
        let reports = appDelegate.reports
        // Present data in reverse order
        let report = reports[reports.count-1 - indexPath.section]
        let coordinate = report.coordinate
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Latitude:"
            cell.detailTextLabel?.text = String(coordinate.latitude)
        case 1:
            cell.textLabel?.text = "Longitude:"
            cell.detailTextLabel?.text = String(coordinate.longitude)
        case 2:
            cell.textLabel?.text = "Quality:"
            cell.detailTextLabel?.text = report.quality.rawValue
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Label reports in reverse order
        return "Report #\(appDelegate.reports.count-1 - section)"
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddReportSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addEditReportTableViewController = navigationController.topViewController as! AddEditReportTableViewController
            addEditReportTableViewController.navigationItem.title = "New Report"
            if let mapViewController = self.tabBarController?.viewControllers?[0] as? MapViewController,
                let myLocation = mapViewController.mapView.myLocation {
                let newReport = WaterReport(reportId: appDelegate.nextId, coordinate: myLocation.coordinate, quality: .safe)
                addEditReportTableViewController.waterReport = newReport
                addEditReportTableViewController.isEditingExistingReport = false
            }
        } else if segue.identifier == "EditReportSegue" {
            let addEditReportTableViewController = segue.destination as! AddEditReportTableViewController
            let selectedCell = sender as! UITableViewCell
            let selectedIndexPath = self.tableView.indexPath(for: selectedCell)!
            let reportList = appDelegate.reports
            let selectedReport = reportList[reportList.count-1 - selectedIndexPath.section]
            addEditReportTableViewController.waterReport = selectedReport
            addEditReportTableViewController.isEditingExistingReport = true
        }
    }
    
}
