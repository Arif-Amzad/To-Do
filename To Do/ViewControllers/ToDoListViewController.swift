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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: cellID)
        
        print(dataFilePath!)
        
        loadDataFromStorage()
    }
    
    
    
    func loadDataFromStorage() {

        if let data = try? Data(contentsOf: dataFilePath!){
                
            let decoder = PropertyListDecoder()
                
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                    
                print("Error decoding item array, \(error)")
            }
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
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveFiles()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new To Do item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveFiles()
    }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
            
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func saveFiles() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.itemArray)
            
            try data.write(to: dataFilePath!)
            
        } catch {
            
            print("Error encoding item array \(error)")
        }
        
        self.tableView.reloadData()

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
