//
//  RoundShadowView.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 24.09.2020.
//

import UIKit

class ShadowView: UIView {
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func drawShadow() {
        self.layer.shadowOpacity = 0.05
    }
    
    func removeShadow() {
        self.layer.shadowOpacity = 0
    }

}
