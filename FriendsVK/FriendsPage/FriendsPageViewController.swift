//
//  FriendsPageViewController.swift
//  FriendsVK
//
//  Created by Tatsiana on 24.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import VK_ios_sdk

final class FriendsPageViewController: UIViewController {
    
    let cellId = "cellId"
    var user: UserResponse?
    var friendsArray = [FriendsItems]()
    let tableView = UITableView()
//    let urlString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkGetUser()
        vkGetFriends()
        createNavigationItem()
        setupTableView()

    }

    private func createNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout".localized,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.title = "user name"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
//        let image = UIImage(named: "image2")
//        let imageView = UIImageView(image: image)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
        UINavigationBar.appearance().barTintColor = UIColor(hex: "#416794")
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
        tableView.register(FriendsPageTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func downloadData() {
        //  guard let url = URL(string: VKApiFriends.VKRequest.get) else { return }
    }
    
    func vkGetUser(){
        let request: VKRequest = VKRequest(method: "users.get",
                                          parameters: ["fields": "photo_50"])

        request.execute(
            resultBlock: {
                (response) -> Void in
                
                guard let responseString = response?.responseString as String? else { return }
                guard let responseData = responseString.data(using: .utf8) else { return }
                do {
                    let usersList = try JSONDecoder().decode(UserResponseWrapped.self, from: responseData)
                    self.user = usersList.response[0]
                    print(self.user)
                    DispatchQueue.main.async {
                        self.navigationItem.title = self.user?.name
                        guard let url = URL(string: self.user?.photo50 ?? "") else { return }

                        UIImage.loadFrom(url: url) { image in
                            guard let img = image else { return }
                            let imageView = UIImageView(image: image)
                            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
                        }
                    }
                } catch let error {
                    print("there is an error: \(error)")
                }
        }, errorBlock: {
            (error) -> Void in
            print("error")
        })

        
    }
    
    func vkGetFriends() {
        let requestFriends: VKRequest = VKRequest(method: "friends.get",
                                                  parameters: ["fields": "photo_50"])
        
        requestFriends.execute(
            resultBlock: {
                (response) -> Void in
                guard let responseString = response?.responseString as String? else { return }
                guard let responseData = responseString.data(using: .utf8) else { return }
                do {
                    let friendsList = try JSONDecoder().decode(FriendsResponseWrapped.self, from: responseData)
                    self.friendsArray = friendsList.response.items
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print(self.friendsArray)
                } catch let error {
                    print("there is an error: \(error)")
                }
        }, errorBlock: {
            (error) -> Void in
            print("error")
            
        })
    }
}

extension FriendsPageViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FriendsPageTableViewCell
        
        //        let currentFriends = friendsArray[indexPath.row]
        //        cell.textLabel?.text = currentFriends.name + " " +  currentFriends.lastName
        //        cell.friendsFoto.image = currentFriends.photo
        
        cell.friendsFoto.image = UIImage(named: "exFoto")
        cell.nameLabel.text = friendsArray[indexPath.row].name
        guard let url = URL(string: friendsArray[indexPath.row].photo50) else { return cell}

        UIImage.loadFrom(url: url) { image in
            cell.friendsFoto.image = image
        }

//        let url = URL(string: friendsArray[indexPath.row].photo50)
//
//         UIImage.loadFrom(url: url!) { image in
//             cell.friendsFoto.image = image
//         }
        return cell
    }
}
