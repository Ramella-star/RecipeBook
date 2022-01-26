//
//  CategoryCollectionViewCell.swift
//  RecipeBook
//
//  Created by Admin on 15.10.2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let verticalSrackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    let categoryNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let categoryImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.tintColor = .white
        imgView.backgroundColor = .systemGray2
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 15
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let recipesCountLabel: UILabel = {
       let lbl = UILabel()
        lbl.textColor = UIColor.lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.image = UIImage(systemName: "photo")
    }
    
    func setCell(title: String, count: Int?, data: Data?) {
        categoryNameLabel.text = title
        recipesCountLabel.text = "Рецептов в категории: \(count ?? 0)"
        if let image = data {
            categoryImageView.image = UIImage(data: image)
        }
    }
    
    func setupViews() {
        self.layer.cornerRadius = 15
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        self.addSubview(categoryImageView)
        self.addSubview(verticalSrackView)
        verticalSrackView.addArrangedSubview(categoryNameLabel)
        verticalSrackView.addArrangedSubview(recipesCountLabel)
        makeCategoryImageViewConstraints()
        makeVerticalStackViewConstraints()
    }
    
    private func makeCategoryImageViewConstraints() {
        categoryImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoryImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        categoryImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        categoryImageView.widthAnchor.constraint(equalTo: categoryImageView.heightAnchor).isActive = true
    }
    
    
    private func makeVerticalStackViewConstraints() {
        //verticalSrackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalSrackView.leftAnchor.constraint(equalTo: categoryImageView.rightAnchor, constant: 10).isActive = true
        verticalSrackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        //verticalSrackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        verticalSrackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
