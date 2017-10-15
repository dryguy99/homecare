//
//  LoginViewController.swift
//
//
//  Created by Darshan Kalola on 10/14/17.
//  Copyright © 2017 Darshan Kalola. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // Constants
    private let loginSegue = "Login Segue"
    private let loginButtonText = "Login"
    private let registerButtonText = "Register"
    
    // Outlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // Create register/login button
    lazy var loginAndRegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = UIColor.blue
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 147.0/255.0, green: 190.0/255.0, blue: 223.0/255.0, alpha: 1.0)
        button.addTarget(self, action: #selector(loginOrRegister), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UITextField delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Setup
    override func viewDidLoad() {
        // Set the register button to a fixed with
        super.viewDidLoad()
        
        // Alter segmented control
        segmentedControl.layer.cornerRadius = 4.0
        segmentedControl.clipsToBounds = true
        
        view.addSubview(loginAndRegisterButton)
        setUpLoginAndRegisterButton()
    }
    
    // Prevents rotation
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fades in the login/register text fields
        UIView.animate(withDuration: 1.5) {
            self.email.alpha = 1.0
            self.phoneNumber.alpha = 1.0
            self.password.alpha = 1.0
        }
    }
    
    func setUpLoginAndRegisterButton() {
        loginAndRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginAndRegisterButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loginAndRegisterButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
    }
    
    // Actions
    @IBAction func handleSwitch(_ sender: UISegmentedControl) {
        // Clears text field when we switch from login mode to register mdoe
        email.text = ""
        password.text = ""
        phoneNumber.text = ""
    }
    
    func loginOrRegister(_ sender: UIButton) {
        // Login
        if segmentedControl.selectedSegmentIndex == 0 {
            initiateLogin()
        }
            // Register
        else {
            initiateRegister()
        }
    }
    
    func initiateLogin() {
        guard let _ = email.text, email.text != "", let _ = password.text, password.text != "" else {
            print("Invalid login information")
            return
        }
        
        // Move onto the next page, login will not be fully implemented
        // PERFORM SEGUE
        performSegue(withIdentifier: loginSegue, sender: nil)
    }
    
    func initiateRegister() {
        // Ensure user has entered valid information
        guard let _ = email.text, email.text != "", let _ = password.text, password.text != "", let _ = phoneNumber.text, phoneNumber.text != "" else {
            print("Invalid register information")
            return
        }
        
        // Move onto the next page, login will not be fully implemented
        // PERFORM SEGUE
        performSegue(withIdentifier: loginSegue, sender: nil)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Changes the title of the login/register button according to toggled
        // Removes the phone number text field for login
        loginAndRegisterButton.setTitle(segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex), for: .normal)
        
        // Login state
        if sender.selectedSegmentIndex == 0 {
            phoneNumber.isHidden = true
        }
            // Register state
        else {
            phoneNumber.isHidden = false
        }
    }
}
