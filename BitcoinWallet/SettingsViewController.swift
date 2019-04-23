//
//  SettingsViewController.swift
//  CloudStorage
//
//  Created by Lado on 14/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import Alamofire
import SwiftyJSON
import JWTDecode

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    var hexColor = BackGroundColor()
    
    var test = AlamofireConnection()
    
    var textForLabel: String = ""

    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    @IBAction func action(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "logout", sender: self)
    }
    
    @IBOutlet weak var namedTitleLabel: UITextField!
    
    @IBAction func sendEditLabel(_ sender: Any) {
        if namedTitleLabel.text?.isEmpty == false && namedTitleLabel.returnKeyType == .done {
            //delegate?.labelTitle.text = namedTitleLabel.text
            print(namedTitleLabel.text)
            namedTitleLabel.resignFirstResponder()
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainpage") as! MainMenuViewController
            UserDefaults.standard.set(namedTitleLabel.text, forKey: "labelname")
            UserDefaults.standard.synchronize()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        email.text = Auth.auth().currentUser?.email
        let date = Auth.auth().currentUser?.metadata.creationDate
        info.text = date?.description
        print(Auth.auth().currentUser?.email)
        
        self.namedTitleLabel.delegate = self
        //textFieldShouldReturn(textField: namedTitleLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = hexColor.hexStringToUIColor(hex: "#1E1F23")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override open var shouldAutorotate: Bool {
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
