//
//  SettingsVC.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 1/7/24.
//

import UIKit

class SettingsVC: UIViewController {

    
    let viewModel = AuthViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        viewModel.signOut()
        navigateToRoot()
    }
    
    func navigateToRoot(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              if let loginNavController = storyboard.instantiateViewController(withIdentifier: "AuthNavController") as? UINavigationController {
                  if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                      sceneDelegate.window?.rootViewController = loginNavController
                      sceneDelegate.window?.makeKeyAndVisible()
                  }
              }
    }
    
}
