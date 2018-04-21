//
//  Helper.swift
//  CleanWaterCrowdsourcing
//
//  Created by Wenqi He on 7/9/17.
//  Copyright © 2017 Wenqi He. All rights reserved.
//

import Foundation
import GoogleMaps

extension CLLocationCoordinate2D {
    static func == (left: CLLocationCoordinate2D, right: CLLocationCoordinate2D) -> Bool {
        return left.latitude == right.latitude && left.longitude == right.longitude
    }
    
}
