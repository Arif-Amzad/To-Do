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

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: cellID)
                        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "Find Mike 2"
        itemArray.append(newItem2)


        let newItem3 = Item()
        newItem3.title = "Find Mike 3"
        itemArray.append(newItem3)
        
        loadListFromStorage()

    }
    
    
    
    func loadListFromStorage() {
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            
            itemArray = items
            
        }
    }
    
    
    
    //MARK - TableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator in swift
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //do the same as below comment
        
//        if itemArray[indexPath.row].done == false {
//
//            itemArray[indexPath.row].done = true
//        }
//        else {
//
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData() // it reloads/ reRun the datasource method again.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new To Do item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //print(textField.text!)
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            //self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
            
        present(alert, animated: true, completion: nil)
    }
}





//    func exampleForLearning() {
//
//        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
//
//        for (n, prime) in primes.enumerated()
//        {
//            print("\(n) = \(prime)")
//        }
//    }
