//
//  SignUpViewController.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, AnimationTextViewDelegate {

    @IBOutlet weak var fieldsContainerView: UIScrollView!
    @IBOutlet weak var emailView: AnimationTextView!
    @IBOutlet weak var usernameView: AnimationTextView!
    @IBOutlet weak var passwordView: AnimationTextView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var signInContainerView: UIView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    private var currentPage: Page = .email
    private let errorMessageDefaultX: CGFloat = 66
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSwipeGesture = UISwipeGestureRecognizer()
        leftSwipeGesture .addTarget(self, action: #selector(SignUpViewController.handleSwipe))
        view.addGestureRecognizer(leftSwipeGesture)
        leftSwipeGesture.direction = UISwipeGestureRecognizer.Direction.left
        
        
        let rightSwipeGesture = UISwipeGestureRecognizer()
        rightSwipeGesture .addTarget(self, action: #selector(SignUpViewController.handleSwipe))
        view.addGestureRecognizer(rightSwipeGesture)
        navigationController?.isNavigationBarHidden = true
        emailView.configureForSignup(placeholder: "email address")
        usernameView.configureForSignup(placeholder: "username")
        passwordView.configureForSignup(placeholder: "password")
        passwordView.field.isSecureTextEntry = true
        if #available(iOS 12.0, *) {
            passwordView.field.textContentType = .oneTimeCode
        } else {
            passwordView.field.textContentType = .init(rawValue: "")
        }
        emailView.delegate = self
        usernameView.delegate = self
        passwordView.delegate = self
        errorLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func handleSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if currentPage == .username {
                    scrollToPage(.email)
                    errorLabel.text = ""
                } else if currentPage == .password {
                    scrollToPage(.username)
                    errorLabel.text = ""
                }
            case UISwipeGestureRecognizer.Direction.left:
                if currentPage == .username || currentPage == .email {
                    signUpAction()
                }
            default:
                break
            }
        }
    }
    
    // MARK: IB Actions
    
    @IBAction func signUpAction() {
        validateInputData()
        switch currentPage {
        case .email:
            if emailView.text.count == 0 {
                emailView.field.becomeFirstResponder()
            }
        case .username:
            if usernameView.text.count == 0 {
                usernameView.field.becomeFirstResponder()
            }
        case .password:
            if passwordView.text.count == 0 {
                passwordView.field.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func loginAction() {
        performSegue(withIdentifier: "signInSegue", sender: nil)
    }
    
    // MRKK: Private methods
    
    private func validateInputData() {
        if let text = errorLabel.text, !text.isEmpty {
            return
        }
        switch currentPage {
        case .email:
            validateEmail()
        case .username:
            validateUsername()
        case .password:
            validatePassword()
        }
    }
    
    private func validateEmail() {
        errorLabelTop.constant = errorMessageDefaultX
        if emailView.text.count == 0 {
            return
        }
        if emailView.text.isValidEmailAddress() {
            scrollToPage(.username)
        } else {
            errorLabel.text = ErrorMessage.invalidEmail
        }
    }
    
    private func validateUsername() {
        if usernameView.text.count == 0 {
            return
        }
        errorLabelTop.constant = errorMessageDefaultX
        if usernameView.text.count < 4 {
            errorLabel.text = ErrorMessage.invalidUsernameMinChars
        } else if usernameView.text.count > 20 {
            errorLabel.text = ErrorMessage.invalidUsernameMaxChars
        } else if usernameView.text.contains(" ") {
            errorLabel.text = ErrorMessage.invalidUsernameSpace
        } else if !usernameView.text.isValidUsername() {
            errorLabel.text = ErrorMessage.invalidUsernameNoLetter
        } else {
            scrollToPage(.password)
        }
    }
    
    private func validatePassword() {
        if passwordView.text.count == 0 {
            return
        }
        if passwordView.text.count >= 6 {
            let parameters = ["email": emailView.text,
                              "password": passwordView.text,
                              "username": usernameView.text]
            print("LOGIN WITH PARAMS \(parameters)")
            
            progressIndicator.startAnimating()
            let service = RequestService()
            let newUser = NewUser(email: emailView.text, username: usernameView.text, password: passwordView.text)
            service.signUp(user: newUser, confirmedPassword: passwordView.text) { result in
                self.progressIndicator.stopAnimating()
                switch result {
                case let .success(response):
                    UserManager.shared.save(user: response.user)
                    if let imageId = response.user.images?.first?.id {
                        UserManager.shared.set(imageId: imageId)
                    }
                    UserManager.shared.set(token: response.token)
                    MainRoutingService.openApplication(from: self)
                case let .failure(error):
                    self.errorLabel.text = error.localizedDescription
                }
            }
        } else {
            errorLabel.text = ErrorMessage.invalidPassword
        }
    }
    
    private func redTextViewIfNeeded(textView: AnimationTextView) {
        if textView == self.passwordView {
            if textView.text.count >= 6 {
                textView.line.backgroundColor = UIColor.main
            } else {
                textView.line.backgroundColor = UIColor.red
            }
        }
    }
    
    private func scrollToPage(_ page: Page) {
        let newOffset = CGPoint(x: view.bounds.size.width * CGFloat(page.rawValue), y: 0)
        fieldsContainerView.setContentOffset(newOffset, animated: true)
        pageControl.currentPage = page.rawValue
        currentPage = page
        if page == .password {
            signInContainerView.isHidden = true
            signUpButton.setTitle("Sign Up", for: .normal)
        } else {
            signInContainerView.isHidden = false
            signUpButton.setTitle("Next", for: .normal)
        }
    }
    
    private func setUserInterfaceEnabled(_ enabled: Bool) {
        signUpButton.isEnabled = enabled
        emailView.field.isEnabled = enabled
        usernameView.field.isEnabled = enabled
        passwordView.field.isEnabled = enabled
    }
    
    private func presentMainVC() {
        MainRoutingService.openApplication(from: self)
    }
    
    // MARK: AnimationTextViewDelegate
    
    func textFieldDidBeginEditing(animationTextView: AnimationTextView) {
        redTextViewIfNeeded(textView: animationTextView)
    }
    
    func textFieldDidChange(animationTextView: AnimationTextView) {
        errorLabel.text = ""
        if currentPage == .username {
            usernameView.field.text = usernameView.text.lowercased()
        }
        redTextViewIfNeeded(textView: animationTextView)
    }
    
    func didEndEditingText(animationTextView: AnimationTextView) {
        //
    }
    
    func textFieldShouldReturn(animationTextView: AnimationTextView) {
        animationTextView.field.resignFirstResponder()
        validateInputData()
    }

    enum Page: Int {
        case email = 0
        case username
        case password
    }
    
}

