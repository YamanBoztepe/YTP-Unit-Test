//
//  SignUpPresenter.swift
//  MobvenUnitTest
//
//  Created by Yaman Boztepe on 17.07.2023.
//

import Foundation

protocol SignUpPresentationLogic {
    func presentInvalidFields(_ invalidFields: [SignUp.FormInputKeys])
}

final class SignUpPresenter: SignUpPresentationLogic {
    var viewController: SignUpDisplayLogic?
    
    func presentInvalidFields(_ invalidFields: [SignUp.FormInputKeys]) {
        viewController?.displayInvalidFields(invalidFields)
    }
    
    func presentHomePage() {
        viewController?.routeToHome()
    }
}
