//
//  LocationAnnotationView.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 25.09.2020.
//

import UIKit
import MapKit

class LocationAnnotationView: MKAnnotationView {
    private var imageView: UIImageView!
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(x: 0, y: 0, width: 70, height: 85)
        self.canShowCallout = true
        
        let backgroundImageView = UIImageView(image: UIImage(named: "annotationArrow"))
        backgroundImageView.frame = self.frame
        
        self.imageView = UIImageView(frame: CGRect(x: 18, y: 15, width: 33, height: 33))
        self.imageView.layer.cornerRadius = imageView.frame.width / 2
        self.imageView.clipsToBounds = true
        
        let leftCalloutImageView = UIImageView(image: UIImage(named: "leftCallOutImage"))
        leftCalloutImageView.frame.size = CGSize(width: 20, height: 20)
        self.leftCalloutAccessoryView = leftCalloutImageView
        
        if let annotation = self.annotation as? UserAnnotation {
            let rightView = UIView()
            rightView.frame.size = CGSize(width: 75, height: 20)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 47, height: 20))
            label.textAlignment = .center
            if let batteryPrecentage = annotation.batteryPrecentage {
                label.text = "\(batteryPrecentage)%"
            }
            label.textColor = annotation.batteryColor
            rightView.addSubview(label)
            
            if let batteryImage = annotation.batteryImage{
                let batteryImageView = UIImageView(frame: CGRect(x: 52, y: 5, width: 21, height: 11))
                
                batteryImageView.image = UIImage(named: batteryImage)
                rightView.addSubview(batteryImageView)
            }
            self.rightCalloutAccessoryView = rightView
        }
        
        
        self.addSubview(backgroundImageView)
        self.addSubview(self.imageView)
        
    }
    
    override var image: UIImage? {
        get {
            return self.imageView.image
        }
        
        set {
            self.imageView.image = newValue
        }
    }
    
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
