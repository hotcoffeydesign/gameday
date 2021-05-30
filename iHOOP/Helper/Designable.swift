//
//  Designable.swift
//  BinguUser
//
//  Created by User on 17/08/17.
//  Copyright © 2017 Ajayy. All rights reserved.
//

import Foundation
import UIKit



@IBDesignable class RoundViewClass: UIView
{
    override func layoutSubviews()
    {
        layer.cornerRadius = bounds.size.width/2;
    }
    @IBInspectable var clipToBound: Bool = false {
        didSet {
            self.clipsToBounds = clipsToBounds
        }
    }
    
    @IBInspectable var maskToBounds : Bool = false  {
        didSet {
            layer.masksToBounds = maskToBounds
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
             layer.borderWidth = borderWidth
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

@IBDesignable class RoundImageClass: UIImageView
{
    override func layoutSubviews()
    {
        layer.cornerRadius = bounds.size.width/2;
    }
    @IBInspectable var clipToBound: Bool = false {
        didSet {
            self.clipsToBounds = clipsToBounds
        }
    }
    
    @IBInspectable var maskToBounds : Bool = false  {
        didSet {
            layer.masksToBounds = maskToBounds
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth/2
        }
        
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


@IBDesignable class MulaTextField : UITextField
{
    @IBInspectable var clipToBound: Bool = false {
        didSet {
            self.clipsToBounds = clipsToBounds
        }
    }
    
    @IBInspectable var maskToBounds : Bool = false  {
        didSet {
            layer.masksToBounds = maskToBounds
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

@IBDesignable class MulaButton : UIButton
{
    @IBInspectable var clipToBound: Bool = false {
        didSet {
            self.clipsToBounds = clipsToBounds
        }
    }
    
    @IBInspectable var maskToBounds : Bool = false  {
        didSet {
            layer.masksToBounds = maskToBounds
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
@IBDesignable class CirculerButton: UIButton
{
    override func layoutSubviews()
    {
        layer.cornerRadius = bounds.size.width/2;
    }
    @IBInspectable var clipToBound: Bool = false {
        didSet {
            self.clipsToBounds = clipsToBounds
        }
    }
    
    @IBInspectable var maskToBounds : Bool = false  {
        didSet {
            layer.masksToBounds = maskToBounds
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

@IBDesignable class SetViewClass : UIView
{
    override func layoutSubviews()
    {
        //layer.cornerRadius = bounds.size.width/2;
    }
    
    @IBInspectable var clipToBound: Bool = false {
        didSet {
            self.clipsToBounds = clipsToBounds
        }
    }
    
    @IBInspectable var maskToBounds : Bool = false  {
        didSet {
            layer.masksToBounds = maskToBounds
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var shadowColor:UIColor = .clear
        {
        didSet{
            self.layer.masksToBounds = false
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: 3, height: 3)
            self.layer.shadowRadius = 1

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

@IBDesignable class SmartFoodImage: UIImageView
{
//    override func layoutSubviews()
//    {
//        layer.cornerRadius = self.frame.size.width / 2
//    }
//
    @IBInspectable var clipToBound: Bool = true {
        didSet {
            self.clipsToBounds = clipsToBounds
        }
    }
    
    @IBInspectable var maskToBounds : Bool = true  {
        didSet {
            layer.masksToBounds = maskToBounds
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGPoint {
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        
    }
    
    @IBInspectable var shadowBlur: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue / 2.0
        }
    }
    
    @IBInspectable var shadowSpread: CGFloat = 0 {
        didSet {
            if shadowSpread == 0 {
                layer.shadowPath = nil
            } else {
                let dx = -shadowSpread
                let rect = bounds.insetBy(dx: dx, dy: dx)
                layer.shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

@IBDesignable class LableDesign: UILabel {
    override func layoutSubviews()
    {

    }
    
}

//MARK:- MenuCurveView
class curve: UIView {
    var semiCirleLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius(corners: [.topLeft], cornerRadii: CGSize(width: 20, height: 20))
    }
}
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.height , y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        addSublayer(border)
    }
}
extension UIView
{
    func cornerRadius(corners: UIRectCorner, cornerRadii: CGSize)
    {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: cornerRadii)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
    }
    
}

extension UIColor{
    func gradientColorLeft() -> UIColor {
        return UIColor(red: 92.0 / 255.0, green: 43.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0)
    }
    func gradientColorRight() -> UIColor {
        return UIColor(red: 113.0 / 255.0, green: 46.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
    }
}
extension UIView{
    func addCurves_Shape_BOTTOM()
    {
        let pathB = UIBezierPath()
        
        pathB.move(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        pathB.addLine(to: CGPoint(x: self.frame.size.width - (self.frame.size.width * 0.8), y: self.frame.size.height))
        
        pathB.addQuadCurve(to: CGPoint(x: self.frame.size.width, y: 0.0), controlPoint: CGPoint(x: self.frame.size.width * 0.7 + 20, y: self.frame.size.height * 0.7 + 20 ))
        
        
        pathB.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = pathB.cgPath
        
        
        // Create the gradient
        let theViewGradient = CAGradientLayer()
        theViewGradient.colors = [UIColor().gradientColorLeft().cgColor, UIColor().gradientColorRight().cgColor, UIColor().gradientColorRight().cgColor]
        theViewGradient.frame = self.bounds
        theViewGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        theViewGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(theViewGradient, at: 0)
        
        
        
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.shadowOffset = CGSize(width: -1.0, height: -1.0)
        shapeLayer.shadowRadius = 5
        
        self.layer.mask = shapeLayer
        
    }

    func addCurves_Shape_TOP()//(topView: UIView!)
    {
        let pathA = UIBezierPath()
        pathA.move(to: CGPoint(x: 0.0, y: 0.0))
        pathA.addLine(to: CGPoint(x: self.frame.size.width * 0.8, y: 0.0))
        
        pathA.addQuadCurve(to: CGPoint(x: 0.0, y: self.frame.size.height), controlPoint: CGPoint(x: self.frame.size.width * 0.3 - 20, y: self.frame.size.height * 0.3 - 20 ))
        //path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        
        pathA.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = pathA.cgPath
        
        // Create the gradient
        let theViewGradient = CAGradientLayer()
        theViewGradient.colors = [UIColor().gradientColorLeft().cgColor, UIColor().gradientColorRight().cgColor, UIColor().gradientColorRight().cgColor]
        theViewGradient.frame = self.bounds
        theViewGradient.startPoint = CGPoint(x: 0.0, y: 0.5)//CGPointMake(0.0, 0.5)
        theViewGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        //Add gradient to view
        self.layer.insertSublayer(theViewGradient, at: 0)
        //self.layer.mask = shapeLayer
        
        
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shapeLayer.shadowRadius = 5
        
        self.layer.mask = shapeLayer
        
        /*
         let shadowRadius: CGFloat = 5
         self.layer.shadowRadius = shadowRadius
         self.layer.shadowOffset = CGSize(width: 0, height: 10)
         self.layer.shadowOpacity = 0.5
         
         // how strong to make the curling effect
         let curveAmount: CGFloat = 20
         let shadowPath = UIBezierPath()
         
         // the top left and right edges match our view, indented by the shadow radius
         shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
         shadowPath.addLine(to: CGPoint(x: self.frame.size.width - shadowRadius, y: 0))
         
         // the bottom-right edge of our shadow should overshoot by the size of our curve
         shadowPath.addLine(to: CGPoint(x: self.frame.size.width - shadowRadius, y: self.frame.size.height + curveAmount))
         
         // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
         shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: self.frame.size.height + curveAmount), controlPoint1: CGPoint(x: self.frame.size.width, y: self.frame.size.height - shadowRadius), controlPoint2: CGPoint(x: 0, y: self.frame.size.height - shadowRadius))
         self.layer.shadowPath = shadowPath.cgPath
         */
    }
    
}
class  LableTextBorder: UILabel {
   
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        context?.setLineWidth(2)
        context?.setFillColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        
        )
        context!.setLineJoin(CGLineJoin.round)
        
        context?.setTextDrawingMode(.stroke)
        context?.setStrokeColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        
        
        
        
        
        drawText(in: rect)
    }

}

extension UILabel{
    
    func makeOutLine(oulineColor: UIColor, foregroundColor: UIColor){
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : oulineColor,
            NSAttributedString.Key.foregroundColor : foregroundColor,
            NSAttributedString.Key.strokeWidth : -4.0,
            NSAttributedString.Key.font : self.font
            ] as [NSAttributedString.Key : Any]
        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
}
}
//MARK:- Image Orientation fix
extension UIImage {
    
    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}
class SemiCirleView: UIView {
    
    var semiCirleLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if semiCirleLayer == nil {
            let arcCenter = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
            let circleRadius = bounds.size.width / 2
            let circlePath = UIBezierPath(arcCenter: arcCenter, radius: circleRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
            
            semiCirleLayer = CAShapeLayer()
            semiCirleLayer.path = circlePath.cgPath
            semiCirleLayer.fillColor = UIColor.red.cgColor
            layer.addSublayer(semiCirleLayer)
            
            // Make the view color transparent
            backgroundColor = UIColor.clear
        }
    }
}
