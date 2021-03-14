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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let RunViewController = segue.destination as? RunViewController {
            RunViewController.myVirtualProgress = myVirtualProgress
        }
    }
    
    
    @IBAction func infoButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Help", message:
            "Input any two of the following fields and the third will autocomplete. Then press New Segment to add another segment to the run or Start Run if you are ready to go.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func startRunButton(_ sender: Any) {
        //saveSegment()

    }
    @IBAction func dismisskeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func newSegmentButton(_ sender: Any) {
        
        saveSegment()
        
    }

    @IBAction func distanceEditingEnds(_ sender: Any) {
        if var b = Double(desiredDistance.text!){
            b = b*1000
            desiredDistancenum  = handyFunctions.roundToPrecision(b, toNearest: 0.1)
            if desiredSpeednum != 0{
                let a = (desiredDistancenum/desiredSpeednum)
                desiredTimenum  = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredTime.text = String(handyFunctions.roundToPrecision(desiredTimenum/60, toNearest: 1))
            } else if desiredTimenum != 0{
                let a = (desiredDistancenum/desiredTimenum)
                desiredSpeednum = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredSpeed.text = String(handyFunctions.roundToPrecision(desiredSpeednum*3.6, toNearest: 1))
                
            }
        }
    }
    
    @IBAction func timeEditingEnds(_ sender: Any) {
        if var b = Double(desiredTime.text!){
            b=b*60
            desiredTimenum = handyFunctions.roundToPrecision(b, toNearest: 0.1)
            if desiredSpeednum != 0{
                let a = (desiredSpeednum * desiredTimenum)
                desiredDistancenum = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredDistance.text = String(handyFunctions.roundToPrecision(desiredDistancenum/1000, toNearest: 1))
            } else if desiredDistancenum != 0{
                let a = (desiredDistancenum / desiredTimenum)
                desiredSpeednum = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredSpeed.text = String(handyFunctions.roundToPrecision(desiredSpeednum*3.6, toNearest: 1))
            }
        }
    }
    
    @IBAction func speedEditingEnds(_ sender: Any) {
        if var b = Double(desiredSpeed.text!){
            b=b/3.6
            desiredSpeednum = handyFunctions.roundToPrecision(b, toNearest: 0.1)
            if desiredTimenum != 0{
                let a = (desiredTimenum * desiredSpeednum)
                desiredDistancenum = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredDistance.text = String(handyFunctions.roundToPrecision(desiredDistancenum/1000, toNearest: 1))
            } else if desiredDistancenum != 0{
                let a = (desiredDistancenum / desiredSpeednum)
                desiredTimenum  = handyFunctions.roundToPrecision(a, toNearest: 0.1)
                desiredTime.text = String(handyFunctions.roundToPrecision(desiredTimenum/60, toNearest: 1))
                
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
