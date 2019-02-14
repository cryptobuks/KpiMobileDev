//
//  ViewController.swift
//  CloudStorage
//
//  Created by Lado on 12/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import FirebaseAuth
import LocalAuthentication

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var cloudLabel: UILabel!
    
    @IBOutlet weak var DarkSwitch: UISwitch!
    
    @IBAction func action(_ sender: UIButton) {
        
        if emailText.text != "" && Auth.auth().isSignIn(withEmailLink: emailText.text!) {
            //touch id
            let myContext = LAContext()
            let myLocalizedReasonString = "Biometric Authntication testing !! "
            
            var authError: NSError?
            if #available(iOS 8.0, macOS 10.12.1, *) {
                if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                    myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                        
                        DispatchQueue.main.async {
                            if success {
                                // User authenticated successfully, take appropriate action
                                print("Awesome!!... User authenticated successfully")
                                self.performSegue(withIdentifier: "goHome", sender: self)
                            } else {
                                // User did not authenticate successfully, look at error and take appropriate action
                                print("Sorry!!... User did not authenticate successfully")
                            }
                        }
                    }
                } else {
                    // Could not evaluate policy; look at authError and present an appropriate message to user
                    print("Sorry!!.. Could not evaluate policy.")
                }
            } else {
                // Fallback on earlier versions
                print("Ooops!!.. This feature is not supported.")
            }
        }
        
        if emailText.text != "" && passText.text != "" {
            if segmentControl.selectedSegmentIndex == 0 { //Login
                Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!, completion: { (user, error) in
                    if user != nil {
                        // Sign in successful
                        self.performSegue(withIdentifier: "goHome", sender: self)
                    } else {
                        if let myError = error?.localizedDescription {
                            let alertController = UIAlertController(title: "Error", message: myError, preferredStyle: UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                            print(myError)
                        } else {
                            let alertController = UIAlertController(title: "Error", message: "Error!", preferredStyle: UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                            print("Error!")
                        }
                    }
                })
            } else { //Sign up
                Auth.auth().createUser(withEmail: emailText.text!, password: passText.text!) { (user, error) in
                    if user != nil {
                        self.performSegue(withIdentifier: "goHome", sender: self)
                    } else {
                        if let myError = error?.localizedDescription {
                            let alertController = UIAlertController(title: "Error", message: myError, preferredStyle: UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                            print(myError)
                        } else {
                            let alertController = UIAlertController(title: "Error", message: "Error!", preferredStyle: UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                            print("Error!")
                        }
                    }
                }
            }
        }
    }
    
    var DarkOn = Bool()
    
    @IBAction func DarkAction(_ sender: Any) {
        if DarkSwitch.isOn == true {
            self.view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
            
            cloudLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        } else {
            self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cloudLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.emailText.delegate = self
        self.passText.delegate = self
        
        emailText.returnKeyType = UIReturnKeyType.next
        passText.returnKeyType = UIReturnKeyType.go
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
}

