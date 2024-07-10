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
    
    @IBOutlet var signInButton: UIButton!
    
    let viewModel = AuthViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
               
               validateFields()
        
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
                showAlert(message: "There was a problem: \(error.localizedDescription)")
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
    
    func showAlert(message: String) {
         let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alert, animated: true, completion: nil)
     }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
           validateFields()
       }
    
    func validateFields() {
         guard let email = emailTextField.text, let password = passwordTextField.text else {
             signInButton.isEnabled = false
             return
         }
        signInButton.isEnabled = Utilities.isValidEmail(email) && !password.isEmpty && password.count > 5
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
