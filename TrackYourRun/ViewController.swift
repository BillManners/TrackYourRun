//
//  ViewController.swift
//  TrackYourRun
//
//  Created by Manners, William (Coll) on 28/09/2020.
//  Copyright © 2020 Manners, William (Coll). All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var timerCount: UILabel!
    @IBOutlet var currentLocation: UILabel!
    var timeCount = 0
    var terminateTimer = false
    var locationTimer: Timer?
    var speechTimer: Timer?
    var TimerPaused =  true
    var timeCountHours: String = ""
    var timeCountMinutes: String = ""
    var timeCountSeconds: String = ""
    var timeCountDisplay: String = ""
    var averagePace: Double = 0
    var currentPace: Double = 0
    var totalDistance: Double = 0
    var distanceSinceLastPoint: CLLocationDistance?
    let locationManager = CLLocationManager()
    let speedAndDistance = speedDistanceTracking()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestAlwaysAuthorization()
        speechTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(masterLoop), userInfo: nil, repeats: true)
        locationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(masterLoop), userInfo: nil, repeats: true)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    
    
    @IBAction func RunStopButton() {
        if TimerPaused{
            TimerPaused = false
        } else {
            TimerPaused = true
        }

        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last{
            (currentPace,averagePace,totalDistance) = speedAndDistance.locationUpdate(location: lastLocation)
        }
    }
    

    
    @objc func speechTracker() {
        
    }
        
    @objc func masterLoop() {
        if TimerPaused{
            return
        }
        timeCountHours = String(timeCount/3600) + ":"
        timeCountMinutes = String((timeCount%3600)/60) + ":"
        timeCountSeconds = String(timeCount%60)
        if timeCountHours.count < 3{
            timeCountHours = "0" + timeCountHours
        }
        if timeCountMinutes.count < 3{
            timeCountMinutes = "0" + timeCountMinutes
        }
        if timeCountSeconds.count < 2{
            timeCountSeconds = "0" + timeCountSeconds
        }
        timeCountDisplay = timeCountHours+timeCountMinutes+timeCountSeconds
        timerCount.text = timeCountDisplay
        timeCount+=1
        locationManager.requestLocation()
        
        
    }


}

