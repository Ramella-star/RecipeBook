//
//  IngredientTableViewCell.swift
//  RecipeBook
//
//  Created by Admin on 09.12.2021.
//

import UIKit

protocol AddToShoppingListDelegate: class {
    func add(ingredient: IngredientObjectModel?)
}

class IngredientTableViewCell: UITableViewCell {
    
    var delegate: AddToShoppingListDelegate?
    
    var ingredient: IngredientObjectModel?  = nil{
        
        didSet{
            ingredientName.text = ingredient?.name
            inShoppinList = ingredient?.inShoppinList ?? false
        }
    }
    
    var inShoppinList: Bool = false {
        didSet {
            addButton.tintColor = inShoppinList ? .red : .gray
        }
    }
    
    let verticalStackView: UIStackView = {
       let stkView = UIStackView()
        stkView.translatesAutoresizingMaskIntoConstraints = false
        return stkView
    }()
    
    let ingredientName: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .white
        return lbl
    }()
    
    let addButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage.init(systemName: "list.dash"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func addIngredient() {
        inShoppinList = !inShoppinList
        delegate?.add(ingredient: self.ingredient)
    }
    
    func setCell( ingredient: IngredientObjectModel?) {
        self.ingredient = ingredient
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(ingredientName)
        verticalStackView.addArrangedSubview(addButton)
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        
        makeVerticalStackViewConstraints()
        makeFavoriteButtonCOnstraints()
    }
    
    private func makeVerticalStackViewConstraints() {
        verticalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        verticalStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func makeFavoriteButtonCOnstraints() {
        addButton.heightAnchor.constraint(equalTo: ingredientName.heightAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor).isActive = true
    }
}
