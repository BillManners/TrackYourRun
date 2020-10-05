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
    var timeCountHours: String = ""
    var timeCountMinutes: String = ""
    var timeCountSeconds: String = ""
    var timeCountDisplay: String = ""
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(masterLoop), userInfo: nil, repeats: true)
        speechTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(speechTracker), userInfo: nil, repeats: true)
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationTimer!.tolerance = 0.1
    }
    
    @IBAction func RunStopButton() {
        locationTimer!.invalidate()
        speechTimer!.invalidate()
    }
    
    
    @objc func speechTracker() {
        
    }
    
    
    @objc func masterLoop() {
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
        currentLocation.text = locationManager.requestLocation()
        
        
    }


}

