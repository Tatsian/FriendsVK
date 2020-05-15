//
//  AvatarView.swift
//  FriendsVK
//
//  Created by Tatsiana on 10.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

final class AvatarView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
    }
}
