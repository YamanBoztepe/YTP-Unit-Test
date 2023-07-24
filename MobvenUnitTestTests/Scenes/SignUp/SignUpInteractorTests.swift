//
//  SignUpInteractorTests.swift
//  MobvenUnitTestTests
//
//  Created by Yaman Boztepe on 21.07.2023.
//

import XCTest
@testable import MobvenUnitTest

final class SignUpInteractorTests: XCTestCase {
    // MARK: - Subject Under Test
    
    var sut: SignUpInteractor!
    
    // MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        sut = SignUpInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test Doubles
    
    private final class SignUpPresentationLogicSpy: SignUpPresentationLogic {
        var presentInvalidFieldsCalled = false
        var presentHomePageCalled = false
        
        func presentInvalidFields(_ invalidFields: [MobvenUnitTest.SignUp.FormInputKeys]) {
            presentInvalidFieldsCalled = true
        }
        
        func presentHomePage() {
            presentHomePageCalled = true
        }
    }
    
    // MARK: Tests
    
    func test_validateEmail_whenEmailIsValid() {
        // Given
        let validEmail = "test@mobven.com"
        
        // When
        sut.validate(email: validEmail)
        
        // Then
        XCTAssertFalse(sut.invalidFields.contains(where: { $0 == .email }))
    }
    
    func test_validateEmail_whenEmailsIsInvalid() {
        // Given
        let invalidEmail = "test"
        
        // When
        sut.validate(email: invalidEmail)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .email }))
    }
    
    func test_validateEmail_whenEmailIsNil() {
        // Given
        let invalidEmail: String? = nil
        
        // When
        sut.validate(email: invalidEmail)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .email }))
    }
    
    func test_validateEmail_whenEmailIsEmpty() {
        // Given
        let invalidEmail = ""
        
        // When
        sut.validate(email: invalidEmail)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .email }))
    }
    
    func test_validatePassword_whenPasswordIsValid() {
        // Given
        let validPassword = "123456789"
        
        // When
        sut.validate(password: validPassword)
        
        // Then
        XCTAssertFalse(sut.invalidFields.contains(where: { $0 == .password }))
    }
    
    func test_validatePassword_whenPasswordIsNil() {
        // Given
        let invalidPassword: String? = nil
        
        // When
        sut.validate(password: invalidPassword)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .password }))
    }
    
    func test_validatePassword_whenPasswordIsEmpty() {
        // Given
        let invalidPassword = ""
        
        // When
        sut.validate(password: invalidPassword)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .password }))
    }
    
    func test_validatePassword_whenPasswordIsShort() {
        // Given
        let shortPassword = "12345678"
        
        // When
        sut.validate(password: shortPassword)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .password }))
    }
    
    func test_validatePassword_whenPasswordIsLong() {
        // Given
        let shortPassword = "1234567891234567"
        
        // When
        sut.validate(password: shortPassword)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .password }))
    }
    
    func test_validateRepeatPassword_whenRepeatPasswordIsNil() {
        // Given
        let password = "123456789"
        let invalidRepeatPassword: String? = nil
        
        // When
        sut.validate(repeatPassword: invalidRepeatPassword, accordingTo: password)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .repeatPassword }))
    }
    
    func test_validateRepeatPassword_whenRepeatPasswordIsEmpty() {
        // Given
        let password = "123456789"
        let invalidRepeatPassword = ""
        
        // When
        sut.validate(repeatPassword: invalidRepeatPassword, accordingTo: password)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .repeatPassword }))
    }
    
    func test_validateRepeatPassword_whenRepeatPasswordIsValid() {
        // Given
        let password = "123456789"
        let invalidRepeatPassword = "123456789"
        
        // When
        sut.validate(repeatPassword: invalidRepeatPassword, accordingTo: password)
        
        // Then
        XCTAssertFalse(sut.invalidFields.contains(where: { $0 == .repeatPassword }))
    }
    
    func test_validateRepeatPassword_whenRepeatPasswordIsInvalid() {
        // Given
        let password = "123456789"
        let invalidRepeatPassword = "abcdefghijkl"
        
        // When
        sut.validate(repeatPassword: invalidRepeatPassword, accordingTo: password)
        
        // Then
        XCTAssertTrue(sut.invalidFields.contains(where: { $0 == .repeatPassword }))
    }
    
    func test_submitForm_whenInvalidFieldExists() {
        // Given
        let formInputs: [String: String] = [
            SignUp.FormInputKeys.email.rawValue: "test@mobven",
            SignUp.FormInputKeys.password.rawValue: "123456789",
            SignUp.FormInputKeys.repeatPassword.rawValue: "123456789"
        ]
        
        let spy = SignUpPresentationLogicSpy()
        sut.presenter = spy
        
        // When
        sut.submitForm(formInputs)
        
        // Then
        XCTAssertTrue(spy.presentInvalidFieldsCalled)
    }
    
    func test_submitForm_whenAllFieldsAreValid() {
        // Given
        let formInputs: [String: String] = [
            SignUp.FormInputKeys.email.rawValue: "test@mobven.com",
            SignUp.FormInputKeys.password.rawValue: "123456789",
            SignUp.FormInputKeys.repeatPassword.rawValue: "123456789"
        ]
        
        let spy = SignUpPresentationLogicSpy()
        sut.presenter = spy
        
        // When
        sut.submitForm(formInputs)
        
        // Then
        XCTAssertTrue(spy.presentHomePageCalled)
    }
}
