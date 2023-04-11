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

    var window: UIWindow?
    var handle: AuthStateDidChangeListenerHandle?

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
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

