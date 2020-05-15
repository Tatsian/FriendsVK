//
//  FriendsPageViewController.swift
//  FriendsVK
//
//  Created by Tatsiana on 24.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import VK_ios_sdk

final class FriendsViewController: UIViewController {

    var friendsArray = [FriendsItems]()
    let tableView = UITableView()
    var avatarImageView = AvatarView()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        UserService.loadUserInfo { [weak self] (image, name) in
            self?.avatarImageView.image = image
            self?.avatarImageView.frame.size = image?.size ?? .zero
            self?.navigationItem.title = name
        }
        
        FriendsService.loadFriendsInfo { [weak self] (friends) in
            self?.friendsArray = friends 
            self?.tableView.reloadData()
        }
        
        createNavigationItem()
        setupTableView()
    }

    private func createNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout".localized,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        UINavigationBar.appearance().barTintColor = UIColor(hex: "#416794")
        avatarImageView.layer.masksToBounds = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: avatarImageView)
    }
    
    @objc func logoutButtonPressed(_ sender: UIButton!) {
        VKSdk.forceLogout()
        let authController = AuthViewController()
        authController.modalPresentationStyle = .fullScreen
        view.window?.rootViewController = authController
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: FriendsCell.identifier, for: indexPath) as? FriendsCell else {
                fatalError("unable to dequeue cell")
        }
        cell.nameLabel.text = friendsArray[indexPath.row].name
        guard let url = URL(string: friendsArray[indexPath.row].photo50) else {
            return cell
        }

        UIImage.loadFrom(url: url) { image, imageUrl  in
            if url == imageUrl {
                 cell.friendsFoto.image = image
            }
        }
        return cell
    }
}
