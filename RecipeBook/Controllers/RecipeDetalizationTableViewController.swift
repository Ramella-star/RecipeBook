//
//  RecipeDetalizationTableViewController.swift
//  RecipeBook
//
//  Created by Admin on 02.12.2021.
//

import UIKit
import RealmSwift

class RecipeDetalizationTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var recipe: RecipeObjectModel?
    let headerID = String(describing: IngredientsHeaderView.self)
    
    var ingredientsCount: Int  = 1
    var stepsCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = recipe?.name
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        switch section {
        case 1:
            
            header.textLabel?.text = "Ингредиенты"
            //header.configure(titleString: "Ингредиенты:")
            return header
        case 2:
            header.textLabel?.text = "Этапы"
            //header.configure(titleString: "Этапы", isIngredients: false)
            return header
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 3:
            return 0
        default:
            return 20
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 1:
            return recipe?.ingredients.count ?? 0
        case 2:
            return recipe?.steps.count ?? 0
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeNameCell", for: indexPath) as! RecipeNameTableViewCell
            cell.recipe = recipe
            cell.delegate = self
            return cell
        case 1:///ингредиенты
            let cell = UITableViewCell()
            cell.backgroundColor = .blue
            cell.textLabel?.text = recipe?.ingredients[indexPath.item].name
            return cell
        case 2:///этапы
            let cell = UITableViewCell()
            cell.textLabel?.text = recipe?.steps[indexPath.item]
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

extension RecipeDetalizationTableViewController: FavoriteDelegate {
    func tapOnFavoriteButton() {
        try! realm.write {
            let recipe = self.recipe ?? RecipeObjectModel()
            recipe.isFavorite = !recipe.isFavorite
        }
    }
    
    
}
