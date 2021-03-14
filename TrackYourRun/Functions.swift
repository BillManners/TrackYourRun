//
//  handyFunctions.swift
//  TrackYourRun
//
//  Created by Manners, William (Coll) on 10/01/2021.
//  Copyright © 2021 Manners, William (Coll). All rights reserved.
//

import Foundation

struct Functions{
    func roundToPrecision(_ value: Double, toNearest: Double) -> Double {
            return round(value / toNearest) * toNearest
    }
}
