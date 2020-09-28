//
//  RectangleButton.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 24.09.2020.
//

import UIKit

class RectangleButton: UIView {
    
    override func draw(_ rect: CGRect) {
    }
    
    override func layoutSubviews() {
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
        shadowLayer.fillColor = UIColor.systemBackground.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        shadowLayer.shadowOpacity = 0.05
        shadowLayer.shadowRadius = 5
        
        self.layer.insertSublayer(shadowLayer, at: 0)
        
    }
    
    
}
