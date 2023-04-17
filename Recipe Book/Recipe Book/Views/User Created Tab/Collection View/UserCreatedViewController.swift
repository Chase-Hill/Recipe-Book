//
//  UserCreatedViewController.swift
//  Recipe Book
//
//  Created by Chase on 4/11/23.
//

import UIKit
import FirebaseAuth

class UserCreatedViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var userRecipesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userRecipesCollectionView: UICollectionView!
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func signOutButtonTapped(_ sender: Any) {
        signOutAlert()
    }
    
    
    // MARK: - Functions
    #warning("Move to ViewModel later")
    func signOutAlert() {
        let alert = UIAlertController(title: "Signing Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
        let confirmAction = UIAlertAction(title: "Sign Out", style: .default) { _ in
            self.signOutAccount()
        }
        alert.addAction(dismissAction)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
    
    func signOutAccount() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
