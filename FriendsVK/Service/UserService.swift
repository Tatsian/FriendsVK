//
//  UserService.swift
//  FriendsVK
//
//  Created by Tatsiana on 13.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import VK_ios_sdk

final class UserService {
    
    static func loadUserInfo(completion: @escaping (UIImage?, String?) -> Void ) {
        
        let request: VKRequest = VKRequest(method: "users.get",
                                           parameters: ["fields": "photo_50"])
        
        request.execute(
            resultBlock: {
                (response) -> Void in
                
                guard let responseString = response?.responseString as String?,
                    let responseData = responseString.data(using: .utf8) else {
                        completion(nil, nil)
                        return
                }
                do {
                    let usersList = try JSONDecoder().decode(UserResponseWrapped.self, from: responseData)
                    let user = usersList.response[0]
                    print(user)
                    //                        self.navigationItem.title = self.user?.name
                    guard let url = URL(string: user.photo50) else {
                        completion(nil, nil)
                        return
                    }
                    
                    UIImage.loadFrom(url: url) { image, _ in
                        guard let img = image else {
                            completion(nil, nil)
                            return
                        }
          
                        completion(img, user.name)
                    }
                } catch {
                    print("there is an error: \(error)")
                    completion(nil, nil)
                }
        }, errorBlock: {
            (error) -> Void in
            print("error")
            completion(nil, nil)
        })
    }
}
