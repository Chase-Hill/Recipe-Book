//
//  SignUpViewModel.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit
import FirebaseAuth

struct CreateAccountViewModel {
    
    // MARK: - Functions
    func createAccount(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Bool, Error?) -> Void) {
        
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty,
              let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {
              completion(false, NSError(domain: "Invalid input", code: -1, userInfo: [NSLocalizedDescriptionKey: "Please enter both email and password."])) // Note: - Abstract later
            return
        }
        
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    completion(false, error)
                } else {
                    completion(true, nil)
                }
            }
        } else {
            completion(false, NSError(domain: "Invalid input", code: -1, userInfo: [NSLocalizedDescriptionKey: "Passwords do not match."]))
        }
    }
}
