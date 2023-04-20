//
//  SignInViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import CryptoKit

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: SignInViewModel!
    var nonce: String?
    
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
    
    // MARK: - Functions
    @objc func appleSignInButtonTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [
            .email,
            .fullName
        ]
        
        self.nonce = randomNonceString()
        request.nonce = sha256(nonce!)
        
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.delegate = self
        authController.performRequests()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        } .joined()
        
        return hashString
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
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Do something with this credential
            guard let nonce = self.nonce else {
                fatalError()
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Failed to get Apple Token") ; return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Failed to get id Token") ; return
            }
            let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            Auth.auth().signIn(with: firebaseCredential) { [weak self] result, error in
                //Do something after Firebase sign in has completed
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
}
