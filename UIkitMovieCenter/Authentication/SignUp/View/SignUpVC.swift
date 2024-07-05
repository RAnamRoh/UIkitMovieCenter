//
//  SignUpVC.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 5/7/24.
//

import UIKit

class SignUpVC: UIViewController {

    
    
    @IBOutlet var fNameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    let viewModel = AuthViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func SignUpBtnPressed(_ sender: UIButton) {
       
      if let email = emailTextField.text,
        let fName = fNameTextField.text,
         let password = passwordTextField.text {
          
          signUpUser(email: email, password: password, fullName: fName)
      }
        
        
        
    }
    
    
    private func signUpUser(email : String, password : String, fullName : String){
        
        Task{
            do {
                try await viewModel.createUser(withEmail: email, password: password, fullName: fullName)
                navigateToHome()
            }
            catch{
                print("Problem Creating USer from Sign Up VC")
            }
        }
    }
    
    func navigateToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let homeNavController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = homeNavController
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            }
    }
    
    
    

}
