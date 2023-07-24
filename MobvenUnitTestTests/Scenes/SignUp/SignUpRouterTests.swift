//
//  SignUpRouterTests.swift
//  MobvenUnitTestTests
//
//  Created by Yaman Boztepe on 21.07.2023.
//

import XCTest
@testable import MobvenUnitTest

final class SignUpRouterTests: XCTestCase {
    // MARK: Subject Under Test
    
    var sut: SignUpRouter!
    
    // MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        sut = SignUpRouter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test Double
    
    private final class MockSignUpViewController: SignUpViewController {
        var isPresentCalled = false
        
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            isPresentCalled = true
        }
    }
    
    // MARK: Tests
    
    func test_routeToHome() {
        // Given
        let vc = MockSignUpViewController()
        sut.viewController = vc
        
        // When
        sut.routeToHome()
        
        // Then
        XCTAssertTrue(vc.isPresentCalled)
    }
}
