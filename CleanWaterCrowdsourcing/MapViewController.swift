//
//  ViewController.swift
//  CleanWaterCrowdsourcing
//
//  Created by Wenqi He on 7/8/17.
//  Copyright © 2017 Wenqi He. All rights reserved.
//

import UIKit
import GoogleMaps
import FirebaseDatabase

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    var appDelegate: AppDelegate!
    var mapView: GMSMapView!
    var markers: [GMSMarker] = []
    
    override func loadView() {
        // Sets up map view
        let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 1.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.indoorPicker = false
        self.view = mapView
        mapView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Adjusts the frame of mapView
        mapView.padding = UIEdgeInsetsMake(0.0, 0.0, self.tabBarController!.tabBar.frame.size.height, 0.0)
        addObserver(self, forKeyPath: #keyPath(mapView.myLocation), options: [.new], context: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let currentCoordinate = self.mapView.myLocation?.coordinate {
           self.moveCamera(to: currentCoordinate)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MapViewDelegate methods
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.performSegue(withIdentifier: "AddReportSegue", sender: coordinate)
    }
    
    func createMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = self.mapView
        markers.append(marker)
    }
    
    // Observer methods
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(mapView.myLocation) {
            let newLocation = change![.newKey] as! CLLocation
            self.moveCamera(to: newLocation.coordinate)
        }
    }
    
    func moveCamera(to coordinate: CLLocationCoordinate2D) {
        // Slow animation
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        self.mapView.animate(to: GMSCameraPosition(target: coordinate, zoom: 15.0, bearing: CLLocationDirection(0.0), viewingAngle: 0.0))
        CATransaction.commit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddReportSegue" {
            let navigationController = segue.destination as! UINavigationController
            if let addEditReportTableViewController = navigationController.visibleViewController as? AddEditReportTableViewController {
                addEditReportTableViewController.navigationItem.title = "New Report"
                addEditReportTableViewController.waterReport = WaterReport(reportId: appDelegate.nextId, coordinate: sender as! CLLocationCoordinate2D, quality: .safe)
                addEditReportTableViewController.isEditingExistingReport = false
            }
        }
    }
    
}
