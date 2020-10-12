//
//  virtualProgress.swift
//  TrackYourRun
//
//  Created by Manners, William (Coll) on 12/10/2020.
//  Copyright © 2020 Manners, William (Coll). All rights reserved.
//

import Foundation

class virtualProgress{
    var currentSegment: runSegment
    var unstartedSegments: [runSegment]
    var completedSegments: [runSegment]
    let currentTime: Date
    init(runSegments: [runSegment]) {
        unstartedSegments = runSegments
        completedSegments = []
        currentSegment = unstartedSegments.popLast()!
        currentTime = Date.init()
    }
    
    func timePass{
        let timePassed = currentTime.tims
    }
    
    func checkForSegmentChange(){
        
    }
}
