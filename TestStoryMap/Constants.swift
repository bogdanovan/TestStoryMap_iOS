//
//  Constants.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 23.09.2020.
//

import Foundation

struct K {
    static let usersNavBarTitle = "Люди"
    static let profileNavBarTitle = "Профиль"
    static let userOnMapNavBarTitle = "Люди на карте"
    static let userProfileNavBarTitle = "Профиль"
    static let editProfileNavBarTitle = "Редактирование"
    
    static let userCellIdentifier = "userCell"
    static let placeCellIndetifier = "placeCell"
    static let addCellIndetifier = "addCell"
    
    static let userDetailSegue = "userDetailnfoSegue"
    static let userPathSegue = "userPathHistory"
    static let userFindSegue = "userFindOnMap"
    static let editUserInfoSegue = "editUserInfoSegue"
    
    static let pinName = "pin"
    static let customAnnotation = "customAnnotation"
    
    static let disclosureIndicatorName = "disclosureIndicator"
    
    struct Requests {
        static let token = "Token 42b7c720d8b681f517b18af9f295c3b0f3c55eaa"
        static let peopleListURL = "https://projectone.na4u.ru/api/v1/people/"
    }
    
    struct Images {
        static let batteryLow = "batteryLow"
        static let batteryMid = "batteryMid"
        static let batteryHigh = "batteryHigh"
    }
}
