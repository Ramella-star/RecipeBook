//
//  RecipeImageCollectionViewCell.swift
//  RecipeBook
//
//  Created by Admin on 23.11.2021.
//

import UIKit

protocol ImagePickerDelegate: class {
    func didTapOnImage()
    func didEditTextField(name: String)
}

class RecipeImageTableViewCell: UITableViewCell {
    
    var delegate: ImagePickerDelegate?
    
    let verticalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let recipeImage: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .gray
        img.isUserInteractionEnabled = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let recipeName: UILabel = {
       let lbl = UILabel()
        lbl.text = "Название рецепта"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let tfRecipeName: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    @objc func didTapOnImage() {
        delegate?.didTapOnImage()
    }
    
    func setCell(delegate: ImagePickerDelegate, name: String?, image: UIImage?) {
        self.delegate = delegate
        self.tfRecipeName.text = name
        self.recipeImage.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isUserInteractionEnabled = true
        setupViews()
    }
    
    private func setupViews() {
        addSubview(verticalStackView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnImage))
        recipeImage.addGestureRecognizer(tapGestureRecognizer)

        verticalStackView.addArrangedSubview(recipeImage)
        verticalStackView.addArrangedSubview(recipeName)
        verticalStackView.addArrangedSubview(tfRecipeName)
        
        makeVerticalStackViewConstraints()
        makeImageViewConstraints()
    }
    
    private func makeImageViewConstraints() {
        recipeImage.heightAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func makeVerticalStackViewConstraints() {
        verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
