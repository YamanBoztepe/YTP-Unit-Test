//
//  String+Extensions.swift
//  MobvenUnitTest
//
//  Created by Yaman Boztepe on 17.07.2023.
//

import Foundation

extension Optional where Wrapped == String {
    
    var stringValue: String {
        return self ?? ""
    }
}
