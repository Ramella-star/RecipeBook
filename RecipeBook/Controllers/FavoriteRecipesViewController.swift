//
//  FavoriteRecipesViewController.swift
//  RecipeBook
//
//  Created by Admin on 07.12.2021.
//

import UIKit
import RealmSwift

class FavoriteRecipesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    let realm = try! Realm()
    var recipes: Results<RecipeObjectModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Избранные рецепты"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipes =  realm.objects(RecipeObjectModel.self).filter("isFavorite = true")
        emptyLabel.isHidden = !(recipes?.count == 0 || recipes == nil)
        collectionView.reloadData()
    }
}

extension FavoriteRecipesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteRecipeCell", for: indexPath) as! RecipeCollectionViewCell
        cell.recipe = recipes?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 30) / 2 
        return CGSize(width: cellWidth, height: cellWidth * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "recipeDetalization") as? RecipeDetalizationTableViewController else { return }
        vc.recipe = self.recipes?[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
