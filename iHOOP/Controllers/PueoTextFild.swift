//
//  DoctorServiceTextFild.swift
//  DoctorServicesVendor
//
//  Created by mac on 16/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit

class PueoTextFild: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @IBInspectable var cornerRadiuss: CGFloat = 0.0  {
        didSet {
            layer.cornerRadius = cornerRadiuss
        }
    }
    @IBInspectable var shadowColor:UIColor = .clear
        {
        didSet{
            self.layer.masksToBounds = false
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: 0, height: 5)
            self.layer.shadowRadius = 1
        }
    }
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
}
