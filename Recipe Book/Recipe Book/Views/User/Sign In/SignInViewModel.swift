//
//  SignInViewModel.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import Foundation
import FirebaseAuth

struct SignInViewModel {
    
    func signInAccount(email: String?, password: String?, completion: @escaping (Bool, Error?) -> Void) {
        
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            completion(false, NSError(domain: "Invalid input", code: -1, userInfo: [NSLocalizedDescriptionKey: "Please enter both email and password."])) ; return }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
            } else {
                print(Auth.auth().currentUser?.email)
                completion(true, nil)
            }
        }
    }
}
