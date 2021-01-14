//
//  CustomButton.swift
//  MyCurrency
//
//  Created by Aleksandr Grek on 18.09.2020.
//  Copyright © 2020 Aleksandr Grek. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
            
        setShadow()
        
        if self.frame.height < 75 {
            layer.cornerRadius   = 17.5
        }
        else {
        
            layer.cornerRadius   = 43
            
        }
    

    }
    
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    
    
    func anotherShake(){
        
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.05
        shake.repeatCount   = 2
        shake.autoreverses  = true

        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)

        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)

        shake.fromValue     = fromValue
        shake.toValue       = toValue

        layer.add(shake, forKey: "position")
        
    }
    
    
    func roll(){
        
        CustomButton.animate(withDuration: 0.5) { () -> Void in
          self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }

        CustomButton.animate(withDuration: 0.5, delay: 0.35, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
          self.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
        
    }
    
}
