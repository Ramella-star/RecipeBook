//
//  RecipeList2ViewController.swift
//  RecipeBook
//
//  Created by Admin on 17.11.2021.
//

import UIKit
import RealmSwift

class RecipeListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let realm = try! Realm()
    var category: CategoryObjectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addRecipe))
    }
    
    @IBAction func addRecipe(_ sender: Any) {
        
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "recipeCreation2") as? RecipeCreationTableViewController else { return }
        vc.category = self.category
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func deleteRecipe(recipe: RecipeObjectModel) {
        try! realm.write {
            realm.delete(recipe)
        }
        collectionView.reloadData()
    }
}

extension RecipeListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = category?.recipes.count
        return  count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! RecipeCollectionViewCell
        cell.backgroundColor = .purple
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width / 2) - 5
        return CGSize(width: cellWidth, height: cellWidth)
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
                    }
                ])
            }

            return UIContextMenuConfiguration(identifier: "unique-ID" as NSCopying, previewProvider: nil, actionProvider: actionProvider)
    }
}
