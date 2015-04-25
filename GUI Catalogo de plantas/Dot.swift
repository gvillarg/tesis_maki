//
//  Dot.swift
//  Camera Demo
//
//  Created by Gustavo Villar on 4/22/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

import UIKit

@IBDesignable
class Dot: UIView {
    
    @IBInspectable
    var color: UIColor = UIColor.redColor()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        color.set()
        
        let radius = min(frame.size.width, frame.size.height) / 2
        let center = CGPointMake(frame.size.width / 2, frame.size.height / 2)
        
        var path = UIBezierPath()
        path.addArcWithCenter(center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        path.fill()
        
    }

}
