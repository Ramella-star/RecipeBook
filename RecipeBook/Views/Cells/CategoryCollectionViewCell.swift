//
//  CategoryCollectionViewCell.swift
//  RecipeBook
//
//  Created by Admin on 15.10.2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let categoryNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let categoryImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.image = nil
    }
    
    func setCell(title: String, data: Data?) {
        categoryNameLabel.text = title
        if let image = data {
            categoryImageView.image = UIImage(data: image)
        }
    }
    
    func setupViews() {
        self.addSubview(categoryImageView)
        self.addSubview(categoryNameLabel)
        makeCategoryNameLabelConstraints()
        makeCategoryImageViewConstraints()
    }
    
    private func makeCategoryImageViewConstraints() {
        categoryImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoryImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        categoryImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        categoryImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    private func makeCategoryNameLabelConstraints() {
        categoryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoryNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
