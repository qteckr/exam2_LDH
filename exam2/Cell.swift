//
//  Cell.swift
//  exam2
//
//  Created by Qtec on 2022/10/14.
//

import UIKit

class Cell: UICollectionViewCell {
    
    static let cellId = "CellId"
    
    var model: DataModel? {
        willSet {
            titleLabel.text = nil
        }
        
        didSet {
            guard let model = model else {return}
            titleLabel.text = model.title
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
            return l
        }()
    }
    
    private func setupLayout() {
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        addSubview(titleLabel)
        titleLabel.anchor(t: topAnchor, l: leftAnchor, b: bottomAnchor, r: rightAnchor, cl: 3, cr: 3)
    }
}
