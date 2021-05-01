//
//  TableViewController.swift
//  Lab_7
//
//  Created by saj panchal on 2020-03-31.
//  Copyright © 2020 saj panchal. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    //var getString: String?
    var globalTextField: UITextField? //textfield to store alertview input.
    let userDefault = UserDefaults.standard //userDefault object for persistant data storage.
    var toDoListArray : [String]? = [] //array of strings to be used to store persistant data.
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if toDoListArray != nil //check if the array is not initialized or nil
        {
            toDoListArray  = userDefault.array(forKey: "listItem") as? [String] // returns array of specified key
        }
                
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add Item", message: "Add item to cell", preferredStyle: .alert)//create alert view controller object
        
        alert.addTextField //function with closure to add textfield in the alert box
            {
                (alertTextField) in //call the closure operation with parameter
                self.globalTextField = alertTextField //assign alert text field to global text field
            }
        
        let actionOK = UIAlertAction(title: "OK", style: .default) //create alert view action object by calling Alertview action func
        {
            (action) in //calling a closure by declaring an object
            if let itemString = self.globalTextField!.text //check if the text field is not nil
            {
                if(self.toDoListArray != nil) //check if the array is not nil
                {
                    self.toDoListArray!.append(itemString) //append the array with added new item string
                }
                else //if array is nil
                {
                    self.toDoListArray = [itemString] //initialize array with the first value
                }
            }
            self.userDefault.set(self.toDoListArray, forKey: "listItem") //sets the array of a given key as a value to userdefault object
            
           // self.toDoListArray = self.userDefault.array(forKey: "listItem") as? [String] //update the array after append
            self.tableView.reloadData() // reload tableview after updates to recalculate rows and update cells.
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) //create alerct action object by calling function
        alert.addAction(actionOK) //add action to alert view controller
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil) //view the alert box upon button click.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if toDoListArray != nil
        {
            return toDoListArray!.count //return array length as number of rows
        }
        else
        {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) //add cell object to the table
        cell.textLabel!.text = toDoListArray![indexPath.row] //set cell text as added item string
        return cell
    }
    
    
   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete //check if the table view cell is requested to delete
        {
            
            toDoListArray!.remove(at: indexPath.row) //remove the array element i.e. item string from a selected row.
            tableView.deleteRows(at: [indexPath], with: .fade)// delete a selected row
            self.userDefault.set(self.toDoListArray, forKey: "listItem") //update the user default database
            toDoListArray = userDefault.array(forKey: "listItem") as? [String] // update the array
        }
    
    }
    
    
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
