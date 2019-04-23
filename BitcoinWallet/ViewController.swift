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
    
    var hexColor = BackGroundColor()
    
    var connect = AlamofireConnection()
    
    var status_ = ""
    
    var tokens = ""
    
    @IBOutlet weak var viewEmail: UIView!
    
    @IBOutlet weak var viewPassword: UIView!
    
    @IBOutlet weak var emailText: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passText: SkyFloatingLabelTextField!
    
    @IBOutlet weak var invalidEmail: UILabel!
    
    @IBOutlet weak var wrongPassword: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var cloudLabel: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func goRegisterView(_ sender: Any) {
        self.performSegue(withIdentifier: "goRegister", sender: self)
    }
    
    @IBAction func action(_ sender: UIButton) {
        
        //check email text
        if((emailText.text?.characters.count)! < 3 || !(emailText.text?.contains("@"))!) {
            emailText.errorColor = hexColor.hexStringToUIColor(hex: "#D37377")
            emailText.errorMessage = " "
            invalidEmail.isHidden = false
        }
        
        //check password
        if((passText.text?.characters.count)! < 6) {
            passText.errorColor = hexColor.hexStringToUIColor(hex: "#D37377")
            passText.errorMessage = " "
            wrongPassword.isHidden = false
        }
        
        //Login & Sign Up
        if emailText.text != "" && passText.text != "" {
            connect.login(email: emailText.text!, password: passText.text!)
            //DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
             //Login
            //print("START")
            //print(tokens)
            Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!, completion: { (user, error) in
                if user != nil {
                    // Sign in successful
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "mainpage") as! MainMenuViewController
                    //print("MIDL")
                    //vc.token_ = self.tokens
                    let navigation = UINavigationController(rootViewController: vc)
                    self.present(navigation, animated: true, completion: nil)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //set background color and label text color
        self.view.backgroundColor = hexColor.hexStringToUIColor(hex: "#292C34")
        cloudLabel.textColor = hexColor.hexStringToUIColor(hex: "#D8D8D8")
        //kepp a user log in, even if they close the app
        if Auth.auth().currentUser != nil {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainpage")
            let navigation = UINavigationController(rootViewController: vc)
            self.present(navigation, animated: true, completion: nil)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainpage")
//            self.present(vc!, animated: true, completion: nil)
        }
        wrongPassword.isHidden = true
        invalidEmail.isHidden = true
        
        emailText.keyboardAppearance = UIKeyboardAppearance.dark
        passText.keyboardAppearance = UIKeyboardAppearance.dark
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewEmail.layer.cornerRadius = 6.0
        viewEmail.clipsToBounds = true
        
        viewPassword.layer.cornerRadius = 6.0
        viewPassword.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        viewPassword.clipsToBounds = true
        
        //set padding for text
        emailText.setPadding()
        passText.setPadding()
        
        //set masked corner for passText
        passText.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        passText.clipsToBounds = true
        
        emailText.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        emailText.clipsToBounds = true
        
        //set placeholder for textfields and set colors
        emailText.placeholderColor = hexColor.hexStringToUIColor(hex: "#62656B")
        emailText.tintColor = hexColor.hexStringToUIColor(hex: "#62656B")
        emailText.selectedTitleColor = hexColor.hexStringToUIColor(hex: "#62656B")
        
        passText.placeholderColor = hexColor.hexStringToUIColor(hex: "#62656B")
        passText.tintColor = hexColor.hexStringToUIColor(hex: "#62656B")
        passText.selectedTitleColor = hexColor.hexStringToUIColor(hex: "#62656B")
        
        //set broder and color for textfields
        emailText.backgroundColor = hexColor.hexStringToUIColor(hex: "#1E1F23")
        emailText.layer.borderColor = hexColor.hexStringToUIColor(hex: "#1E1F23").cgColor
        emailText.layer.cornerRadius = 6.0
        emailText.layer.borderWidth = 2.0
        emailText.textColor = hexColor.hexStringToUIColor(hex: "#D8D8D8")
        
        passText.backgroundColor = hexColor.hexStringToUIColor(hex: "#1E1F23")
        passText.layer.borderColor = hexColor.hexStringToUIColor(hex: "#1E1F23").cgColor
        passText.layer.cornerRadius = 6.0
        passText.layer.borderWidth = 2.0
        passText.textColor = hexColor.hexStringToUIColor(hex: "#D8D8D8")
        
        //clear button
        //emailText.clearButtonMode = .whileEditing
        //passText.clearButtonMode = .whileEditing
        emailText.modifyClearButton(with: UIImage(named: "clear")!)
        passText.modifyClearButton(with: UIImage(named: "clear")!)
        
        emailText.delegate = self
        passText.delegate = self
        
        emailText.returnKeyType = UIReturnKeyType.next
        passText.returnKeyType = UIReturnKeyType.go
        
        //after pressing return key type go to main page
        if passText.returnKeyType == UIReturnKeyType.go && Auth.auth().currentUser != nil {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainpage")
            let navigation = UINavigationController(rootViewController: vc)
            self.present(navigation, animated: true, completion: nil)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainpage")
//            self.present(vc!, animated: true, completion: nil)
        }
        
        //set background for button
        actionButton.setTitleColor(hexColor.hexStringToUIColor(hex: "#68C80C"), for: .normal)
        registerBtn.setTitleColor(hexColor.hexStringToUIColor(hex: "#68C80C"), for: .normal)
        
        //set corner for button
        actionButton.layer.borderColor = hexColor.hexStringToUIColor(hex: "#97C961").cgColor
        actionButton.clipsToBounds = true
        actionButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        actionButton.layer.cornerRadius = 6.0
        actionButton.layer.borderWidth = 2.0
        
        //connect.login(email: "lado", password: "lado")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
    
    func getTks(_ tok: String) {
        print("Check")
        tokens = tok
        print(tokens)
        UserDefaults.standard.setValue(tokens, forKey: "tokens")
        UserDefaults.standard.synchronize()
    }
    
    func getStatus(_ status: String) -> String {
        status_ = status
        return status
    }
}

