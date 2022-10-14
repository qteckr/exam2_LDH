//
//  UIView.swift
//  exam2
//
//  Created by Qtec on 2022/10/14.
//

import UIKit

extension UIView {
    
    func anchor(t top: NSLayoutYAxisAnchor?, l left: NSLayoutXAxisAnchor?, b bottom: NSLayoutYAxisAnchor?, r right: NSLayoutXAxisAnchor?, ct paddingTop: CGFloat = 0, cl paddingLeft: CGFloat = 0, cb paddingBottom: CGFloat = 0, cr paddingRight: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let width = width, width > 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height, height > 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
