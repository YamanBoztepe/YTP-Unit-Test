//
//  SignUpPresenterTests.swift
//  MobvenUnitTestTests
//
//  Created by Yaman Boztepe on 21.07.2023.
//

import XCTest
@testable import MobvenUnitTest

final class SignUpPresenterTests: XCTestCase {
    // MARK: Subject Under Test
    
    var sut: SignUpPresenter!
    
    // MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        sut = SignUpPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test doubles
    
    private final class SignUpDisplayLogicSpy: SignUpDisplayLogic {
        var displayInvalidFieldsCalled = false
        var routeToHomeCalled = false
        
        func displayInvalidFields(_ invalidFields: [MobvenUnitTest.SignUp.FormInputKeys]) {
            displayInvalidFieldsCalled = true
        }
        
        func routeToHome() {
            routeToHomeCalled = true
        }
    }
    
    // MARK: Tests
    
    func test_presentInvalidFields() {
        // Given
        let fields: [SignUp.FormInputKeys] = []
        let spy = SignUpDisplayLogicSpy()
        sut.viewController = spy
        
        // When
        sut.presentInvalidFields(fields)
        
        // Then
        XCTAssertTrue(spy.displayInvalidFieldsCalled)
    }
    
    func test_presentHomePage() {
        // Given
        let spy = SignUpDisplayLogicSpy()
        sut.viewController = spy
        
        // When
        sut.presentHomePage()
        
        // Then
        XCTAssertTrue(spy.routeToHomeCalled)
    }
    
}
