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
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .orange
        btn.setTitleColor(.white, for: .normal)
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
        addButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        addButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

}
