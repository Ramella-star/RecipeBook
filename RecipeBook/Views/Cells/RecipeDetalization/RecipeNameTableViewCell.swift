//
//  RecipeNameTableViewCell.swift
//  RecipeBook
//
//  Created by Admin on 02.12.2021.
//

import UIKit

protocol FavoriteDelegate {
    func tapOnFavoriteButton()
}

class RecipeNameTableViewCell: UITableViewCell {
    
    var delegate: FavoriteDelegate?
    
    var recipe: RecipeObjectModel? {
        
        didSet{
            recipeName.text = recipe?.name
            isFavorite = recipe?.isFavorite ?? false
            if let data = recipe?.image {
                recipeImage.image = UIImage(data: data)
                
            }
        }
    }
    
    var isFavorite: Bool {
        didSet {
            let image = isFavorite  ?  UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            favoriteButton.setImage(image, for: .normal)
            favoriteButton.tintColor = .red
        }
    }

    let verticalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let horizontalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let recipeImage: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .gray
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let recipeName: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let favoriteButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    required init?(coder: NSCoder) {
        isFavorite = false
        super.init(coder: coder)
        setupViews()
    }
    
    @objc func tapToFavoriteButton() {
        isFavorite = !isFavorite
        delegate?.tapOnFavoriteButton()
    }
    
    private func setupViews() {
        addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(recipeImage)
        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(recipeName)
        horizontalStackView.addArrangedSubview(favoriteButton)
        
        makeVerticalStackViewConstraints()
        makeImageViewConstraints()
        makeFavoriteButtonCOnstraints()
        
        favoriteButton.addTarget(self, action: #selector(tapToFavoriteButton), for: .touchUpInside)
    }
    
    private func makeImageViewConstraints() {
        recipeImage.heightAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func makeVerticalStackViewConstraints() {
        verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        horizontalStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func makeFavoriteButtonCOnstraints() {
        favoriteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor).isActive = true
    }
}
