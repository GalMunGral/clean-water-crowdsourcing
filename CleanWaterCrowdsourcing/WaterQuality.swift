//
//  WaterQuality.swift
//  CleanWaterCrowdsourcing
//
//  Created by Wenqi He on 7/11/17.
//  Copyright © 2017 Wenqi He. All rights reserved.
//

import Foundation

enum WaterQuality: String {
    case safe = "Safe"
    case treatable = "Treatable"
    case unsafe = "Unsafe"
    
    static let allValues: [WaterQuality] = [.safe, .treatable, .unsafe]
}
