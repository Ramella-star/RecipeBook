//
//  RealmObjectModels.swift
//  RecipeBook
//
//  Created by Admin on 24.10.2021.
//

import Foundation
import RealmSwift

class CategoryObjectModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String? = ""
    @objc dynamic var imageData: Data? = nil
     dynamic var recipes: List<RecipeObjectModel> = List<RecipeObjectModel>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class RecipeObjectModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: Data? = nil
    @objc dynamic var isFavorite: Bool = false
     dynamic var ingredients: List<IngredintObjectModel> = List<IngredintObjectModel>()
    dynamic var steps: List<String> = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class IngredintObjectModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var inProductList: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
