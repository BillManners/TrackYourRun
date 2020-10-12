//
//  segment.swift
//  TrackYourRun
//
//  Created by Manners, William (Coll) on 12/10/2020.
//  Copyright © 2020 Manners, William (Coll). All rights reserved.
//

import Foundation

class runSegment{
    let length: Int
    let speed: Double
    let time: Int
    init(segLength: Int, segSpeed: Double, segTime: Int) {
        if Double(segLength)/Double(segTime) == segSpeed{
            length = segLength
            speed = segSpeed
            time = segTime
        } else {
            length = segLength
            time = segTime
            speed = Double(segLength)/Double(segTime)
        }
    }
}
