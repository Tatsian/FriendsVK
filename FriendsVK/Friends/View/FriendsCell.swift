//
//  FriendsCell.swift
//  FriendsVK
//
//  Created by Tatsiana on 28.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

final class FriendsCell: UITableViewCell {
    
    static let identifier = String(describing: FriendsCell.self)
    
    let nameLabel = UILabel()
    let friendsFoto = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createNameLabel()
        createFriendsFoto()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setCircularImageView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        friendsFoto.image = nil
    }
    
    func setCircularImageView() {
        friendsFoto.layer.cornerRadius = friendsFoto.frame.width / 2.0
    }
    
    private func createNameLabel() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
    }
    
    private func createFriendsFoto() {
        friendsFoto.layer.masksToBounds = true
        friendsFoto.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(friendsFoto)
    }
    
    private func createConstraints() {
        friendsFoto.anchor(top: contentView.topAnchor,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: nil,
                           paddingTop: 5,
                           paddingLeft: 5,
                           paddingBottom: 5,
                           paddingRight: 0,
                           width: 50,
                           height: 50,
                           enableInsets: false)
        nameLabel.anchor(top: contentView.topAnchor,
                         left: friendsFoto.rightAnchor,
                         bottom: nil,
                         right: nil,
                         paddingTop: 20,
                         paddingLeft: 10,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: contentView.frame.width / 2,
                         height: 0,
                         enableInsets: false)
        
        DispatchQueue.main.async {
            self.setNeedsLayout()
        }
    }
}
