//
//  StepTableViewCell.swift
//  RecipeBook
//
//  Created by Admin on 09.12.2021.
//

import UIKit

protocol AdditionCellProtocol: class {
    func add(cellType: AdditionCellType, value: String)
}

enum AdditionCellType: Int {
    case ingredient = 1
    case step = 2
}

class AdditionTableViewCell: UITableViewCell {
    var cellType: AdditionCellType = .ingredient
    var delegate: AdditionCellProtocol?
    
    let verticalStackView: UIStackView = {
       let stkView = UIStackView()
        stkView.translatesAutoresizingMaskIntoConstraints = false
        return stkView
    }()
    
    let textField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Ингредиент"///другое название
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        return textField
    }()
    
    let addButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage.init(systemName: "plus"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func addIngredient() {
        delegate?.add(cellType: cellType, value: textField.text ?? "")
        textField.text = ""
    }
    
    func setCell(delegate: AdditionCellProtocol, cellType: AdditionCellType) {
        self.delegate = delegate
        self.cellType = cellType
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(textField)
        verticalStackView.addArrangedSubview(addButton)
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        
        makeVerticalStackViewConstraints()
    }
    
    private func makeVerticalStackViewConstraints() {
        verticalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        verticalStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
