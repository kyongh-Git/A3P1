//
//  ViewController.swift
//  A3_P1_Kim_YongHwan
//
//  Created by YongHwan Kim on 9/28/19.
//  Copyright © 2019 YongHwan Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func mainUnwindAction(segue: UIStoryboardSegue){}
   
    @IBOutlet weak var LapLabel: UILabel!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var NewLapButton: UIButton!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    
    var currentTimer :Timer?
    var totalTimer :Timer?
    var isRunning :Bool = false
    var isStopped :Bool = false
    var mSecondT :Int = 0
    var secondT :Int = 0
    var minuteT :Int = 0
    var mSecondC :Int = 0
    var secondC :Int = 0
    var minuteC :Int = 0
    var lapTotal :Int = 0
    var dataCollected: [Int:Array<Int>] = [:]
    
    /*@IBAction func showStat(_ sender: UIBarButtonItem) {
        if(!dataCollected.isEmpty)
        {
            print("test passed")
            performSegue(withIdentifier: "showStat", sender: self)
        }
    }*/
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if(!dataCollected.isEmpty && !isRunning)
        {
           
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showStat" {
            let destination = segue.destination as! TableViewController
            
            destination.runData = self.dataCollected
        }
    }
    
    func goToTable()
    {
        self.performSegue(withIdentifier: "showStat", sender: self)
    }
    @IBAction func showStaticButton(_ sender: UIBarButtonItem) {
       goToTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.isToolbarHidden = false
    }
    
    
    @IBAction func StartStopButton(_ sender: UIButton) {
        
        if(isRunning){
            
            NewLapButton.setImage(UIImage(named: "new-lap_deactive.png"), for: .normal)
            NewLapButton.isUserInteractionEnabled = false
            StartStopButton.setImage(UIImage(named: "stopDeactive.png"), for: .normal)
            StartStopButton.isUserInteractionEnabled = false
            isRunning = false
            lapTotal += 1
            LapLabel.text = String(lapTotal)
            var tempArray :Array<Int> = []
            
            tempArray.append(minuteC)
            tempArray.append(secondC)
            tempArray.append(mSecondC)
            dataCollected[lapTotal] = tempArray
            
            print(dataCollected[lapTotal])
            self.totalTimer?.invalidate()
            self.currentTimer?.invalidate()
            
            var timeTotal :String
            if(mSecondT > 9)
            {
                if(secondT > 9)
                {
                    timeTotal = "\(String(minuteT)) : \(String(secondT)) . \(String(mSecondT))"
                }
                else
                {
                    timeTotal = "\(String(minuteT)) : 0\(String(secondT)) . \(String(mSecondT))"
                }
            }
            else
            {
                if(secondT > 9)
                {
                    timeTotal = "\(String(minuteT)) : \(String(secondT)) . \(String(mSecondT))"
                }
                else
                {
                    timeTotal = "\(String(minuteT)) : 0\(String(secondT)) . \(String(mSecondT))"
                }
            }
            totalTime.text = timeTotal
            
            var timeCurrent :String
            if(mSecondC > 9)
            {
                if(secondC > 9)
                {
                    timeCurrent = "\(String(minuteC)) : \(String(secondC)) . \(String(mSecondC))"
                }
                else
                {
                    timeCurrent = "\(String(minuteC)) : 0\(String(secondC)) . \(String(mSecondC))"
                }
            }
            else
            {
                if(secondC > 9)
                {
                    timeCurrent = "\(String(minuteC)) : \(String(secondC)) . \(String(mSecondC))"
                }
                else
                {
                    timeCurrent = "\(String(minuteC)) : 0\(String(secondC)) . \(String(mSecondC))"
                }
            }
            currentTime.text = timeCurrent
        }
        else{
            StartStopButton.setImage(UIImage(named: "stop.png"), for: .normal)
            NewLapButton.setImage(UIImage(named: "new-lap_active.png"), for: .normal)
            NewLapButton.isUserInteractionEnabled = true
            StartStopButton.isUserInteractionEnabled = true
            isRunning = true
            isStopped = true
            
            currentTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(currentRunTimer), userInfo: nil, repeats: true)
            
            totalTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(totalRunTimer), userInfo: nil, repeats: true)
        }
        
    }

    func goBackToLogo()
    {
        self.dataReset()
        self.performSegue(withIdentifier: "unwindToLogo", sender: self)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Do you want to return to launch screen?", message: "Your record will be removed", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in self.goBackToLogo()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func dataReset()
    {
        self.currentTimer?.invalidate()
        self.totalTimer?.invalidate()
        StartStopButton.setImage(UIImage(named: "start.png"), for: .normal)
        NewLapButton.setImage(UIImage(named: "new-lap_deactive.png"), for: .normal)
        NewLapButton.isUserInteractionEnabled = false
        StartStopButton.isUserInteractionEnabled = true
        
        isRunning = false
        isStopped = false
        mSecondT = 0
        secondT = 0
        minuteT = 0
        mSecondC = 0
        secondC = 0
        minuteC = 0
        lapTotal = 0
        dataCollected = [:]
        self.currentTime.text = "0 : 00 . 0"
        self.totalTime.text = "0 : 00 . 0"
        self.LapLabel.text = "0"
    }
    
    @IBAction func Reset(_ sender: UIBarButtonItem) {
        if(isStopped)
        {
            let alert = UIAlertController(title: "Do you want to reset the record?", message: "Your record will be removed", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in self.dataReset()}))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func NewLapButton(_ sender: UIButton) {
        lapTotal += 1
        LapLabel.text = String(lapTotal)
        var tempArray :Array<Int> = []
        
        tempArray.append(minuteC)
        tempArray.append(secondC)
        tempArray.append(mSecondC)
        dataCollected[lapTotal] = tempArray
        
        print(dataCollected[lapTotal])
        secondC = 0
        mSecondC = 0
        minuteC = 0
        currentTimer?.invalidate()
        currentTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(currentRunTimer), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NewLapButton.isUserInteractionEnabled = false
        //self.navigationController?.isNavigationBarHidden = true
       // self.navigationController?.isToolbarHidden = false
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        //toolbarItems?.append(contentsOf: Bu)
        loadView()
        
        
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NewLapButton.isUserInteractionEnabled = false
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }*//*
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }*/
    @objc func currentRunTimer(){
        mSecondC += 1
        if(mSecondC > 99)
        {
            mSecondC = 0
            secondC += 1
        }
        if(secondC > 59)
        {
            secondC = 0
            minuteC += 1
        }
        var time :String
        if(mSecondC > 9)
        {
            if(secondC > 9)
            {
                time = "\(String(minuteC)) : \(String(secondC)) . \(String(mSecondC))"
            }
            else
            {
                time = "\(String(minuteC)) : 0\(String(secondC)) . \(String(mSecondC))"
            }
        }
        else
        {
            if(secondC > 9)
            {
                time = "\(String(minuteC)) : \(String(secondC)) . \(String(mSecondC))"
            }
            else
            {
                time = "\(String(minuteC)) : 0\(String(secondC)) . \(String(mSecondC))"
            }
        }
        
        currentTime.text = time
    }
    
    @objc func totalRunTimer(){
        mSecondT += 1
        if(mSecondT > 99)
        {
            mSecondT = 0
            secondT += 1
        }
        if(secondT > 59)
        {
            secondT = 0
            minuteT += 1
        }
        var time :String
        if(mSecondT > 9)
        {
            if(secondT > 9)
            {
                time = "\(String(minuteT)) : \(String(secondT)) . \(String(mSecondT))"
            }
            else
            {
                time = "\(String(minuteT)) : 0\(String(secondT)) . \(String(mSecondT))"
            }
        }
        else
        {
            if(secondT > 9)
            {
                time = "\(String(minuteT)) : \(String(secondT)) . \(String(mSecondT))"
            }
            else
            {
                time = "\(String(minuteT)) : 0\(String(secondT)) . \(String(mSecondT))"
            }
        }

        totalTime.text = time
    }

}

