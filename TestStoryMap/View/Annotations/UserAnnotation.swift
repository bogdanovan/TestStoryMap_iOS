//
//  ImageAnnotation.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 25.09.2020.
//

import UIKit
import CoreLocation
import MapKit

class UserAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
    var batteryPrecentage: Int?
    var batteryImage: String?
    var batteryColor: UIColor?
    
    override init() {
        self.coordinate = CLLocationCoordinate2D()
        self.title = nil
        self.subtitle = nil
        self.image = nil
        self.batteryPrecentage = nil
        self.batteryImage = nil
        self.batteryColor = nil
        
        super.init()
    }
}

