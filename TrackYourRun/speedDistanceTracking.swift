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
    var previousDifferences = [Double]()
    
    init(){
        distance = 0
        averageSpeed = 0
        previousLocations = []
        previousDifferences = [0]
        
    }
    
    func locationUpdate(location: CLLocation)->(Double,Double,Double){
        let location1: CLLocation
        let currentAverage: Double
        if previousLocations.count > 0{
            location1 = previousLocations.last!
        } else {
            location1 = location
        }
        previousLocations.append(location)
        let location2 = previousLocations.last
        let distanceSinceLastPoint = location1.distance(from: location2!)
        averageSpeed = (Double(previousDifferences.count)*averageSpeed+distanceSinceLastPoint)/(Double(previousDifferences.count)+1)
        previousDifferences.append(distanceSinceLastPoint)
        var currentAverageTotal = 0.00
        if previousDifferences.count >= 5{
            for i in 1...5 {
                currentAverageTotal += previousDifferences[previousDifferences.endIndex-i]
            
            }
            currentAverage = currentAverageTotal/5
        } else {
            currentAverage = averageSpeed
        }
        let totalDistance = previousDifferences.reduce(0, +)
        return (currentAverage, averageSpeed,totalDistance)
    }
    
}
