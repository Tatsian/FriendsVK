//
//  UIImage.swift
//  FriendsVK
//
//  Created by Tatsiana on 06.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

extension UIImage {

    static func loadFrom(url: URL, completion: @escaping (UIImage?, URL?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data), url)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
            }
        }
    }
}
