//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Nataly Zeldin on 3/15/19.
//  Copyright © 2019 Nataly Zeldin. All rights reserved.
//

import UIKit

// *** by inheriting (subclassing) a table view controller, ib outlets, delegates, etc all taken care of by xcode***

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard //store user defaults persistently here

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogron"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
          itemArray = items
        } // set array to saved defaults
    
    }
    
    //MARK - Tableview Datasource methods: set what the cells should display and how many rows we want in tableview
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) //create dequeued reusable cell
        
        let item = itemArray[indexPath.row] // this is the current item for the cell, shorthand to make code less wordy
        
        cell.textLabel?.text = item.title // set cell's text to row item from array
        
        //Ternary Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse ... fewer lines of code than if.. then!
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        return cell // return the cell with the text to the table view
    }

    //MARK - TableView Delegate Methods - get fired whenever we click on any cell in the table view
    
    //detect which row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done // set done property to opposite of what it is
        
        
        //if row has a checkmark, remove it. if it doesn't, add a checkmark.
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true) // goes back to original look after item is selected
    }
    
    
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField() // variable will be accessible on both the action and alert functions
        
        //create ui modal to add alert item when the button is pressed
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //create action view controller to add the item
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") // add the array to persistent defaults
            
            self.tableView.reloadData() // reload data using the item array which now has the new item
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField // textField has a narrower scope and only exists in this closure
            
            
        }
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
    
    
    
    
}


