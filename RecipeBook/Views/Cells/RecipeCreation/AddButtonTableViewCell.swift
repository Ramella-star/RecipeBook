//
//  AddButtonTableViewCell.swift
//  RecipeBook
//
//  Created by Admin on 01.12.2021.
//

import UIKit

protocol AddButtonProtocol: class {
    func addRecipe()
}

class AddButtonTableViewCell: UITableViewCell {
    
    var delegate: AddButtonProtocol?
    
    let addButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Добавить", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    @objc func pressBtn() {
        delegate?.addRecipe()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    
    private func setupViews() {
        addSubview(addButton)
        makeAddButtonConstraints()
        addButton.addTarget(self, action: #selector(pressBtn), for: .touchUpInside)
    }
    
    private func makeAddButtonConstraints() {
        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

}
