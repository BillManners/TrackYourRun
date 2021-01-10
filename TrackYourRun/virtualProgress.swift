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
    let speechSynthesiser = SpeechSynthesiser()
    var thirtySecondsAnnounced = false
    init() {
        unstartedSegments = []
        completedSegments = []
        startTime = Date.init()
        segmentDistance = 0
        currentSegment = runSegment(segLength: 0.001, segTime: 0.001)
        //TODO find an alternate solution to startTime = Date.init()
    }
    
    func addNewSegment(segment: runSegment){
        unstartedSegments.insert(segment, at: 0)
    }
    
    func moveForward(timeChange:Double){
        let positionChange = timeChange*currentSegment.speed
        segmentDistance += positionChange
        checkForSegmentChange()
    }
    
    func checkForSegmentChange(){
        let thirtySecondsDistance = currentSegment.speed*30
        var announcement = "Run will end in 30 seconds"

        if unstartedSegments.count > 0 {
            if segmentDistance + thirtySecondsDistance >= currentSegment.length && thirtySecondsAnnounced == false{
                announcement = segmentChangeVoiceMessages(endOfSegment: false)
                thirtySecondsAnnounced = true
                //announce new segment in 30 secs at pace xxx (up/down from yyy)
            }
        }
        if segmentDistance >= currentSegment.length{
            completedSegments.append(currentSegment)
            if unstartedSegments.count == 0{
                announcement = "Run has finished"
                //finish run
            } else {
                currentSegment = unstartedSegments.popLast()!
                thirtySecondsAnnounced = false
                announcement = segmentChangeVoiceMessages(endOfSegment: true)
            }
        }
        speechSynthesiser.Speak(textToSpeak: announcement)
    }
    
    func segmentChangeVoiceMessages(endOfSegment: Bool)->String {
        var changeDirection = "An error has occurred"
        var announcement = "An error has occurred"
        let currentPace = String( format: "%.1f", currentSegment.speed)
        let newPace = String( format: "%.1f", unstartedSegments.last!.speed)
        if currentSegment.speed > unstartedSegments.last!.speed{
            changeDirection = "down"
        } else {
            changeDirection = "up"
        }
        if endOfSegment {
            announcement = ("New segment is starting now at " + newPace + "metres per second, " + changeDirection + " from " + currentPace)
        } else {
            announcement = ("New segment begins in 30 seconds at " + newPace + "metres per second, " + changeDirection + " from " + currentPace)
        }
        return (announcement)
    }
}
