//
//  LocationAnnotationView.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 25.09.2020.
//

import UIKit
import MapKit

class LocationAnnotationViewSelected: MKAnnotationView {
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
        
        self.addSubview(backgroundImageView)
//        self.addSubview(self.imageView)
        
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
