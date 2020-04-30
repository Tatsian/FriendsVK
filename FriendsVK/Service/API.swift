//
//  API.swift
//  FriendsVK
//
//  Created by Tatsiana on 24.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.69"
    
    static let friendsFeed = "/method/friends.getRequests"
    static let user = "/method/users.get"
}
