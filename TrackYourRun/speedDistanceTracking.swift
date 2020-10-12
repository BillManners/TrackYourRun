//
//  speedDistanceTracking.swift
//  TrackYourRun
//
//  Created by Manners, William (Coll) on 03/10/2020.
//  Copyright © 2020 Manners, William (Coll). All rights reserved.
//

import Foundation
import CoreLocation

class speedDistanceTracking{
    var distance = 0
    var averageSpeed: Double
    var previousLocations = [CLLocation]()
    var previousLocationTimes = [Date]()
    var previousDifferences = [Double]()
    let startTime: Date
    
    init(){
        distance = 0
        averageSpeed = 0
        previousLocations = []
        previousLocationTimes = []
        previousDifferences = [0]
        startTime = Date.init()
    }
    
    func locationUpdate(location: CLLocation)->(Double,Double,Double){
        let location1: CLLocation
        let currentAverage: Double
        let currentTime = Date.init()
        let runTime = currentTime.timeIntervalSince(startTime)
        let timeSinceLastPoint = currentTime.timeIntervalSince(previousLocationTimes.last ?? currentTime)
        if previousLocations.count > 0{
            location1 = previousLocations.last!
        } else {
            location1 = location
        }
        previousLocations.append(location)
        previousLocationTimes.append(currentTime)
        let location2 = previousLocations.last
        let distanceSinceLastPoint = location1.distance(from: location2!)
        averageSpeed = ((runTime-timeSinceLastPoint)*averageSpeed+distanceSinceLastPoint)/(runTime)
        previousDifferences.append(distanceSinceLastPoint)
        var currentAverageTotal = 0.00
        if previousLocationTimes.count >= 5{
            for i in 1...5 {
                currentAverageTotal += previousDifferences[previousDifferences.endIndex-i]
            
            }
            let timeCurrentAverageIsGoingFor = currentTime.timeIntervalSince(previousLocationTimes[previousLocationTimes.endIndex-5])
            currentAverage = currentAverageTotal/timeCurrentAverageIsGoingFor
        } else {
            currentAverage = averageSpeed
        }
        let totalDistance = previousDifferences.reduce(0, +)

        return (currentAverage, averageSpeed,totalDistance)
    }
    
}
