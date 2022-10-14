//
//  UIButton.swift
//  exam2
//
//  Created by Qtec on 2022/10/14.
//

import UIKit

extension UIButton {
    
    static func menuButton(title: String) -> UIButton {
        let b = UIButton(type: .system)
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 10
        b.backgroundColor = .white
        b.setTitle(title, for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 17)
        return b
    }
}
