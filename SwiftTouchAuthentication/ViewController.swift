//
//  ViewController.swift
//  SwiftTouchAuthentication
//
//  Created by Anoop on 04/10/18.
//  Copyright © 2018 Anoop. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.authenticateUserUsingTouchId()
    }
    
    fileprivate func authenticateUserUsingTouchId() {
        print("Authentication started")
        let context = LAContext()
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil) {
            self.evaulateTocuhIdAuthenticity(context: context)
        }
    }
    
    func evaulateTocuhIdAuthenticity(context: LAContext) {
//        guard let lastAccessedUserName = UserDefaults.standard.object(forKey: "lastAccessedUserName") as? String else { return }
        let lastAccessedUserName = "anoop@meemmemory.com"
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: lastAccessedUserName) { (authSuccessful, authError) in
            if authSuccessful {
                print("Authentication is successful, proceed your work")
            } else {
                if let error = authError as? LAError {
                    self.showError(error: error)
                }
            }
        }
    }
    
    func showError(error: LAError) {
        var message: String = ""
        switch error.code {
        case LAError.authenticationFailed:
            message = "Authentication was not successful because the user failed to provide valid credentials. Please enter password to login."
            break
        case LAError.userCancel:
            message = "Authentication was canceled by the user"
            break
        case LAError.userFallback:
            message = "Authentication was canceled because the user tapped the fallback button"
            break
        case LAError.biometryNotEnrolled:
            message = "Authentication could not start because Touch ID has no enrolled fingers."
            break
        case LAError.passcodeNotSet:
            message = "Passcode is not set on the device."
            break
        case LAError.systemCancel:
            message = "Authentication was canceled by system"
            break
        default:
            message = error.localizedDescription
            break
        }
        print(message)
    }
    
}

