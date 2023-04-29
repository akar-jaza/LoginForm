//
//  SignupViewController.swift
//  Quizzi
//
//  Created by Akar jaza on 4/28/23.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .plain()
        button.backgroundColor = UIColor(rgb: 0xFF6B63FF)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .plain()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(rgb: 0xFF6B63FF), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let continueAsGuestButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .plain()
        button.setTitle("Continue as Guest", for: .normal)
        button.setTitleColor(UIColor(rgb: 0xFF6B63FF), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueAsGuestButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "already have an account?"
        return label
    }()
    
    var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .center
        return stackView
    }()
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xFF6B63FF)]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Sign Up"
        
        view.backgroundColor = .white
        
        // Load image from file
        let image = UIImage(named: "welcome.svg")
        
        // Create image view and set image
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(imageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(bottomStackView)
        view.addSubview(loadingView)
        view.addSubview(loadingIndicator)
        view.addSubview(loginButton)
        view.addSubview(continueAsGuestButton)
        
        
        bottomStackView.addSubview(bottomLabel)
        
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            continueAsGuestButton.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 20),
            continueAsGuestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorMessageLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            errorMessageLabel.widthAnchor.constraint(equalToConstant: 250),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            bottomLabel.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor),
            
            loginButton.centerYAnchor.constraint(equalTo: bottomLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: bottomLabel.trailingAnchor),
            
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -120),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc private func signUpButtonTapped() {
        let homeVC = HomeViewController()
        
        loadingView.isHidden = false
        loadingIndicator.startAnimating()
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
  
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
                
            self.loadingView.isHidden = true
            self.loadingIndicator.stopAnimating()
            
            if let e = error {
                self.errorMessageLabel.text = e.localizedDescription
                return
            }
            
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    
    
    @objc private func loginButtonTapped() {
        let loginVc = LoginViewController()
        
        if let navController = self.navigationController {
            // Navigation controller exists, you can push or pop view controllers here
            navController.pushViewController(loginVc, animated: true)
            
        } else {
            // Navigation controller doesn't exist, you may need to present a new navigation controller or dismiss the current view controller
            print("err")
        }
    }
    
    @objc private func continueAsGuestButtonTapped() {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}




