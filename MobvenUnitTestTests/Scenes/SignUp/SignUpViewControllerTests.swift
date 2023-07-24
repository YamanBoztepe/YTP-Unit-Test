//
//  SignUpViewControllerTests.swift
//  MobvenUnitTestTests
//
//  Created by Yaman Boztepe on 20.07.2023.
//

import XCTest
@testable import MobvenUnitTest

final class SignUpViewControllerTests: XCTestCase {
    // MARK:  Subject Under Test
    
    var sut: SignUpViewController!
    
    // MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test Doubles
    
    private final class SignUpBusinessLogicSpy: SignUpBusinessLogic {
        var submitFormCalled = false
        
        func submitForm(_ formInputs: [String : String]) {
           submitFormCalled = true
        }
    }
    
    private final class SignUpRoutingLogicSpy: SignUpRoutingLogic, SignUpDataPassing {
        var routeToHomeCalled = false
        
        func routeToHome() {
            routeToHomeCalled = true
        }
    }
    
    // MARK: Tests
    
    func test_submitTapped() {
        // Given
        let spy = SignUpBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        sut.submitTapped(UIButton())
        
        // Then
        XCTAssertTrue(spy.submitFormCalled)
    }
    
    func test_routeToHome() {
        // Given
        let spy = SignUpRoutingLogicSpy()
        sut.router = spy
        
        // When
        sut.routeToHome()
        
        // Then
        XCTAssertTrue(spy.routeToHomeCalled)
    }
    
    func test_displayInvalidFields_someFieldsAreInvalid() {
        // Given
        let invalidField: [SignUp.FormInputKeys] = [.email, .password]
        
        // When
        sut.displayInvalidFields(invalidField)
        
        // Then
        XCTAssertEqual(sut.emailTextField.backgroundColor, .red)
        XCTAssertEqual(sut.passwordTextField.backgroundColor, .red)
        XCTAssertEqual(sut.repeatPasswordTextField.backgroundColor, .white)
    }
    
    func test_displayInvalidFields_allFieldsAreInvalid() {
        // Given
        let invalidField: [SignUp.FormInputKeys] = [.email, .password, .repeatPassword]
        
        // When
        sut.displayInvalidFields(invalidField)
        
        // Then
        XCTAssertEqual(sut.emailTextField.backgroundColor, .red)
        XCTAssertEqual(sut.passwordTextField.backgroundColor, .red)
        XCTAssertEqual(sut.repeatPasswordTextField.backgroundColor, .red)
    }
}
