//
//  RegistrationViewController.swift
//  BitcoinWallet
//
//  Created by Lado on 26/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    
    @IBOutlet weak var reneterPass: SkyFloatingLabelTextField!
    
    @IBOutlet weak var goButton: UIButton!
    
    
    @IBAction func goToLogin(_ sender: UIButton) {
        //check email text
        if((email.text?.characters.count)! < 3 || !(email.text?.contains("@"))!) {
            email.errorMessage = "Invalid email"
        }
        
        //check password
        if((password.text?.characters.count)! < 6) {
            password.errorMessage = "Invalid password"
        }
        
        if((reneterPass.text?.characters.count)! < 6) {
            reneterPass.errorMessage = "Password does not match"
        }
        
        if password.text != reneterPass.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                if error == nil && user != nil {
                    self.performSegue(withIdentifier: "goLoginer", sender: self)
                }
                else{
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
        registerLabel.textColor = hexStringToUIColor(hex: "#76B6D7")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set padding for text
        email.setPadding()
        password.setPadding()
        reneterPass.setPadding()
        
        //set masked corner for passText
        reneterPass.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        //set placeholder for textfields and set colors
        email.placeholder = "Email"
        email.placeholderColor = hexStringToUIColor(hex: "#76B6D7")
        email.tintColor = hexStringToUIColor(hex: "#76B6D7")
        email.selectedTitleColor = hexStringToUIColor(hex: "#76B6D7")
        
        password.placeholder = "Password"
        password.placeholderColor = hexStringToUIColor(hex: "#76B6D7")
        password.tintColor = hexStringToUIColor(hex: "#76B6D7")
        password.selectedTitleColor = hexStringToUIColor(hex: "#76B6D7")
        
        reneterPass.placeholder = "Reneter Password"
        reneterPass.placeholderColor = hexStringToUIColor(hex: "#76B6D7")
        reneterPass.tintColor = hexStringToUIColor(hex: "#76B6D7")
        reneterPass.selectedTitleColor = hexStringToUIColor(hex: "#76B6D7")
        
        //set broder and color for textfields
        email.backgroundColor = hexStringToUIColor(hex: "#1F384E")
        email.layer.cornerRadius = 12.0
        email.layer.borderWidth = 1.0
        email.layer.borderColor = hexStringToUIColor(hex: "#1F384E").cgColor
        email.textColor = hexStringToUIColor(hex: "#76B6D7")
        
        password.backgroundColor = hexStringToUIColor(hex: "#1F384E")
        password.layer.cornerRadius = 12.0
        password.layer.borderWidth = 2.0
        password.layer.borderColor = hexStringToUIColor(hex: "#1F384E").cgColor
        password.textColor = hexStringToUIColor(hex: "#76B6D7")
        
        reneterPass.backgroundColor = hexStringToUIColor(hex: "#1F384E")
        reneterPass.layer.cornerRadius = 12.0
        reneterPass.layer.borderWidth = 2.0
        reneterPass.layer.borderColor = hexStringToUIColor(hex: "#1F384E").cgColor
        reneterPass.textColor = hexStringToUIColor(hex: "#76B6D7")
        
        //clear button
        email.clearButtonMode = .whileEditing
        password.clearButtonMode = .whileEditing
        reneterPass.clearButtonMode = .whileEditing
        
        self.email.delegate = self
        self.password.delegate = self
        self.reneterPass.delegate = self
        
        email.returnKeyType = UIReturnKeyType.next
        password.returnKeyType = UIReturnKeyType.go
        reneterPass.returnKeyType = UIReturnKeyType.go
        
        //set background for button
        goButton.setTitleColor(hexStringToUIColor(hex: "#68C80C"), for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
