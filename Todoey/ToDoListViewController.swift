//
//  ViewController.swift
//  Todoey
//
//  Created by Nataly Zeldin on 3/15/19.
//  Copyright © 2019 Nataly Zeldin. All rights reserved.
//

import UIKit

// *** by inheriting (subclassing) a table view controller, ib outlets, delegates, etc all taken care of by xcode***

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike","Buy Eggos","Destroy Demogron"]

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    //MARK - Tableview Datasource methods: set what the cells should display and how many rows we want in tableview
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) //create dequeued reusable cell
        
        cell.textLabel?.text = itemArray[indexPath.row] // set cell's text to row item from array
        
        return cell // return the cell with the text to the table view
    }

    //MARK - TableView Delegate Methods - get fired whenever we click on any cell in the table view
    
    //detect which row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //if row has a checkmark, remove it. if it doesn't, add a checkmark.
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true) // goes back to original look after item is selected
    }
    
    
}


