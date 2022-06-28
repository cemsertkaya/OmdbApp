//
//  a.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import UIKit



@IBDesignable
class FormTextField: UITextField {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderRadius : CGFloat = 0{
        didSet{
            layer.cornerRadius = borderRadius
        }
    }
    
    @IBInspectable var placeholderColor : UIColor = UIColor.darkGray {
        didSet
        {
            self.attributedPlaceholder = NSAttributedString(string: "Search Movie", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
}


