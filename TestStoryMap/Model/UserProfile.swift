//
//  UserProfile.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 27.09.2020.
//

import Foundation
import RealmSwift

class UserProfile: Object {
    @objc dynamic var name: String?
    @objc dynamic var avatar: String?
    @objc dynamic var defaultImage: Bool = false
}
