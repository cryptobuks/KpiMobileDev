//
//  ViewController.swift
//  CloudStorage
//
//  Created by Lado on 12/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func action(_ sender: UIButton) {
        if emailText.text != "" && passText.text != "" {
            if segmentControl.selectedSegmentIndex == 0 { //Login
                Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!, completion: { (user, error) in
                    if user != nil {
                        // Sign in successful
                        self.performSegue(withIdentifier: "goHome", sender: self)
                    } else {
                        if let myError = error?.localizedDescription {
                            print(myError)
                        } else {
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
                            print(myError)
                        } else {
                            print("Error!")
                        }
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
}

