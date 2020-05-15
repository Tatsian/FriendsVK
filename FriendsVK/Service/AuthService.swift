//
//  AuthService.swift
//  FriendsVK
//
//  Created by Tatsiana on 28.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func signInSucess()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private var appId = "7424269"
    private var vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }

    // MARK: VKSdkDelegate

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.signInSucess()
        }
    }

    func vkSdkUserAuthorizationFailed() {

    }

    //MARK: VKSdkUIDelegate

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(controller)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {

    }
}

