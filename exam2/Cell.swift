//
//  Cell.swift
//  exam2
//
//  Created by Qtec on 2022/10/14.
//

import UIKit

class Cell: UICollectionViewCell {
    
    static let cellId = "CellId"

    var totalCost = 0 {
        willSet {
            titleLabel.text = nil
        }
        
        didSet {
            titleLabel.textAlignment = .center
            titleLabel.text = "총수익금: \(totalCost.toDecimal())원"
        }
    }
    
    var ingredients: Ingredients? {
        willSet {
            titleLabel.text = nil
        }
        
        didSet {
            guard let ingredients = ingredients else {return}
            var title = ""
            
            title += "원두 (\(ingredients.beans.toDecimal())g)\n\n"
            title += "물 (\(ingredients.water.toDecimal())ml)\n\n"
            title += "우유 (\(ingredients.milk.toDecimal())ml)"
            
            titleLabel.textAlignment = .center
            titleLabel.text = title
        }
    }
    
    var coffee: Coffee? {
        willSet {
            titleLabel.text = nil
        }
        
        didSet {
            guard let coffee = coffee else {return}
            titleLabel.textAlignment = .left
            titleLabel.text = "\(coffee.name) 수익금: \(coffee.totalCost.toDecimal())원"
        }
    }
    
    var index = 0
    var order: Coffee? {
        willSet {
            titleLabel.text = nil
        }
        
        didSet {
            guard let order = order else {return}
            titleLabel.textAlignment = .left
            titleLabel.text = "\(index). \(order.name)"
        }
    }
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupControls()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupControls() {
        titleLabel = {
            let l = UILabel()
            l.textColor = .black
            l.textAlignment = .center
            l.numberOfLines = 0
            return l
        }()
    }
    
    private func setupLayout() {
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        addSubview(titleLabel)
        titleLabel.anchor(t: topAnchor, l: leftAnchor, b: bottomAnchor, r: rightAnchor, cl: 3, cr: 3)
    }
}
