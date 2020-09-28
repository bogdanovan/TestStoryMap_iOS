//
//  PeopleManager.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 24.09.2020.
//

import Foundation
import Alamofire
import UIKit
import Kingfisher

protocol PeopleManagerDelegate {
    func didUpdatePeople(users: [Users])
}

struct PeopleManager {
    let baseURL = K.Requests.peopleListURL
    let token = K.Requests.token
    
    var delegate: PeopleManagerDelegate?
    
    func performRequest() {
        let headers: HTTPHeaders = [
            "Authorization": K.Requests.token
        ]
        
        AF.request(K.Requests.peopleListURL, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success( _):
                do {
                    let decoder = JSONDecoder()
                    let usersData = try decoder.decode(PeopleData.self, from: response.data!)
                    let users = buildArrayOfPeople(data: usersData)
                    self.delegate?.didUpdatePeople(users: users)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Request error: \(error.localizedDescription)")
            }
        }
    }
    
    func buildArrayOfPeople(data: PeopleData) -> [Users] {
        var userArray: [Users] = []
        guard let users = data.peoples else { return userArray }
        for user in users {
            userArray.append(Users(id: user.id, avatar: user.photo, name: user.name))
        }
        
        guard let coordinates = data.coordinates else { return userArray }
        for  detail in coordinates {
            for user in userArray {
                if detail.user_id == user.id {
                    user.lat = detail.latitude
                    user.lon = detail.longitude
                    user.batteryPercentage = detail.battery_level
                }
            }
        }
        return userArray
    }
}

