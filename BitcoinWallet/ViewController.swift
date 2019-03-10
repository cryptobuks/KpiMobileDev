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
import SkyFloatingLabelTextField

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailText: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passText: SkyFloatingLabelTextField!
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var cloudLabel: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func goRegisterView(_ sender: Any) {
        performSegue(withIdentifier: "goRegister", sender: self)
    }
    
    @IBAction func action(_ sender: UIButton) {
        
        //check email text
        if((emailText.text?.characters.count)! < 3 || !(emailText.text?.contains("@"))!) {
            emailText.errorMessage = "Invalid email"
        }
        
        //check password
        if((passText.text?.characters.count)! < 6) {
            passText.errorMessage = "Invalid password"
        }
        
        //Login & Sign Up
        if emailText.text != "" && passText.text != "" {
             //Login
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
        } 
    }
    
    //background color using hex
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //set background color and label text color
        self.view.backgroundColor = hexStringToUIColor(hex: "#292C34")
        cloudLabel.textColor = hexStringToUIColor(hex: "#D8D8D8")
        //kepp a user log in, even if they close the app
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goHome", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set padding for text
        emailText.setPadding()
        passText.setPadding()
        
        //set masked corner for passText
        passText.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        passText.clipsToBounds = true
        
        emailText.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        emailText.clipsToBounds = true
        
        //set placeholder for textfields and set colors
        emailText.placeholder = "Email"
        emailText.placeholderColor = hexStringToUIColor(hex: "#D8D8D8")
        emailText.tintColor = hexStringToUIColor(hex: "#1E1F23")
        emailText.selectedTitleColor = hexStringToUIColor(hex: "#1E1F23")
        
        passText.placeholder = "Password"
        passText.placeholderColor = hexStringToUIColor(hex: "#D8D8D8")
        passText.tintColor = hexStringToUIColor(hex: "#1E1F23")
        passText.selectedTitleColor = hexStringToUIColor(hex: "#1E1F23")
        
        //set broder and color for textfields
        emailText.backgroundColor = hexStringToUIColor(hex: "#1E1F23")
        emailText.layer.borderColor = hexStringToUIColor(hex: "#1E1F23").cgColor
        emailText.layer.cornerRadius = 12.0
        emailText.layer.borderWidth = 2.0
        emailText.textColor = hexStringToUIColor(hex: "#D8D8D8")
        
        passText.backgroundColor = hexStringToUIColor(hex: "#1E1F23")
        passText.layer.borderColor = hexStringToUIColor(hex: "#1E1F23").cgColor
        passText.layer.cornerRadius = 12.0
        passText.layer.borderWidth = 2.0
        passText.textColor = hexStringToUIColor(hex: "#D8D8D8")
        
        //clear button
        emailText.clearButtonMode = .whileEditing
        passText.clearButtonMode = .whileEditing
        
        self.emailText.delegate = self
        self.passText.delegate = self
        
        emailText.returnKeyType = UIReturnKeyType.next
        passText.returnKeyType = UIReturnKeyType.go
        
        //set background for button
        actionButton.setTitleColor(hexStringToUIColor(hex: "#68C80C"), for: .normal)
        registerBtn.setTitleColor(hexStringToUIColor(hex: "#68C80C"), for: .normal)
        
        //set corner for button
        actionButton.layer.borderColor = hexStringToUIColor(hex: "#97C961").cgColor
        actionButton.clipsToBounds = true
        actionButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        actionButton.layer.cornerRadius = 12.0
        actionButton.layer.borderWidth = 2.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //rotation
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    //change color of status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

