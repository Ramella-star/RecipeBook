//
//  RecipeCollectionViewCell.swift
//  RecipeBook
//
//  Created by Admin on 17.11.2021.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    var recipe: RecipeObjectModel? {
        didSet{
            recipeNameLabel.text = recipe?.name
            if let data = recipe?.image {
                recipeImageView.image = UIImage(data: data)
            }
        }
    }
    
    let recipeImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.tintColor = .white        
        imgView.clipsToBounds = true
        imgView.backgroundColor = .systemGray2
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 15
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let recipeNameLabel: UILabel = {
        let lbl = UILabel()
        //lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let recipeNameView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    func setCell(recipe: RecipeObjectModel?) {
        recipeNameLabel.text = recipe?.name
        if let image = recipe?.image {
            recipeImageView.image = UIImage(data: image)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.image = UIImage(systemName: "photo")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 15        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
        
        addSubview(recipeImageView)
        addSubview(recipeNameView)
        addSubview(recipeNameLabel)
        makeRecipeImageViewConstraints()
        makeRecipeNameViewConstraints()
        makeRecipeNameLabel()
    }
    
    func makeRecipeImageViewConstraints() {
        recipeImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        recipeImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        recipeImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        //recipeImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor).isActive = true
    }
    
    func makeRecipeNameViewConstraints() {
        recipeNameView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor).isActive = true
        recipeNameView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        recipeNameView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        recipeNameView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func makeRecipeNameLabel() {
        recipeNameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 5).isActive = true
        recipeNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        recipeNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
        recipeNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
    }
}
