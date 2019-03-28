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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    let defaults = UserDefaults.standard //store user defaults persistently here

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
        loadItems()

    
    }
    
    //MARK - Tableview Datasource methods: set what the cells should display and how many rows we want in tableview
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) //create dequeued reusable cell
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse ... fewer lines of code than if.. then!
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        return cell // return the cell with the text to the table view
    }

    //MARK - TableView Delegate Methods - get fired whenever we click on any cell in the table view
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done // set done property to opposite of what it is
    
        saveItems()
        
        
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
            
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField // textField has a narrower scope and only exists in this closure
            
            
        }
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print ("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()                   // reload data using the item array which now has the new item
        
    }
    
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Decoding item array error, /(error)")
            }
        }
    }
    
    
    
    
}


