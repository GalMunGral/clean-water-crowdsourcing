//
//  WaterReport.swift
//  CleanWaterCrowdsourcing
//
//  Created by Wenqi He on 7/11/17.
//  Copyright © 2017 Wenqi He. All rights reserved.
//

import Foundation
import CoreLocation

class WaterReport {
    let reportId: Int
    let coordinate: CLLocationCoordinate2D
    let quality: WaterQuality
    
    init(reportId: Int, coordinate: CLLocationCoordinate2D, quality: WaterQuality) {
        self.reportId = reportId
        self.coordinate = coordinate
        self.quality = quality
    }
}
