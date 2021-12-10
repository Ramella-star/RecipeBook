//
//  RecipeCreationTableViewController.swift
//  RecipeBook
//
//  Created by Admin on 23.11.2021.
//

import UIKit
import RealmSwift
import YPImagePicker

class RecipeCreationTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var category: CategoryObjectModel?
    var ingredients: [IngredientObjectModel] = []
    var steps: [String] = []
    var recipeImage: UIImage?
    var recipeName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Добавление рецепта"
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! IngredientsHeaderView
        let header = UITableViewHeaderFooterView()
        //header.delegate = self
        switch section {
        case 1:
            //header.configure(titleString: "Ингредиенты:")
            header.textLabel?.text = "Ингредиенты:"
            return header
        case 2:
            //header.configure(titleString: "Этапы", isIngredients: false)
            header.textLabel?.text = "Этапы:"
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
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 1:
            return ingredients.count + 1
        case 2:
            return steps.count + 1
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeImageCell", for: indexPath) as! RecipeImageTableViewCell
            cell.setCell(delegate: self, name: recipeName, image: recipeImage)
            cell.tfRecipeName.delegate = self
            return cell
        case 1:
            switch indexPath.item {
            case ingredients.count:
                let cell = tableView.dequeueReusableCell(withIdentifier: "additionCell", for: indexPath) as! AdditionTableViewCell
                cell.setCell(delegate: self, cellType: .ingredient)
                return cell
            default:
                let cell = UITableViewCell()
                cell.textLabel?.text = "\(indexPath.item + 1). " + ingredients[indexPath.item].name
                return cell
            }
        case 2:
            switch indexPath.item {
            case steps.count:
                let cell = tableView.dequeueReusableCell(withIdentifier: "additionCell", for: indexPath) as! AdditionTableViewCell
                cell.setCell(delegate: self, cellType: .step)
                return cell
            default:
                let cell = UITableViewCell()
                cell.textLabel?.text = "\(indexPath.item + 1). " + steps[indexPath.item]
                return cell
            }
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addButtonCell", for: indexPath) as! AddButtonTableViewCell
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        func deleteCell() -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
                switch indexPath.section {
                case 1:
                    self.ingredients.remove(at: indexPath.item)
                case 2:
                    self.steps.remove(at: indexPath.item)
                default:
                    return
                }
                tableView.deleteRows(at: [indexPath], with: .none)
                tableView.reloadData()
                completionHandler(true)
            }
            deleteAction.backgroundColor = .red
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
        switch indexPath.section{
        case 1, 2:
            return deleteCell()
        default:
            return nil
        }
    }
    
    private func getImagePickerConfiguration(screen: YPPickerScreen) -> YPImagePickerConfiguration {
        var configuration = YPImagePickerConfiguration()
        
        #if targetEnvironment(simulator)
        configuration.screens = [.library]
        configuration.startOnScreen = .library
        #else
        configuration.screens = [screen]
        configuration.startOnScreen = screen
        #endif
        
        configuration.library.mediaType = .photo
        configuration.showsPhotoFilters = false
        configuration.isScrollToChangeModesEnabled = false
        configuration.onlySquareImagesFromCamera = false
        configuration.shouldSaveNewPicturesToAlbum = false
        configuration.hidesStatusBar = false
        
        //UINavigationBar.appearance().tintColor = .darkRed
        //configuration.colors.tintColor = .darkRed
        return configuration
    }
}

extension RecipeCreationTableViewController: AdditionCellProtocol {
    func add(cellType: AdditionCellType, value: String) {
        switch cellType {
        case .ingredient:
            let ingredient = IngredientObjectModel()
            ingredient.id = UUID().uuidString
            ingredient.name = value
            ingredients.append(ingredient)
            let indexPath = IndexPath(item: ingredients.count - 1, section: 1)
            tableView.insertRows(at: [indexPath], with: .bottom)
        case .step:
            steps.append(value)
            let indexPath = IndexPath(item: steps.count - 1, section: 2)
            tableView.insertRows(at: [indexPath], with: .bottom)
        }
    }
}

extension RecipeCreationTableViewController: AddButtonProtocol {
    func addRecipe() {
        try! realm.write {
            if let recipe = getData() {
                realm.add(recipe)
                category?.recipes.append(recipe)
            }
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getData() -> RecipeObjectModel? {
        let quality : CGFloat = 0.93
        let recipe = RecipeObjectModel()
        recipe.id = UUID().uuidString
        recipe.name = recipeName
        recipe.image = recipeImage?.jpegData(compressionQuality: quality)
        recipe.ingredients.append(objectsIn: ingredients)
        recipe.steps.append(objectsIn: steps)
        
        return recipe
    }
}

extension RecipeCreationTableViewController: ImagePickerDelegate {
    func didEditTextField(name: String) {
        recipeName = name
    }
    
    func didTapOnImage() {
        let configuration = getImagePickerConfiguration(screen: .library)
        
        let picker = YPImagePicker(configuration: configuration)
        picker.didFinishPicking {
            [unowned picker] items, _ in
            
            if let photo = items.singlePhoto {
                self.recipeImage = photo.image
                self.tableView.reloadData()
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
}

extension RecipeCreationTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.recipeName = textField.text ?? ""
    }
}
