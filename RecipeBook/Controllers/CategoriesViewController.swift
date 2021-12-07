//
//  CategoriesViewController.swift
//  RecipeBook
//
//  Created by Admin on 12.10.2021.
//

import UIKit
import RealmSwift

class CategoriesViewController: UIViewController {
    
    let realm = try! Realm()
    var categories: Results<CategoryObjectModel>?
    let categorieCellId = "cellId"
    
    //lazy var categories: Results<CategoryObjectModel> = { self.realm.objects(CategoryObjectModel) }()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: categorieCellId)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = .zero
        self.navigationItem.title = "Категории"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
         categories =  realm.objects(CategoryObjectModel.self)
        collectionView.reloadData()
    }
    
    @objc private func addCategory() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "categoryCreation") as? CategoryCreationViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func deleteCategory(category: CategoryObjectModel) {
        try! realm.write {
            realm.delete(category)
        }
        collectionView.reloadData()
    }
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categorieCellId, for: indexPath) as! CategoryCollectionViewCell
        let category = categories?[indexPath.item]
        cell.setCell(title: category?.name ?? "", data: category?.imageData)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width / 2) - 5
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "recipeListView") as? RecipeListViewController else {
            return
        }
        
        vc.category = categories?[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let actionProvider: UIContextMenuActionProvider = { _ in
                return UIMenu(title: "", children: [
                    UIAction(title: "Удалить") { _ in
                        if let category = self.categories?[indexPath.item]{
                            self.deleteCategory(category: category)
                        }
                    }
                ])
            }

            return UIContextMenuConfiguration(identifier: "unique-ID" as NSCopying, previewProvider: nil, actionProvider: actionProvider)
    }
}
