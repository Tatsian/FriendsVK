//
//  FriendsResponse2.swift
//  FriendsVK
//
//  Created by Tatsiana on 04.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import Foundation

struct FriendsResponseWrapped: Decodable {
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
//    let count: Int
    let items: [FriendsItems]
}

struct FriendsItems: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo50: String
    let online: Int
    
    var name: String { return firstName + " " + lastName}
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case online
    }
}
