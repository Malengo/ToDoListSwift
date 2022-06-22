//
//  CategoryRealmTableViewController.swift
//  Todoey
//
//  Created by user on 21/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryRealmTableViewController: UITableViewController {
    
    let model = ModelRealm<CategoryRealm>()
    var categories: Results<CategoryRealm>?

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = model.read()
    }
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Create a new Category", message: "Enter here for add New Category", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Category"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default){ [self, weak alert] _ in
            if let textFields = alert?.textFields {
                if let categoryText = textFields[0].text {
                    let category = CategoryRealm()
                    category.name = categoryText
                    model.create(entity: category)
                    tableView.reloadData()
                }
            }
        })
    
        self.present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let category = categories?[indexPath.row]
        cell.textLabel?.text = category?.name ?? "there are no categoreis in the list"
        return cell
    }
    
    //MARK - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "itemCategory", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = categories?[indexPath.row]{
                model.delete(entity: item)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ItemRealmTableViewController
        if let index = tableView.indexPathForSelectedRow {
            vc.categorySelected = categories?[index.row]
        }
    }
    

}
