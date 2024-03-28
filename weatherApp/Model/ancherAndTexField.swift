//
//  button.swift
//  weatherApp
//
//  Created by Alijon Jumayev on 3/24/24.
//

import UIKit

//MARK: - Constraint

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

//MARK: - TextField

extension UITextField {
    
    func textField(withPlaceholder placeHolder: String) -> UITextField {
        
        let tf = UITextField()
        tf.returnKeyType = .go
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 30)
        tf.backgroundColor = .systemFill
        tf.textColor = .white
        tf.textAlignment = .right
        tf.layer.cornerRadius = 10
        tf.attributedPlaceholder = NSAttributedString(string: placeHolder,attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        return tf
    }
    
}
