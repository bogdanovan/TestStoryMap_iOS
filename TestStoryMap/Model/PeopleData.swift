//
//  PeopleData.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 24.09.2020.
//

import Foundation

struct PeopleData: Decodable {
    let peoples: [People]?
    let coordinates: [Coordinates]?
}

struct People: Decodable {
    let id: Int
    let name: String
    let photo: String
}

struct Coordinates: Decodable {
    let user_id: Int
    let latitude: Double
    let longitude: Double
    let battery_level: Int
}
