//
//  TableViewController.swift
//  A5_P1_Kim_YongHwan
//
//  Created by YongHwan Kim on 10/28/19.
//  Copyright © 2019 YongHwan Kim. All rights reserved.

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
//    var dataSource: [Course] = []
    var courseArr = [Course]()
    
    var fetchedRC: NSFetchedResultsController<Course>!
    
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    var fetchRequest: NSFetchRequest<Course>!

    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        fetchRequest = Course.fetchRequest()
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \Course.deptAbbr, ascending: true),
            NSSortDescriptor(keyPath: \Course.courseNum, ascending: true)
        ]
        
        fetchedRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedRC.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRequest.predicate = nil
        
        do {
            try fetchedRC.performFetch()
        }
        catch let error as NSError {
            print("Cannot load data: \(error)")
        }
        
        fetchRequest.predicate = nil
    }
    
    @IBAction func unwindFromSave(segue: UIStoryboardSegue) {
        var isDuplicate: Bool = false
        
        // Get the segue source.
        guard let source = segue.source as? ViewController else {
            print("Cannot get segue source.")
            return
        }
       
        // Set the attributes in the new course record.
        if source.deptAbbrResult == "Bad DeptAbbr" || source.courseNumResult == -1 || source.courseTitleResult == "Bad Title" {
            alertDisplayF()
        }
        else{
            do{
                let courseArr = try context?.fetch(fetchRequest)
                self.courseArr = courseArr!
                
                for c in courseArr!
                {
                    if(c.deptAbbr == source.deptAbbrResult && c.courseNum == source.courseNumResult){
                        //print("Duplicates")
                        isDuplicate = true
                        alertDisplay()
                        return
                    }
                }
            } catch{}
            
            if(!isDuplicate)
            {
                // Create a new course record.
                let course = Course(context: context!)
                course.deptAbbr = source.deptAbbrResult
                course.courseNum = source.courseNumResult
                course.title = source.courseTitleResult
                
                do {
                    // Update the data store with the managed context.
                    try context!.save()
                    //print("saved")
                }
                catch let error as NSError {
                    print("cannot save data: \(error)")
                }
            }
            
        }
        
    }
    
    func alertDisplay(){
        let alert = UIAlertController(title: "Warning", message: "The data entered is a duplicate. The data is not saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.goToSave()}))
        //alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in self.goBackToLogo()}))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.present(alert, animated: true, completion: nil)
        }
        //self.present(alert, animated: true)
    }
    
    func alertDisplayF(){
        let alert = UIAlertController(title: "Warning", message: "Please fill out the information or tap Back button to quit", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.goToSave()}))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func goToSave()
    {
        performSegue(withIdentifier: "newCourse", sender: self)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            break;
        case .move:
            break;
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return fetchedRC.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Cell", for: indexPath)

        // Configure the cell...
        // Display the cell label and subtitle.
        cell.textLabel?.text = fetchedRC.object(at: indexPath).deptAbbr! + String(fetchedRC.object(at: indexPath).courseNum)
        cell.detailTextLabel?.text = fetchedRC.object(at: indexPath).title
        
        return cell
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
