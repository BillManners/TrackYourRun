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
    var segmentDistance: Double
    var unstartedSegments: [runSegment]
    var completedSegments: [runSegment]
    let startTime: Date
    var thirtySecondsAnnounced = false
    init(runSegments: [runSegment]) {
        unstartedSegments = runSegments
        completedSegments = []
        currentSegment = unstartedSegments.popLast()!
        startTime = Date.init()
        segmentDistance = 0
    }
    
    func moveForward(timeChange:Double){
        let positionChange = timeChange*currentSegment.speed
        segmentDistance += positionChange
        checkForSegmentChange()
    }
    
    func checkForSegmentChange(){
        let thirtySecondsDistance = currentSegment.speed * 30
        var changeDirection = "hi"
        if unstartedSegments.count == 0{
            //do nothing
        } else {
            if segmentDistance + thirtySecondsDistance >= currentSegment.length && thirtySecondsAnnounced == false{
                let currentPace = String( format: "%.1f", currentSegment.speed)
                let newPace = String( format: "%.1f", unstartedSegments.last!.speed)
                if currentSegment.speed > unstartedSegments.last!.speed{
                    changeDirection = "down"
                } else {
                    changeDirection = "up"
                }
                
                let announcement = ("New segment begins in 30 seconds at ", newPace, "metres per second, ",changeDirection," from ", currentPace)
                //announce new segment in 30 secs at pace xxx (up/down from yyy)
            }
        }
        if segmentDistance >= currentSegment.length{
            completedSegments.append(currentSegment)
            if unstartedSegments.count == 0{
                //finish run
            } else {
                currentSegment = unstartedSegments.popLast()!
                thirtySecondsAnnounced = false
                //announce new segment at pace xxx (up/down from yyy)
            }
            }
    }
}
