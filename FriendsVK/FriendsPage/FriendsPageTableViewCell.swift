//
//  FriendsPageTableViewCell.swift
//  FriendsVK
//
//  Created by Tatsiana on 28.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

class FriendsPageTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let friendsFoto = UIImageView()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setCircularImageView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createNameLabel()
        createFriendsFoto()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCircularImageView() {
        self.friendsFoto.layer.cornerRadius = self.friendsFoto.frame.size.width / 2.0
    }
    
    private func createNameLabel() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
    }
    
    private func createFriendsFoto() {
        friendsFoto.layer.masksToBounds = true
        friendsFoto.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendsFoto)
    }
    
    private func createConstraints() {
        friendsFoto.anchor(top: topAnchor,
                           left: leftAnchor,
                           bottom: bottomAnchor,
                           right: nil,
                           paddingTop: 5,
                           paddingLeft: 5,
                           paddingBottom: 5,
                           paddingRight: 0,
                           width: 50,
                           height: 50,
                           enableInsets: false)
        nameLabel.anchor(top: topAnchor,
                         left: friendsFoto.rightAnchor,
                         bottom: nil,
                         right: nil,
                         paddingTop: 20,
                         paddingLeft: 10,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: frame.size.width / 2,
                         height: 0,
                         enableInsets: false)
    }
}
