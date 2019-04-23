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
    
    var hexColor = BackGroundColor()
    
    var connect = AlamofireConnection()
    
    var token = ""
    
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    
    @IBOutlet weak var password: SkyFloatingLabelTextField!
 
    @IBOutlet weak var invalidEmail: UILabel!
    
    @IBOutlet weak var labelCharacter: UILabel!
    
    @IBOutlet weak var reneterPass: SkyFloatingLabelTextField!
    
    @IBOutlet weak var repeatPass: UILabel!
    
    @IBOutlet weak var goButton: UIButton!
    
    
    @IBOutlet weak var viewRegistration: UIView!
    
    
    @IBOutlet weak var viewPassword: UIView!
    
    
    @IBOutlet weak var viewRepeatPassword: UIView!
    
    @IBAction func goToLogin(_ sender: UIButton) {
        //check email text
        if((email.text?.characters.count)! < 3 || !(email.text?.contains("@"))!) {
            email.errorColor = hexColor.hexStringToUIColor(hex: "#D37377")
            email.errorMessage = " "
            invalidEmail.isHidden = false
        }
        
        //check password
        if((password.text?.characters.count)! < 6) {
            password.errorColor = hexColor.hexStringToUIColor(hex: "#D37377")
            password.errorMessage = " "
            labelCharacter.isHidden = false
            labelCharacter.textColor = hexColor.hexStringToUIColor(hex: "#D37377")
            labelCharacter.text = "Wrong password"
        }
        
        if((reneterPass.text?.characters.count)! < 6) {
            reneterPass.errorColor = hexColor.hexStringToUIColor(hex: "#D37377")
            reneterPass.errorMessage = " "
            reneterPass.isHidden = false
            repeatPass.textColor = hexColor.hexStringToUIColor(hex: "#D37377")
            repeatPass.text = "Password does not match"
        }
        
        if email.text != nil && password.text != nil && reneterPass.text != nil && password.text == reneterPass.text {
            connect.register(email: email.text!, password: password.text!)
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                if user != nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainpage")
                    self.present(vc!, animated: true, completion: nil)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //set background color and label text color
        self.view.backgroundColor = hexColor.hexStringToUIColor(hex: "#292C34")
        labelCharacter.isHidden = true
        repeatPass.isHidden = true
        invalidEmail.isHidden = true
        
        email.keyboardAppearance = UIKeyboardAppearance.dark
        password.keyboardAppearance = UIKeyboardAppearance.dark
        reneterPass.keyboardAppearance = UIKeyboardAppearance.dark
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewRegistration.layer.cornerRadius = 6.0
        viewRegistration.clipsToBounds = true
        
        viewPassword.layer.cornerRadius = 6.0
        viewPassword.clipsToBounds = true
        
        viewRepeatPassword.layer.cornerRadius = 6.0
        viewRepeatPassword.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        viewRepeatPassword.clipsToBounds = true
        
        //set padding for text
        email.setPadding()
        password.setPadding()
        reneterPass.setPadding()
        
        //set masked corner for email and passText
        email.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        email.clipsToBounds = true
        
        password.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        password.clipsToBounds = true
        
        reneterPass.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        reneterPass.clipsToBounds = true
        
        //set placeholder for textfields and set colors
        email.placeholderColor = hexColor.hexStringToUIColor(hex: "#62656B")
        email.tintColor = hexColor.hexStringToUIColor(hex: "#62656B")
        email.selectedTitleColor = hexColor.hexStringToUIColor(hex: "#62656B")
        
        password.placeholderColor = hexColor.hexStringToUIColor(hex: "#62656B")
        password.tintColor = hexColor.hexStringToUIColor(hex: "#62656B")
        password.selectedTitleColor = hexColor.hexStringToUIColor(hex: "#62656B")
        
        reneterPass.placeholderColor = hexColor.hexStringToUIColor(hex: "#62656B")
        reneterPass.tintColor = hexColor.hexStringToUIColor(hex: "#62656B")
        reneterPass.selectedTitleColor = hexColor.hexStringToUIColor(hex: "#62656B")
        
        //set broder and color for textfields
        email.backgroundColor = hexColor.hexStringToUIColor(hex: "#1E1F23")
        email.layer.cornerRadius = 6.0
        email.layer.borderWidth = 1.0
        email.layer.borderColor = hexColor.hexStringToUIColor(hex: "#1E1F23").cgColor
        email.textColor = hexColor.hexStringToUIColor(hex: "#D8D8D8")
        
        password.backgroundColor = hexColor.hexStringToUIColor(hex: "#1E1F23")
        password.layer.cornerRadius = 6.0
        password.layer.borderWidth = 2.0
        password.layer.borderColor = hexColor.hexStringToUIColor(hex: "#1E1F23").cgColor
        password.textColor = hexColor.hexStringToUIColor(hex: "#D8D8D8")
        
        reneterPass.backgroundColor = hexColor.hexStringToUIColor(hex: "#1E1F23")
        reneterPass.layer.cornerRadius = 6.0
        reneterPass.layer.borderWidth = 2.0
        reneterPass.layer.borderColor = hexColor.hexStringToUIColor(hex: "#1E1F23").cgColor
        reneterPass.textColor = hexColor.hexStringToUIColor(hex: "#D8D8D8")
        
        //clear button
//        email.clearButtonMode = .whileEditing
//        password.clearButtonMode = .whileEditing
//        reneterPass.clearButtonMode = .whileEditing
        
        email.modifyClearButton(with: UIImage(named: "clear")!)
        password.modifyClearButton(with: UIImage(named: "clear")!)
        reneterPass.modifyClearButton(with: UIImage(named: "clear")!)
        
        
        self.email.delegate = self
        self.password.delegate = self
        self.reneterPass.delegate = self
        
        email.returnKeyType = UIReturnKeyType.next
        password.returnKeyType = UIReturnKeyType.go
        reneterPass.returnKeyType = UIReturnKeyType.go
        
        password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        reneterPass.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        //set background for button
        goButton.setTitleColor(hexColor.hexStringToUIColor(hex: "#68C80C"), for: .normal)
        //set corner for button
        goButton.layer.borderColor = hexColor.hexStringToUIColor(hex: "#97C961").cgColor
        goButton.clipsToBounds = true
        goButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        goButton.layer.cornerRadius = 6.0
        goButton.layer.borderWidth = 2.0
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        labelCharacter.isHidden = false
        repeatPass.isHidden = false
    }
    
    func getData(_ data: String) {
        token = data
        print(token)
        UserDefaults.standard.setValue(token, forKey: "tokens")
        UserDefaults.standard.synchronize()
    }
    
    func getStatus(_ status: String) -> String {
        return status
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
