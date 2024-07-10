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
    
    
    @IBOutlet var signUpButton: UIButton!
    
    let viewModel = AuthViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self

        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        fNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
               
        validateFields()
        
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
                showAlert(message: "There was a Problem Creating the Account : Error \(error)")
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
        guard let email = emailTextField.text, let password = passwordTextField.text, let fullName = fNameTextField.text else {
             signUpButton.isEnabled = false
             return
         }
        signUpButton.isEnabled = Utilities.isValidEmail(email) && !password.isEmpty && password.count > 5
     }
    
    
    

}


extension SignUpVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
