//
//  LoginPage.swift
//  Quizzi
//
//  Created by Akar jaza on 4/28/23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
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
    
    let loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .plain()
        button.backgroundColor = UIColor(rgb: 0xFF6B63FF)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .plain()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor(rgb: 0xFF6B63FF), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "New User?"
        return label
    }()
    
    var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 1
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Login"
        
        
        view.backgroundColor = .white
        
        // Load image from file
        let image = UIImage(named: "login.svg")
        
        // Create image view and set image
        let imageView = UIImageView(image: image)
        imageView.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(imageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginBtn)
        view.addSubview(errorMessageLabel)
        view.addSubview(bottomStackView)
        view.addSubview(loadingView)
        view.addSubview(loadingIndicator)
        view.addSubview(loginButton)
        
        
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
            
            
            loginBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginBtn.heightAnchor.constraint(equalToConstant: 50),
            
            
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorMessageLabel.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
            errorMessageLabel.widthAnchor.constraint(equalToConstant: 250),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            bottomLabel.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor),
            
            loginButton.centerYAnchor.constraint(equalTo: bottomLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: bottomLabel.trailingAnchor),
            
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -75),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc private func loginUpButtonTapped() {
        let homeVC = HomeViewController()
        
        loadingView.isHidden = false
        loadingIndicator.startAnimating()
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            
            self.loadingView.isHidden = true
            self.loadingIndicator.stopAnimating()
            
            if let e = error {
                self.errorMessageLabel.text = e.localizedDescription
                return
            }
            
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    
    
    @objc private func signupButtonTapped() {
        let loginVc = LoginViewController()
        
        if let navController = self.navigationController {
            // Navigation controller exists, you can push or pop view controllers here
            navController.popViewController(animated: true)
            
        } else {
            // Navigation controller doesn't exist, you may need to present a new navigation controller or dismiss the current view controller
            print("err")
        }
        
        
    }
    
    
}

