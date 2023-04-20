//
//  SceneDelegate.swift
//  Recipe Book
//
//  Created by Chase on 3/29/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    var window: UIWindow?
    var handle: AuthStateDidChangeListenerHandle?

    // MARK: - Functions
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        handle = Auth.auth().addStateDidChangeListener{ auth, user in
            if Auth.auth().currentUser != nil {
              // User is signed in.
                // TODO: Initialize a User object
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = storyBoard.instantiateViewController(withIdentifier: "Navigation")
                self.window?.rootViewController = homeVC
            } else {
              // No user is signed in.
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let createAccount = storyBoard.instantiateViewController(withIdentifier: "CreateAccount")
                self.window?.rootViewController = createAccount
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
