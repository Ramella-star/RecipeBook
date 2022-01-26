//
//  ShoppinListTableViewController.swift
//  RecipeBook
//
//  Created by Admin on 11.12.2021.
//

import UIKit
import RealmSwift

class ShoppinListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    let realm = try! Realm()
    var ingredients: Results<IngredientObjectModel>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cписок покупок"
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ingredients =  realm.objects(IngredientObjectModel.self).filter("inShoppinList = true")
        emptyLabel.isHidden = !(ingredients?.count == 0 || ingredients == nil)
        tableView.reloadData()
    }
}

extension ShoppinListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell()
        cell.textLabel?.text = ingredients?[indexPath.item].name
        return cell
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
       
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
                try! self.realm.write {
                    guard let ingredient = self.ingredients?[indexPath.item] else { return }
                    ingredient.inShoppinList = false
                }
                self.viewWillAppear(false)
                completionHandler(true)
            }
            deleteAction.backgroundColor = .red
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
    }
}
