//
//  ViewController.swift
//  TrackYourRun
//
//  Created by Manners, William (Coll) on 28/09/2020.
//  Copyright © 2020 Manners, William (Coll). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timerCount: UILabel!
    var timeCount = 0
    var terminateTimer = false
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(masterLoop), userInfo: nil, repeats: true)

        timer!.tolerance = 0.1
    }
    
    @IBAction func StartStopButton() {
        terminateTimer = true
    }
    
    @objc func masterLoop() {
        timerCount.text = String(timeCount)
        timeCount+=1
        if terminateTimer{
            timer!.invalidate()
        }
    }


}

