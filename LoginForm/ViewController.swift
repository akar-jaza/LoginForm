//
//  ViewController.swift
//  QuizzlerReal
//
//  Created by Akar jaza on 2/24/23.
//

import UIKit
import FirebaseAuth

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
//
class HomeViewController: UIViewController {
    
    let profileImage: UIImageView = {
        let image = UIImage(named: "profile.svg")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.text = "Welcome"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.natural
        label.numberOfLines = 0
        return label
    }()
    
    
    
    lazy var ContunueButton: UIButton = {
        let nextBtn = UIButton()
        nextBtn.configuration = .filled()
        nextBtn.configuration?.title = "Sign Out"
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.configuration?.baseBackgroundColor = .black
        nextBtn.configuration?.baseForegroundColor = .white
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        nextBtn.addTarget(self, action: #selector(continueButtonFunc(_:)), for: .touchUpInside)
        
        return nextBtn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(ContunueButton)
        self.view.addSubview(profileImage)
        
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15),
            welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            
            ContunueButton.heightAnchor.constraint(equalToConstant: 80),
            ContunueButton.widthAnchor.constraint(equalToConstant: 350),
            ContunueButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            ContunueButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
        ])
    }
    
    
    @objc func continueButtonFunc(_ sender: UIButton) {
        let SignUpVC = SignUpViewController()
        do {
            try Auth.auth().signOut()
//            SignUpVC.hidesBottomBarWhenPushed = true // hide tab bar on the next view controller
//            navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(SignUpVC, animated: false)
            
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
}
