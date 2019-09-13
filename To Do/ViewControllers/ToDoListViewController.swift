//
//  ViewController.swift
//  To Do
//
//  Created by Arif Amzad on 12/9/19.
//  Copyright © 2019 Arif Amzad. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let cellID = "ToDoItemCell"

    let itemArray = ["Complete ML tutorials", "Go to tuition", "New app idea" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    
    //MARK - TableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) //as! ToDoTableViewCell
        
        //cell.listLabel = itemArray[indexPath.row]
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        //no
    }
    
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

