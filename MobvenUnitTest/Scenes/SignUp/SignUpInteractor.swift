//
//  SignUpInteractor.swift
//  MobvenUnitTest
//
//  Created by Yaman Boztepe on 17.07.2023.
//

import Foundation

protocol SignUpBusinessLogic {
    func submitForm(_ formInputs: [String: String])
}

protocol SignUpDataStore { }

final class SignUpInteractor: SignUpBusinessLogic, SignUpDataStore {
    var presenter: SignUpPresenter?
    var invalidFields: [SignUp.FormInputKeys] = []
    
    // MARK: - Form Submit
    
    func submitForm(_ formInputs: [String: String]) {
        validate(name: formInputs[SignUp.FormInputKeys.name.rawValue])
        validate(email: formInputs[SignUp.FormInputKeys.email.rawValue])
        validate(password: formInputs[SignUp.FormInputKeys.password.rawValue])
        validate(repeatPassword: formInputs[SignUp.FormInputKeys.password.rawValue],
                 accordingTo: formInputs[SignUp.FormInputKeys.repeatPassword.rawValue])
        
        if invalidFields.isEmpty {
            presenter?.presentHomePage()
        } else {
            presenter?.presentInvalidFields(invalidFields)
        }
    }
    
    // MARK: - Validation Logics
    
    func validate(name: String?) {
        guard let name else {
            configureInvalidField(isValid: false, field: .name)
            return
        }
        
        let isValidName = name.count > SignUp.Constans.nameMinLength && name.count < SignUp.Constans.nameMaxLength
        
        configureInvalidField(isValid: isValidName, field: .name)
    }
    
    func validate(email: String?) {
        guard let email = email, !email.isEmpty else {
            configureInvalidField(isValid: false, field: .email)
            return
        }
        
        let isValidEmail = NSPredicate(format: "SELF MATCHES %@",
                                       SignUp.Constans.emailRegEx).evaluate(with: email)
        
        configureInvalidField(isValid: isValidEmail, field: .email)
    }
    
    func validate(password: String?) {
        guard let password = password, !password.isEmpty else {
            configureInvalidField(isValid: false, field: .password)
            return
        }
        
        let isValidPassword = password.count > SignUp.Constans.passwordMaxLength || password.count < SignUp.Constans.passwordMinLength
        
        configureInvalidField(isValid: isValidPassword, field: .password)
    }
    
    func validate(repeatPassword: String?, accordingTo password: String?) {
        guard let password, let repeatPassword, !repeatPassword.isEmpty else {
            configureInvalidField(isValid: false, field: .repeatPassword)
            return
        }
        
        let isValidRepeatPassword = password == repeatPassword
        
        configureInvalidField(isValid: isValidRepeatPassword, field: .repeatPassword)
    }
    
    // MARK: - Helper Methods
    
    func configureInvalidField(isValid: Bool, field: SignUp.FormInputKeys) {
        isValid ? invalidFields.removeAll(where: { $0 == field }) : invalidFields.append(field)
    }
}
