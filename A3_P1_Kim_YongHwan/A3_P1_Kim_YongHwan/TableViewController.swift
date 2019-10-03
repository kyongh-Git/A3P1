//
//  TableViewController.swift
//  A3_P1_Kim_YongHwan
//
//  Created by YongHwan Kim on 9/28/19.
//  Copyright © 2019 YongHwan Kim. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //@IBOutlet weak var CellTest: UITableViewCell!
    var runData :[Int:Array<Int>] = [:]
    var sectionHeaders = ["Overall Stats", "Lap-wise Stats"]
    
    var overallCal: Array<Int> = []
    
    var Fastest = 9999999999
    var Slowest = 0
    var Average = 0
    
    var slowCounter = 0
    var fastCounter = 0
    
    let cellID1 = "id1"
    let cellID2 = "id2"
    
    /*override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }*/
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //navigationController?.navigationBar.backItem = true
        calculate()
        //navigationController?.navigationBar.barPosition
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID1)
        
        
        //naviAppear()
        //performSegue(withIdentifier: "dTransfer", sender: self)
        
        // Uncomment the following line to preserve selection between presentations
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    }
    
   /*override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = false
    }*/
    func naviAppear() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.isToolbarHidden = true
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.isToolbarHidden = true
    }*/
    // MARK: - Table view data source

    func calculate()
    {
        var counter = 1
        
        var averageMin = 0
        var averageSec = 0
        var averageMsec = 0
        
        while(true)
        {
            var record = runData[counter]!
            var recordStr = ""
            var aveCounter = 0
            
            for r in record
            {
                recordStr = recordStr + String(r)
                if(aveCounter == 0)
                {
                    averageMin = averageMin + r
                }
                else if(aveCounter == 1)
                {
                    averageSec = averageSec + r
                }
                else if(aveCounter == 2)
                {
                    averageMsec = averageMsec + r
                }
                aveCounter += 1
            }
            aveCounter = 0
            
            //print(recordStr)
            
            if(Int(recordStr)! > Slowest)
            {
                Slowest = Int(recordStr)!
                slowCounter = counter
            }
            if(Int(recordStr)! < Fastest)
            {
                Fastest = Int(recordStr)!
                fastCounter = counter
            }
            
            counter += 1
            if(counter > runData.count)
            {
                break
            }
        }
        averageMin = averageMin * 6000
        averageSec = averageSec * 100
        Average = averageMin + averageSec + averageMsec
       
        Average = Int(Average / (counter-1))
       
        overallCal.append(fastCounter)
        overallCal.append(slowCounter)
        overallCal.append(Average)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0)
        {
            return 3
        }
        else
        {
            return runData.count
        }
    
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID1, for: indexPath)
        // Configure the cell...
        var recordStr = ""
        let lap = indexPath.section == 0 ? String(overallCal[indexPath.row]) : recordStr
    
        if(indexPath.section == 0)
        {
            if(indexPath.row == 0)
            {
                var lapInt = Int(lap)!
                var tempArr = runData[lapInt]
                var lapStr = ""
                for ta in tempArr!
                {
                    if(tempArr?.last == ta)
                    {
                        lapStr = lapStr + "\(ta)"
                    }
                    else
                    {
                        lapStr = lapStr + "\(ta)" + " : "
                    }
                    
                }
                cell.textLabel?.text = "Fastest:  " + lapStr
                //print(lapStr + "fast Test")
            }
            else if(indexPath.row == 1)
            {
                
                var lapInt = Int(lap)!
                
                var tempArr = runData[lapInt]
                var lapStr = ""
                
                for ta in tempArr!
                {
                    if(tempArr?.last == ta)
                    {
                        lapStr = lapStr + "\(ta)"
                    }
                    else
                    {
                        lapStr = lapStr + "\(ta)" + " : "
                    }
                    
                }
                cell.textLabel?.text = "Slowest:  " + lapStr
                //print(lapStr+"slowTest")
            }
            else if(indexPath.row == 2)
            {
                print(lap)
                var tempStr = ""
                var tempL = Int(lap)
                var min = 0
                var sec = 0
                var msec = 0
                
                if(tempL! >= 6000)
                {
                    min = Int(tempL! / 6000)
                    tempL = tempL! - (min*6000)
                }
                if(tempL! >= 100)
                {
                    sec = Int(tempL! / 100)
                    tempL = tempL! - (sec*100)
                }
                msec = tempL!
                
                cell.textLabel?.text = "Average: \(min) : \(sec) : \(msec)"
                
            }
            
        }
        else
        {
            var record = runData[(indexPath.row) + 1]!
            
            for r in record
            {
                print("r: " + String(r))
                if(r == record.last)
                {
                    recordStr = recordStr + String(r)
                }
                else
                {
                    recordStr = recordStr + String(r) + " : "
                }
                
            }
            cell.textLabel?.text = "Lap " + String((indexPath.row)+1) + ":  " + recordStr
        }
                //cell.detailTextLabel?.text = "test"
    
        return cell
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
