//
//  RecipeCollectionViewCell.swift
//  RecipeBook
//
//  Created by Admin on 12.11.2021.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
     private let recipeImage: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .cyan
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let recipeName: UILabel = {
       let lbl = UILabel()
        lbl.text = "Recipe Suka"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let favoriteButton: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .blue
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let descriptionLabel: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(recipeImage)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(descriptionLabel)
        horizontalStackView.addArrangedSubview(recipeName)
        horizontalStackView.addArrangedSubview(favoriteButton)
        
        makeVerticalStackViewConstraints()
        makeRecipeImageConstraints()
    }
    
    private func makeVerticalStackViewConstraints() {
        verticalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    private func makeRecipeImageConstraints() {
        recipeImage.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 1).isActive = true
        recipeImage.heightAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 1).isActive = true
    }
}
