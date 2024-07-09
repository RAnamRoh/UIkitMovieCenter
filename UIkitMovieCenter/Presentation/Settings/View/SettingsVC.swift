//
//  SettingsVC.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 1/7/24.
//

import UIKit

class SettingsVC: UIViewController {

    
    let viewModel = AuthViewModel.shared
    
    
    @IBOutlet var userInitials: UILabel!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var languageSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet var darkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPreferences()
       
    }
    

    
    @IBAction func darkModeSwitchChanged(_ sender: UISwitch) {
        
        toggleDarkMode(isOn: sender.isOn)
        
    }
    
    
    @IBAction func languageSegmentedControlChanged(_ sender: UISegmentedControl) {
        let selectedLanguage = sender.selectedSegmentIndex == 0 ? "en" : "bn"
       // changeLanguage(to: selectedLanguage)
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
    
    private func toggleDarkMode(isOn: Bool) {
        if #available(iOS 13.0, *) {
            let style: UIUserInterfaceStyle = isOn ? .dark : .light
            updateInterfaceStyleForAllWindows(style)
            UserDefaults.standard.set(isOn, forKey: "darkModeEnabled")
        }
    }
    
    private func loadPreferences() {
         // Load dark mode preference
         let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
         darkModeSwitch.isOn = darkModeEnabled
         toggleDarkMode(isOn: darkModeEnabled)
         
         // Load language preference
         let selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
         languageSegmentedControl.selectedSegmentIndex = selectedLanguage == "en" ? 0 : 1
     }
    
//    func changeLanguage(to language: String) {
//            Bundle.setLanguage(language)
//            UIApplication.shared.reloadRootViewController()
//        }
    
    private func updateInterfaceStyleForAllWindows(_ style: UIUserInterfaceStyle) {
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = style
            }
        }
    }
    
}
