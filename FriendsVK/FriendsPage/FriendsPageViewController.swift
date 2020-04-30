//
//  FriendsPageViewController.swift
//  FriendsVK
//
//  Created by Tatsiana on 24.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import VK_ios_sdk

class FriendsPageViewController: UIViewController {
    
    let cellId = "cellId"
    let friendsArray = [Profile]()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationItem()
        setupTableView()
    }

    private func createNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout".localized,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.title = "User name".localized
        let image = UIImage(named: "image2")
        let imageView = UIImageView(image: image)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
        UINavigationBar.appearance().barTintColor = UIColor(hex: "#416794")
    }
    
    @objc func logoutButtonPressed(_ sender: UIButton!) {
        VKSdk.forceLogout()
        let authController = AuthViewController()
        authController.modalPresentationStyle = .fullScreen
        view.window?.rootViewController = authController
        
        //    present(authController, animated: true, completion: nil)
        print("logout was pressed")
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.register(FriendsPageTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension FriendsPageViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FriendsPageTableViewCell
        //        cell.imageView?.clipsToBounds = true
        //        cell.imageView?.layer.borderWidth = 1
        //        cell.imageView?.layer.borderColor = (UIColor.white as! CGColor)
        //        cell.imageView?.layer.backgroundColor = (UIColor.black as! CGColor)
        //        cell.textLabel?.text = "Simple name"
        //        cell.imageView?.layer.masksToBounds = true
        //        cell.imageView?.layer.cornerRadius = 80
        
        //        let currentFriends = friendsArray[indexPath.row]
        //        cell.textLabel?.text = currentFriends.name + " " +  currentFriends.lastName
        //        cell.friendsFoto.image = currentFriends.photo
        
        cell.friendsFoto.image = UIImage(named: "exFoto")
        cell.nameLabel.text = "Simple name"
        
        return cell
    }
}
