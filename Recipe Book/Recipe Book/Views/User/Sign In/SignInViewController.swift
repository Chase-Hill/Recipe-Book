//
//  SignInViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit
import AuthenticationServices
import FirebaseAuth

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: SignInViewModel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInViewModel()
        let signInWithAppleButton = ASAuthorizationAppleIDButton()
        signInWithAppleButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signInWithAppleButton)
        NSLayoutConstraint.activate([
            signInWithAppleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            signInWithAppleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            signInWithAppleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            signInWithAppleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        signInWithAppleButton.addTarget(self, action: #selector(appleSignInButtonTapped), for: .touchUpInside)
    }
    
    @objc func appleSignInButtonTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [
            .email,
            .fullName
        ]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.delegate = self
        authController.performRequests()
    }
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        viewModel.signInAccount(email: userEmailTextField.text, password: userPasswordTextField.text) { success, error in
            if success == true {
                self.presentMainVC()
            } else {
                self.presentErrorAlertController(error: error?.localizedDescription ?? "Unknown Error")
            }
        }
    }
    
    // MARK: - Helper Functions
    #warning("Redo this how I might like it in the future. If time allows")
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

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension SignInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        <#code#>
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        <#code#>
    }
}
