//
//  SignUpModels.swift
//  MobvenUnitTest
//
//  Created by Yaman Boztepe on 17.07.2023.
//

import Foundation

enum SignUp {
    
    enum Constans {
        static let nameMinLength = 2
        static let nameMaxLength = 10
        static let passwordMinLength = 8
        static let passwordMaxLength = 16
        static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    enum FormInputKeys: String {
        case name
        case email
        case password
        case repeatPassword
    }
}
