//
//  SignUpViewController.swift
//  MobvenUnitTest
//
//  Created by Yaman Boztepe on 17.07.2023.
//

import UIKit

protocol SignUpDisplayLogic {
    func displayInvalidFields(_ invalidFields: [SignUp.FormInputKeys])
    func routeToHome()
}

class SignUpViewController: UIViewController, SignUpDisplayLogic {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    var interactor: SignUpBusinessLogic?
    var router: (SignUpRoutingLogic & SignUpDataPassing)?
    
    // MARK: - Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        let router = SignUpRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Submit Actions
    
    @IBAction func submitTapped(_ sender: Any) {
        let formInputs: [String: String] = [
            SignUp.FormInputKeys.email.rawValue: emailTextField.text.stringValue,
            SignUp.FormInputKeys.password.rawValue: passwordTextField.text.stringValue,
            SignUp.FormInputKeys.repeatPassword.rawValue: repeatPasswordTextField.text.stringValue
        ]
        
        interactor?.submitForm(formInputs)
    }
    
    func routeToHome() {
        router?.routeToHome()
    }
    
    // MARK: - View Actions
    func displayInvalidFields(_ invalidFields: [SignUp.FormInputKeys]) {
        [emailTextField, passwordTextField, repeatPasswordTextField]
            .forEach({ $0?.backgroundColor = .white })
        
        for field in invalidFields {
            switch field {
            case .email:
                emailTextField.backgroundColor = .red
            case .password:
                passwordTextField.backgroundColor = .red
            case .repeatPassword:
                repeatPasswordTextField.backgroundColor = .red
            }
        }
    }
    
}

