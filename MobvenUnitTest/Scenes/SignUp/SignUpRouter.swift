//
//  SignUpRouter.swift
//  MobvenUnitTest
//
//  Created by Yaman Boztepe on 17.07.2023.
//

import UIKit

protocol SignUpRoutingLogic {
    func routeToHome()
}

protocol SignUpDataPassing { }

final class SignUpRouter: SignUpRoutingLogic, SignUpDataPassing {
    weak var viewController: SignUpViewController?
    var dataStore: SignUpDataStore?
    
    func routeToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let destVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            viewController?.present(destVC, animated: true)
        }
    }
}
