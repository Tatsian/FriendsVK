//
//  UserResponse.swift
//  FriendsVK
//
//  Created by Tatsiana on 28.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Codable {
    let firstName: String
    let lastName: String
    var photo50: String

    var name: String { return firstName + " " + lastName }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
}
