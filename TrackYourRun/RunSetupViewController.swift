//
//  RunSetupViewController.swift
//  TrackYourRun
//
//  Created by Manners, William (Coll) on 07/01/2021.
//  Copyright © 2021 Manners, William (Coll). All rights reserved.
//

import UIKit

class RunSetupViewController: UIViewController {

    @IBOutlet var desiredDistance: UITextField!
    @IBOutlet var desiredTime: UITextField!
    @IBOutlet var desiredSpeed: UITextField!
    @IBOutlet var segmentNumber: UILabel!
    let handyFunctions = Functions()
    let myVirtualProgress = virtualProgress()//watch this, might create problems later
    var desiredDistancenum = 0.0
    var desiredTimenum = 0.0
    var desiredSpeednum = 0.0
    var segmentInt = 1
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        desiredDistance.placeholder = "x.x"
        desiredTime.placeholder = "xx"
        desiredSpeed.placeholder = "x.x"

    }
    
    
    func saveSegment(){
        let newSegment = runSegment(segLength: desiredDistancenum, segTime: desiredTimenum)
        segmentInt += 1
        segmentNumber.text = "Segment "+String(segmentInt)
        
        desiredDistancenum = 0
        desiredSpeednum = 0
        desiredTimenum = 0
        desiredDistance.text = ""
        desiredSpeed.text = ""
        desiredTime.text = ""
        
        myVirtualProgress.addNewSegment(segment: newSegment)
    }
    
    @IBAction func infoButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Help", message:
            "This is a Reverse Polish Notation (RPN) calculator. \n Reverse Polish Notation is where arithmetic expressions are written such that the operator comes after the operands. \n E.g: 35*44*- would perform the calculation: (3*5)-(4*4) \n Press enter to begin a new number, press eval to calculate the answer.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
    }
    
    @IBAction func startRunButton(_ sender: Any) {
        saveSegment()
    }
    
    @IBAction func newSegmentButton(_ sender: Any) {
        saveSegment()
    }

    @IBAction func distanceEditingEnds(_ sender: Any) {
        if let b = Double(desiredDistance.text!){
            desiredDistancenum  = handyFunctions.roundToPrecision(b, toNearest: 0.1)
            if desiredSpeednum != 0{
                let a = desiredDistancenum/(desiredSpeednum/60)
                desiredTimenum  = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredTime.text = String(desiredTimenum)
            } else if desiredTimenum != 0{
                let a = (desiredDistancenum/desiredTimenum)*60
                desiredSpeednum = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredSpeed.text = String(desiredSpeednum)
                
            }
        }
    }
    
    @IBAction func timeEditingEnds(_ sender: Any) {
        if let b = Double(desiredTime.text!){
            desiredTimenum = handyFunctions.roundToPrecision(b, toNearest: 0.1)
            if desiredSpeednum != 0{
                let a = (desiredSpeednum/60) * desiredTimenum
                desiredDistancenum = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredDistance.text = String(desiredDistancenum)
            } else if desiredDistancenum != 0{
                let a = (desiredDistancenum / desiredTimenum)*60
                desiredSpeednum = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredSpeed.text = String(desiredSpeednum)
            }
        }
    }
    
    @IBAction func speedEditingEnds(_ sender: Any) {
        if let b = Double(desiredSpeed.text!){
            desiredSpeednum = handyFunctions.roundToPrecision(b, toNearest: 0.1)
            if desiredTimenum != 0{
                let a = desiredTimenum * (desiredSpeednum/60)
                desiredDistancenum = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredDistance.text = String(desiredDistancenum)
            } else if desiredDistancenum != 0{
                let a = desiredDistancenum / (desiredSpeednum/60)
                desiredTimenum  = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredTime.text = String(desiredTimenum)
                
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
