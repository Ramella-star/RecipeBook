//
//  RecipeCollectionViewCell.swift
//  RecipeBook
//
//  Created by Admin on 17.11.2021.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
    }
}
