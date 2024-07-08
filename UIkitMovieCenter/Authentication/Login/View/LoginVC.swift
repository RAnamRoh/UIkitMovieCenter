//
//  LoginVC.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 4/7/24.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    let viewModel = AuthViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    

 
    @IBAction func SignInBtnTapped(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            loginUser(email: email, password: password)
        }
        
    }
    
    
    func loginUser(email : String, password : String){
        
        Task{
            do {
                try await viewModel.signIn(withEmail: email, password: password)
                navigateToHome()
            }
            catch {
                print("There was a problem \(error)")
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

extension LoginVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}
