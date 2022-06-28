//
//  FormButton.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation
import UIKit

@IBDesignable
class FormButton : UIButton
{
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
    
    
}
