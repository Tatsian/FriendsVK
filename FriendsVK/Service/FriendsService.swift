//
//  FriendsService.swift
//  FriendsVK
//
//  Created by Tatsiana on 13.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import VK_ios_sdk

final class FriendsService {
    
   static func loadFriendsInfo(completion: @escaping ([FriendsItems]) -> Void ) {
        let requestFriends: VKRequest = VKRequest(method: "friends.get",
                                                  parameters: ["fields": "photo_50"])
        
        requestFriends.execute(
            resultBlock: {
                (response) -> Void in
                guard let responseString = response?.responseString as String?,
                    let responseData = responseString.data(using: .utf8) else {
                    completion([])
                    return
                }
                do {
                    let friendsList = try JSONDecoder().decode(FriendsResponseWrapped.self, from: responseData)
                    let friends = friendsList.response.items
                    print(friends)
                    completion(friends)
                } catch let error {
                    print("there is an error: \(error)")
                    completion([])
                }
        }, errorBlock: {
            (error) -> Void in
            print("error")
            completion([])
        })
    }
    
}
