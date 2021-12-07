//
//  IngredientsHeaderView.swift
//  RecipeBook
//
//  Created by Admin on 25.11.2021.
//

import UIKit
protocol HeaderViewProtocol: class {
    func addIngredient()
    func addStep()
}

class IngredientsHeaderView: UITableViewHeaderFooterView {
    
    weak var delegate: HeaderViewProtocol?
    var isIngredientHeader: Bool = true
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let title: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let insertIngredientButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage.init(systemName: "plus"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    /*required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }*/
    
    func configure(titleString: String?, isIngredients: Bool = true) {
        setupViews()
        title.text = titleString
        self.isIngredientHeader = isIngredients
    }
    
    private func setupViews() {
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(title)
        horizontalStackView.addArrangedSubview(insertIngredientButton)
        
        makeHorizontalStackViewConstraints()
        insertIngredientButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
    }
    
    @objc func addIngredient() {
        if isIngredientHeader {
            delegate?.addIngredient()
        } else {
            delegate?.addStep()
        }
        
    }
    
    private func makeHorizontalStackViewConstraints() {
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
