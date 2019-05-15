//
//  QRCodeGenerateViewController.swift
//  BitcoinWallet
//
//  Created by Lado on 28/3/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import Loaf

class QRCodeGenerateViewController: UIViewController, UINavigationControllerDelegate {
    
    var hexColor = BackGroundColor()
    
    var addr = ""

    @IBOutlet weak var uiViewChange: UIView!
    
    @IBOutlet weak var QRCodeGen: UIImageView!
    
    @IBOutlet weak var UIViewQRCodeGen: UIView!
    
    @IBOutlet weak var lableInfoBTC: UILabel!
    
    @IBAction func copyAddress(_ sender: Any) {
        UIPasteboard.general.string = lableInfoBTC.text
        Loaf("Copied to Clipboard", state: .success, location: .bottom, presentingDirection: .right, dismissingDirection: .left, sender: self).show(.short)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiViewChange.layer.cornerRadius = 6.0
        uiViewChange.clipsToBounds = true
        
        lableInfoBTC.text = "\(addr)"
        
        UIViewQRCodeGen.layer.cornerRadius = 6.0
        UIViewQRCodeGen.clipsToBounds = true
        
        QRCodeGen.layer.cornerRadius = 6.0
        QRCodeGen.clipsToBounds = true
        QRCodeGen.image = generateQR(addr)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = hexColor.hexStringToUIColor(hex: "#1E1F23")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
        setUpNavBar()
    }

    func setUpNavBar(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Wallet", style: .plain, target: nil, action: nil)
    }
    
    func generateQR(_ string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    //change color of status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
