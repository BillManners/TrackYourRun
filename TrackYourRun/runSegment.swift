//
//  segment.swift
//  TrackYourRun
//
//  Created by Manners, William (Coll) on 12/10/2020.
//  Copyright © 2020 Manners, William (Coll). All rights reserved.
//

import Foundation

class runSegment{
    let length: Double
    let speed: Double
    let time: Double
    init(segLength: Double, segTime: Double) {
            length = segLength
            time = segTime
            speed = segLength/segTime
        
    }
    
}
