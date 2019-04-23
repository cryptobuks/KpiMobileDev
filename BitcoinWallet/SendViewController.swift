//
//  SendViewController.swift
//  BitcoinWallet
//
//  Created by Lado on 29/3/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {
    var _token: String?
    
    var hexColor = BackGroundColor()
    
    var sendTransact = AlamofireConnection()

    @IBOutlet weak var ToView: UIView!
    
    @IBOutlet weak var AmountView: UIView!
    
    @IBOutlet weak var MemoView: UIView!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var textSendTo: UITextField!
    
    @IBOutlet weak var textAmount: UITextField!
    
    @IBOutlet weak var textComment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Send"
        self.navigationController?.navigationBar.barTintColor = hexColor.hexStringToUIColor(hex: "#1E1F23")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black

        // Do any additional setup after loading the view.
        ToView.layer.cornerRadius = 6.0
        ToView.clipsToBounds = true
        
        AmountView.layer.cornerRadius = 6.0
        AmountView.clipsToBounds = true
        
        MemoView.layer.cornerRadius = 6.0
        MemoView.clipsToBounds = true
        
        button1.layer.cornerRadius = 6.0
        button1.clipsToBounds = true
        
        button2.layer.cornerRadius = 6.0
        button2.clipsToBounds = true
        
        button3.layer.cornerRadius = 6.0
        button3.clipsToBounds = true
        
        button4.layer.cornerRadius = 6.0
        button4.clipsToBounds = true
        
        button5.layer.cornerRadius = 6.0
        button5.clipsToBounds = true
        
        sendButton.layer.cornerRadius = 6.0
        sendButton.clipsToBounds = true
        
        textSendTo.keyboardAppearance = .dark
        textAmount.keyboardAppearance = .dark
        textComment.keyboardAppearance = .dark
        print("Token")
        print(_token)
    }
    
    @IBAction func button1Pressed(_ sender: Any) {
        textAmount.text = "0.0001"
    }
    
    @IBAction func button2Pressed(_ sender: Any) {
        textAmount.text = "0.0010"
    }
    
    @IBAction func button3Pressed(_ sender: Any) {
        textAmount.text = "0.0100"
    }
    
    @IBAction func button4Pressed(_ sender: Any) {
        textAmount.text = "0.1000"
    }
    
    @IBAction func button5Pressed(_ sender: Any) {
        if let balance = UserDefaults.standard.value(forKey: "balance") as? String {
            textAmount.text = balance
        }
    }
    
    //change color of status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func sendButtonAct(_ sender: Any) {
        //token lado
        sendTransact.sendTransaction(token: _token!, address: textSendTo.text!, amount: textAmount.text!, comment: textComment.text!)
    }
    
    func get_status(_ data: String) {
        if data == "success" {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "success") as! SuccessViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "fail") as! FailViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
