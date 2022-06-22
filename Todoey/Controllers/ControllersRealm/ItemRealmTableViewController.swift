//
//  ItemRealmTableViewController.swift
//  Todoey
//
//  Created by user on 21/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class ItemRealmTableViewController: UITableViewController {
    
    let model = ModelRealm<ItemRealm>()
    var items: Results<ItemRealm>?
    let realm = try? Realm()
    
    var categorySelected: CategoryRealm?{
        didSet{
            items = categorySelected?.items.sorted(byKeyPath: "title", ascending: true)
            navigationItem.title = categorySelected?.name
        }
    }
    var item = ItemRealm()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Item for list of Category", message: nil, preferredStyle: .alert)
        alert.addTextField { textFieldNewItem in
            textFieldNewItem.placeholder = "Enter here for new Item"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default){ [self, weak alert] _ in
            if let textFields = alert?.textFields {
                if let newItem = textFields[0].text {
                    try? realm?.write{
                        let item = ItemRealm()
                        item.title = newItem
                        categorySelected?.items.append(item)
                        tableView.reloadData()
                    }
                }
            }
        })
        present(alert, animated: true)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifierRealm", for: indexPath)
        if let item = items?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let item = items?[indexPath.row]{
            try? realm?.write({
                item.done = !item.done
            })
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = items?[indexPath.row]{
                model.delete(entity: item)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

}
//MARK: Search bar Methods

extension ItemRealmTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text{
        items = items?.filter("title CONTAINS[cd] %@", searchText).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            items = categorySelected?.items.sorted(byKeyPath: "title", ascending: true)
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.tableView.reloadData()
            }
        }
    }
}

