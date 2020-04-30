//
//  AuthViewController.swift
//  FriendsVK
//
//  Created by Tatsiana on 21.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import VK_ios_sdk

final class AuthViewController: UIViewController {
  
    private let imageLogo = UIImageView()
    private let logInButton = UIButton(type: .system)
    private let scope = ["friends"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        logInButton.isHidden = true
        let sdkInstance = VKSdk.initialize(withAppId: "7424269")
        sdkInstance?.uiDelegate = self
        
        sdkInstance?.register(self)
        
        view.backgroundColor = UIColor(hex: "#416794")
        createLogoImg()
        createAuthorizationButton()
        createConstraints()
        
        
        
    }

    private func createLogoImg() {
        let image = UIImage(named: "vkImage")
        imageLogo.image = image
        imageLogo.transform = .init(translationX: 0, y: -200)
        UIView.animate(withDuration: 2, animations: {
            self.imageLogo.transform = .identity
        })
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageLogo)
    }
    
    private func createAuthorizationButton() {
        logInButton.backgroundColor = UIColor(hex: "#324F72")
        logInButton.layer.cornerRadius = 8
        logInButton.setTitle("Log In".localized, for: .normal)
        logInButton.addTarget(self, action: #selector(pressAuthButton), for: .touchUpInside)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logInButton)
    }
    
    @objc func pressAuthButton(_ sender: UIButton!) {
        print("It's perfect")
        VKSdk.authorize(scope)
//        
//        VKSdk.wakeUpSession(scope) { [weak self] (state, error) in
//            if state == .authorized {
//                self?.showFriendsPage()
//            } else {
//                self?.logInButton.isHidden = false
//
//            }
//        }
    }
    
    private func createConstraints() {
        let minSide = min(view.frame.width, view.frame.height)
        let width = minSide / 2
        let heightOfField: CGFloat = 40
        let intend: CGFloat = 20
        
        imageLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: width * 0.1).isActive = true
        imageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageLogo.heightAnchor.constraint(equalToConstant: width).isActive = true
        imageLogo.widthAnchor.constraint(equalToConstant: width).isActive = true

        logInButton.heightAnchor.constraint(equalToConstant: heightOfField).isActive = true
        logInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -intend).isActive = true
        logInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: intend).isActive = true
        logInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showFriendsPage() {
        let friendVC = FriendsPageViewController()
        let navVC = UINavigationController()
        navVC.viewControllers = [friendVC]
//        friendVC.modalPresentationStyle = .fullScreen
        view.window?.rootViewController = navVC
//        present(FriendsPageViewController(), animated: true, completion: nil)
    }
}

extension AuthViewController: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        guard result.token != nil else { return }
        dismiss(animated: true, completion: { [weak self] in
            self?.showFriendsPage()
        })
    }
    
    func vkSdkUserAuthorizationFailed() {
         print(#function)
    }
}
