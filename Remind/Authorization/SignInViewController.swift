//
//  SignInViewController.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, AnimationTextViewDelegate {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameView: AnimationTextView!
    @IBOutlet weak var passwordView: AnimationTextView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    
    @IBOutlet weak var signUpContainer: UIView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        usernameView.configureForSignin(placeholder: "username")
        passwordView.configureForSignin(placeholder: "password")
        passwordView.field.isSecureTextEntry = true
        usernameView.delegate = self
        passwordView.delegate = self
        errorLabel.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameView.field.resignFirstResponder()
        passwordView.field.resignFirstResponder()
    }
    
    // MARK: IB Actions
    
    private func changeToLogin() {
        passwordView.field.resignFirstResponder()
        passwordView.field.isSecureTextEntry = true
        bottomButton.tag = 0
        errorLabel.text = ""
        UIView.animate(withDuration: 0.2) {
            self.passwordView.updateText("")
            self.usernameView.alpha = 1
            self.passwordView.label.text =  "password"
            self.loginButton.setTitle("Log In", for: .normal)
            self.forgotButton.alpha = 1
            self.bottomLabel.text = "Don't have an account?"
            self.bottomButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    @IBAction func bottomButtonTap() {
        if bottomButton.tag == 0 {
            navigationController?.popViewController(animated: true)
        } else {
            changeToLogin()
        }
    }
    
    @IBAction func signInAction() {
        let email = usernameView.text
        let pass = passwordView.text
        if !email.isEmpty && !pass.isEmpty {
            login(username: email, password: pass)
        } else if email.isEmpty {
            usernameView.field.becomeFirstResponder()
        } else {
            passwordView.field.becomeFirstResponder()
        }
    }
    
    private func startIndicatorAnimation() {
        self.progressIndicator.startAnimating()
        self.loginButton.setTitle(nil, for: .normal)
    }
    
    // MARK: Private methods
    
    private func login(username: String, password: String) {
        guard ReachabilityManager.isNetworkReachable() else {
            errorLabel.text = ErrorMessage.apiError
            return
        }
        setUserInterfaceEnabled(false)
        startIndicatorAnimation()
        let parameters = ["email": username, "password": password]
        print("LOGIN WITH PARAMS \(parameters)")
//        Alamofire.request(Api.login, method: .post, parameters: parameters, encoding: JSONEncoding.default) .responseJSON { [weak self] (response) in
//            self?.progressIndicator.stopAnimating()
//            self?.loginButton.setTitle("Log In", for: .normal)
//            if let value = response.value as? [String: Any] {
//                if let token = value["token"] as? String {
//                    UserPreferences.shared.authToken = token
//                    UserManager().registerDevice()
//                    UserManager().getUser(userID: nil, completion: { (user) in
//                        self?.presentMainVC()
//                    })
//                } else if let message = value["message"] as? String {
//                    self?.errorLabel.text = message
//                }
//            } else {
//                self?.errorLabel.text = ErrorMessage.apiError
//            }
//            self?.setUserInterfaceEnabled(true)
//        }
        // in completion
        MainRoutingService.openApplication(from: self)
    }
    
    private func setUserInterfaceEnabled(_ enabled: Bool) {
        loginButton.isEnabled = enabled
        bottomButton.isEnabled = enabled
        forgotButton.isEnabled = enabled
        usernameView.field.isEnabled = enabled
        passwordView.field.isEnabled = enabled
    }
    
    private func presentMainVC() {
        MainRoutingService.openApplication(from: self)
    }
    
    // MARK: AnimationTextViewDelegate
    
    func textFieldDidChange(animationTextView: AnimationTextView) {
        errorLabel.text = ""
    }
    
    func didEndEditingText(animationTextView: AnimationTextView) {
        //
    }
    
    func textFieldDidBeginEditing(animationTextView: AnimationTextView) {
        //
    }
    
    func textFieldShouldReturn(animationTextView: AnimationTextView) {
        if animationTextView == usernameView {
            passwordView.field.becomeFirstResponder()
        } else {
            passwordView.field.resignFirstResponder()
            if !usernameView.text.isEmpty && !passwordView.text.isEmpty {
                login(username: usernameView.text, password: passwordView.text)
            }
        }
    }
}

