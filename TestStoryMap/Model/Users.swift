//
//  User.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 23.09.2020.
//

import Foundation
import UIKit

class Users {
    var id: Int
    var avatar: String
    var name: String
    var batteryImage: String?
    var batteryPercentage: Int? {
        willSet {
            if newValue! >= 50 {
                batteryImage = K.Images.batteryHigh
                batteryColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
            } else if newValue! > 10 {
                batteryImage = K.Images.batteryMid
                batteryColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            } else if newValue! >= 0 {
                batteryImage = K.Images.batteryLow
                batteryColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            }
        }
    }
    var batteryColor: UIColor?
    var relation: String?
    var lon: Double?
    var lat: Double?
    var places: [Place]?
    
    init(id: Int, avatar: String, name: String) {
        self.id = id
        self.avatar = avatar
        self.name = name
    }
}
