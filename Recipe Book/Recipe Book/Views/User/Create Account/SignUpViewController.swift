//
//  SignUpViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: CreateAccountViewModel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateAccountViewModel()
    }
    // MARK: - Actions
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        viewModel.createAccount(email: userEmailTextField.text, password: userPasswordTextField.text, confirmPassword: confirmPasswordTextField.text) { success, error in
            if success == true {
                self.presentMainVC()
            } else {
                self.presentErrorAlertController(error: error?.localizedDescription ?? "Unknown Error")
            }
        }
    }
    
    // MARK: - Helper Functions
    func presentMainVC() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "HomeView")
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve // Note: - Might not need
        present(viewController, animated: true)
    }
    
    func presentErrorAlertController(error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
