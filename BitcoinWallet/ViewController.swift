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
        self.view.backgroundColor = hexStringToUIColor(hex: "#041D34")
        cloudLabel.textColor = hexStringToUIColor(hex: "#76B6D7")
        //kepp a user log in, even if they close the app
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goHome", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailText.setPadding()
        passText.setPadding()
        
        //set placeholder for textfields and set colors
        emailText.placeholder = "Email"
        emailText.placeholderColor = hexStringToUIColor(hex: "#76B6D7")
        emailText.tintColor = hexStringToUIColor(hex: "#76B6D7")
        emailText.selectedTitleColor = hexStringToUIColor(hex: "#76B6D7")
        
        passText.placeholder = "Password"
        passText.placeholderColor = hexStringToUIColor(hex: "#76B6D7")
        passText.tintColor = hexStringToUIColor(hex: "#76B6D7")
        passText.selectedTitleColor = hexStringToUIColor(hex: "#76B6D7")
        
        //set broder and color for textfields
        emailText.backgroundColor = hexStringToUIColor(hex: "#1F384E")
        emailText.layer.cornerRadius = 12.0
        emailText.layer.borderWidth = 2.0
        emailText.layer.borderColor = hexStringToUIColor(hex: "#1F384E").cgColor
        emailText.textColor = hexStringToUIColor(hex: "#76B6D7")
        
        passText.backgroundColor = hexStringToUIColor(hex: "#1F384E")
        passText.layer.cornerRadius = 12.0
        passText.layer.borderWidth = 2.0
        passText.layer.borderColor = hexStringToUIColor(hex: "#1F384E").cgColor
        passText.textColor = hexStringToUIColor(hex: "#76B6D7")
        
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
}

extension SkyFloatingLabelTextField {
    func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setBottomBorder() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
