//
//  ShoppinListTableViewController.swift
//  RecipeBook
//
//  Created by Admin on 11.12.2021.
//

import UIKit
import RealmSwift

class ShoppinListTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var ingredients: Results<IngredientObjectModel>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cписок покупок"
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ingredients =  realm.objects(IngredientObjectModel.self).filter("inShoppinList = true")
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell()
        cell.textLabel?.text = ingredients?[indexPath.item].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
       
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
                try! self.realm.write {
                    guard let ingredient = self.ingredients?[indexPath.item] else { return }
                    ingredient.inShoppinList = false
                }
                tableView.reloadData()
                completionHandler(true)
            }
            deleteAction.backgroundColor = .red
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
    }
    
}
