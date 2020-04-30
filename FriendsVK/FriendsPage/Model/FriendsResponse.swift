//
//  FriendsResponse.swift
//  FriendsVK
//
//  Created by Tatsiana on 28.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import Foundation

struct FriendsResponseWrapped: Decodable {
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
    var items: [FriendsItems]
    var profiles: [Profile]
}

struct FriendsItems: Decodable {
    var friendId: Int
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
        return getPhotoSize().height
    }
    var width: Int {
        return getPhotoSize().width
    }
    var srcBIG: String {
        return getPhotoSize().url
    }
    
    private func getPhotoSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct  PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100}
}
