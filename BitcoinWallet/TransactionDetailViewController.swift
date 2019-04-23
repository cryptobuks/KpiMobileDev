//
//  TransactionDetailViewController.swift
//  BitcoinWallet
//
//  Created by Lado on 19/4/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import Loaf

class TransactionDetailViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var transactId: UILabel!
    
    @IBOutlet weak var Address: UILabel!
    
    @IBOutlet weak var Category: UILabel!
    
    @IBOutlet weak var Amount: UILabel!
    
    @IBOutlet weak var Confirm: UILabel!
    
    @IBOutlet weak var Time: UILabel!
    
    var backGrnd = BackGroundColor()
    
    @IBOutlet weak var transactView: UIView!
    
    @IBOutlet weak var addrView: UIView!
    
    @IBOutlet weak var categoryView: UIView!
    
    @IBOutlet weak var amountView: UIView!
    
    @IBOutlet weak var confirmView: UIView!
    
    @IBOutlet weak var timeView: UIView!
    
    
    var txid: String?
    var addr: String?
    var categoryies: String?
    var amounts: String?
    var confirms: String?
    var clock: String?
    
    var res: TansactionListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Information"
        
        transactView.layer.cornerRadius = 6.0
        transactView.clipsToBounds = true
        
        addrView.layer.cornerRadius = 6.0
        addrView.clipsToBounds = true
        
        categoryView.layer.cornerRadius = 6.0
        categoryView.clipsToBounds = true
        
        amountView.layer.cornerRadius = 6.0
        amountView.clipsToBounds = true
        
        confirmView.layer.cornerRadius = 6.0
        confirmView.clipsToBounds = true
        
        timeView.layer.cornerRadius = 6.0
        timeView.clipsToBounds = true
        
        transactId.text = txid
        transactId.isUserInteractionEnabled = true
        
        Address.text = addr
        Address.isUserInteractionEnabled = true
        
        Category.text = categoryies
        Category.isUserInteractionEnabled = true
        
        Amount.text = amounts
        Amount.isUserInteractionEnabled = true
        
        Confirm.text = confirms
        Confirm.isUserInteractionEnabled = true
        
        Time.text = clock
        Time.isUserInteractionEnabled = true
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(recognizer:)))
        gestureRecognizer.minimumPressDuration = 1.0
        //gestureRecognizer.allowableMovement = 15.0
        //gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.delegate = self
        transactId.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleLongPress(recognizer: UIGestureRecognizer) {
        UIPasteboard.general.string = transactId.text
        if let string = UIPasteboard.general.string {
//            let alertController = UIAlertController(title: "Copied to Clipboard", message: "Copied transaction id", preferredStyle: UIAlertController.Style.alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alertController, animated: true, completion: nil)
            Loaf("Copied to Clipboard", state: .success, location: .bottom, presentingDirection: .right, dismissingDirection: .left, sender: self).show(.short)
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
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
