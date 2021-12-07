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
    let headerID = String(describing: IngredientsHeaderView.self)
    
    var ingredientsCount: Int  = 1
    var stepsCount: Int = 1
    var recipeImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(IngredientsHeaderView.self, forHeaderFooterViewReuseIdentifier: headerID)
        self.navigationItem.title = "Добавление рецепта"
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! IngredientsHeaderView
        header.delegate = self
        switch section {
        case 1:
            header.configure(titleString: "Ингредиенты:")
            return header
        case 2:
            header.configure(titleString: "Этапы", isIngredients: false)
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
            return ingredientsCount
        case 2:
            return stepsCount
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeImageCell", for: indexPath) as! RecipeImageTableViewCell
            cell.delegate = self
            cell.recipeImage.image = recipeImage ?? UIImage()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientTableViewCell
            return cell
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
                    self.ingredientsCount -= 1
                case 2:
                    self.stepsCount -= 1
                default:
                    return
                }
                tableView.deleteRows(at: [indexPath], with: .none)
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

extension RecipeCreationTableViewController: HeaderViewProtocol {
    func addIngredient() {
        ingredientsCount += 1
        let indexPath = IndexPath.init(item: ingredientsCount - 1, section: 1)
        tableView.insertRows(at: [indexPath], with: .bottom)
    }
    
    func addStep() {
        stepsCount += 1
        let indexPath = IndexPath.init(item: stepsCount - 1, section: 2)
        tableView.insertRows(at: [indexPath], with: .bottom)
    }
}

extension RecipeCreationTableViewController: AddButtonProtocol {
    func addRecipe() {
        try! realm.write {
            let recipe = getData()
            realm.add(recipe)
            category?.recipes.append(recipe)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getData() -> RecipeObjectModel {
        let imageCell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! RecipeImageTableViewCell
        let quality : CGFloat = 0.93
        let name = imageCell.tfRecipeName.text ?? ""
        
        var ingredients: [IngredintObjectModel] = []
        var steps: [String] = []
        
        for i in 0...ingredientsCount - 1 {
            let ingredientCell = tableView.cellForRow(at: IndexPath(item: i, section: 1)) as! IngredientTableViewCell
            let ingredient = IngredintObjectModel()
            ingredient.id = UUID().uuidString
            ingredient.name = ingredientCell.ingredientTextField.text ?? ""
            ingredients.append(ingredient)
        }
        
        for i in 0...stepsCount - 1 {
            let ingredientCell = tableView.cellForRow(at: IndexPath(item: i, section: 2)) as! IngredientTableViewCell
            let step = ingredientCell.ingredientTextField.text ?? ""
            steps.append(step)
        }
        
        let recipe = RecipeObjectModel()
        recipe.id = UUID().uuidString
        recipe.name = name
        recipe.image = recipeImage?.jpegData(compressionQuality: quality)
        recipe.ingredients.append(objectsIn: ingredients)
        recipe.steps.append(objectsIn: steps)
        
        return recipe
    }
}

extension RecipeCreationTableViewController: ImagePickerDelegate {
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
