//
//  RegisterViewController.swift
//  TwinMVP
//
//  Created by Firuza Raiymkul on 22.11.2023.
//

import UIKit
import ProgressHUD

class RegisterViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var backGroundImageiew: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextFIeld: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var genderSegmentOutlet: UISegmentedControl!
    
    // MARK: Variables
    
    var isMale = true
    
    
    // MARK: ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        setupBackgroundTouch()
        
    }
    
    // MARK: IBActions

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("backButtonPressed")
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if isTextDataImputed() {
            
            //register user
            if passwordTextField.text! == confirmPasswordTextField.text! {
                registerUser()
            } else {
                ProgressHUD.showError("Введённые пароли не совпадают!")
            }
        } else {
            
            ProgressHUD.showError("Нужно заполнить все поля")
            
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func genderSegmentValueChanged(_ sender: UISegmentedControl) {
        
        isMale = sender.selectedSegmentIndex == 0
        
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
    
    private func isTextDataImputed() -> Bool {
        
        return usernameTextField.text != "" && emailTextFIeld.text != "" && cityTextField.text != "" && birthdayTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != ""
        
    }
    
    // MARK: Register user
    private func registerUser() {
        
        ProgressHUD.show()
        
        FirebaseUser.registerUserWith(email: emailTextFIeld.text!, password: passwordTextField.text!, userName: usernameTextField.text!, city: cityTextField.text!, isMale: isMale, dateOfBirth: Date(), completion: {
                        
            error in
            
            print("Callback")
            
            if error == nil {
                ProgressHUD.showSuccess("На почту было отправлено")
            } else {
                ProgressHUD.showError(error!.localizedDescription)
            }
            
        })
        
    }
}
