//
//  IngredientTableViewCell.swift
//  RecipeBook
//
//  Created by Admin on 24.11.2021.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    let ingredientTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        return textField
    }()
    
    override func prepareForReuse() {
        ingredientTextField.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        addSubview(ingredientTextField)
        makeIngredientTextFieldConstraints()
    }
    
    private func makeIngredientTextFieldConstraints() {
        ingredientTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ingredientTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        ingredientTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
}
