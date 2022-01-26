//
//  RecipeList2ViewController.swift
//  RecipeBook
//
//  Created by Admin on 17.11.2021.
//

import UIKit
import RealmSwift

class RecipeListViewController: UIViewController {

    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let realm = try! Realm()
    var category: CategoryObjectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = category?.name
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyLabel.isHidden = !(category?.recipes.count == 0 || category?.recipes == nil)
        collectionView.reloadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addRecipe))
    }
    
    @IBAction func addRecipe(_ sender: Any) {
        
        editRecipe(recipe: nil)
        
    }
    
    private func deleteRecipe(recipe: RecipeObjectModel) {
        try! realm.write {
            realm.delete(recipe)
        }
        viewWillAppear(false)
    }
    
    private func editRecipe(recipe: RecipeObjectModel?) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "recipeCreation2") as? RecipeCreationTableViewController else { return }
        vc.category = self.category
        vc.recipe = recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecipeListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = category?.recipes.count
        return  count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! RecipeCollectionViewCell
        cell.recipe = category?.recipes[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 30) / 2 
        return CGSize(width: cellWidth, height: cellWidth * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "recipeDetalization") as? RecipeDetalizationTableViewController else { return }
        let recipe = self.category?.recipes[indexPath.item]
        vc.recipe = recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let actionProvider: UIContextMenuActionProvider = { _ in
                return UIMenu(title: "", children: [
                    UIAction(title: "Удалить") { _ in
                        if let recipe = self.category?.recipes[indexPath.item]{
                            self.deleteRecipe(recipe: recipe)
                        }
                    },
                    UIAction(title: "Изменить") { _ in
                        if let recipe = self.category?.recipes[indexPath.item]{
                            self.editRecipe(recipe: recipe)
                        }
                    }
                ])
            }

            return UIContextMenuConfiguration(identifier: "unique-ID" as NSCopying, previewProvider: nil, actionProvider: actionProvider)
    }
}
