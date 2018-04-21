//
//  DataViewController.swift
//  CleanWaterCrowdsourcing
//
//  Created by Wenqi He on 7/11/17.
//  Copyright © 2017 Wenqi He. All rights reserved.
//

import UIKit
import CoreLocation

class NetworkTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        // Do any additional setup after loading the view.
        appDelegate.ref.child("reports").observe(.value, with: { (snapshot) in
            guard let arrayOfReports = snapshot.value as? NSArray else { return }
            self.appDelegate.reports = []
            for (reportId, reportDictionary) in arrayOfReports.enumerated() {
                // Checks that the item is a valid report
                if let reportDictionary = reportDictionary as? [String: Any],
                    let latitude = reportDictionary["latitude"] as? Double,
                    let longitude = reportDictionary["longitude"] as? Double,
                    let qualityString = reportDictionary["quality"] as? String,
                    let quality = WaterQuality(rawValue: qualityString) {
                    // Store data in the array
                    let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                    self.appDelegate.reports.append(WaterReport(reportId: reportId, coordinate: coordinate, quality: quality))
                    // Refresh map view
                    if let mapViewController = self.viewControllers?[0] as? MapViewController {
                        mapViewController.createMarker(coordinate: coordinate)
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let fromView = tabBarController.selectedViewController!.view!
        let toView = viewController.view!
        let fromIndex = tabBarController.selectedIndex
        let toIndex = tabBarController.viewControllers!.index(of: viewController)!
        
        guard fromIndex != toIndex else { return false}
        
        // Add the toView to the tab bar view
        fromView.superview!.addSubview(toView)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width;
        let scrollRight = toIndex > fromIndex;
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: fromView.center.y)
        
        // Disable interaction during animation
        tabBarController.view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            // Slide the views by -offset
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y);
            toView.center   = CGPoint(x: toView.center.x - offset, y: toView.center.y);
            
        }, completion: { finished in
            
            // Remove the old view from the tabbar view.
            fromView.removeFromSuperview()
            tabBarController.selectedIndex = toIndex
            tabBarController.view.isUserInteractionEnabled = true
        })
        
        return true
    }
    
}
