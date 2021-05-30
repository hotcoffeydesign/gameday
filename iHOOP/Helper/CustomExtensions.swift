//
//  CustomExtensions.swift
//  Speed Shopper
//
//  Created by mac on 10/04/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat{
        get{
            return layer.cornerRadius
        }set{
            layer.cornerRadius = newValue
//            self.layer.masksToBounds = true
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

extension BaseViewController{
    func setAttributedString(btn: UIButton){
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : btn.titleLabel!.font!,
            NSAttributedString.Key.foregroundColor : btn.titleLabel!.textColor,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: (btn.titleLabel?.text)!,
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
    }
}
class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}

extension UITextField{
    func isEmpty() -> Bool{
        if (self.text?.isEmpty)!{
            return true
        }
        return false
    }
    
//    func isValidPassword() -> Bool{
//        if ((self.text?.count)! < 6){
//            return false
//        }
//        return true
//    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,15}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self.text)
    }
    
    func isValidCotactNumber() -> Bool{
        
        if (self.text?.count)! < 10 || (self.text?.count)! > 10 {
            return false
        }
        
        return true
    }
}
 extension UITextView{
    func isEmpty() -> Bool{
        if (self.text?.isEmpty)!{
            return true
        }
        return false
    }
}
extension String{
    
    func trim() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
extension UIColor{
    class func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: (NSCharacterSet.whitespacesAndNewlines as NSCharacterSet) as CharacterSet).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

