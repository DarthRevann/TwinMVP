//
//  WelcomeViewController.swift
//  TwinMVP
//
//  Created by Firuza Raiymkul on 22.11.2023.
//

import UIKit
import ProgressHUD

class WelcomeViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backGroundImageiew: UIImageView!
    
    // MARK: ViewLifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
       setupBackgroundTouch()
    }
    

    // MARK: IBActions

    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        if emailTextField.text!.isEmpty && ((passwordTextField.text?.isEmpty) != nil) {
            ProgressHUD.showError("Пожалуйста, введите свою почту")
            print("User forgot text email")
            return
        }
        

        // Введите здесь логику для восстановления пароля с использованием введенного email
        // Например:
        // resetPassword(with: email)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Заполните поле!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        print("loginButtonPressed")
        
        if emailTextField.text != "" && passwordTextField.text != "" {
        
            FirebaseUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error, isEmailVerified) in
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                } else if isEmailVerified {
                    // вход в приложение
                    print("вход в приложение")
                } else {
                    ProgressHUD.showError("Пожалуйста, подтвердите свой email!")
                }
            }
        } else {
            ProgressHUD.showError("Заполните все поля!")
        }
        
    }
    
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
    }
    @IBAction func secondLoginButtonPressed(_ sender: Any) {
    }
    
    //MARK: - Setup
    
    private func setupBackgroundTouch() {
        backGroundImageiew.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backGroundTap))
        backGroundImageiew.addGestureRecognizer(tapGesture)
    }
    
    @objc func backGroundTap() {
        dismissKeyboard()
    }
    
    // MARK: Helpers
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
}
