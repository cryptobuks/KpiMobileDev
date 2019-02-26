//
//  ViewController2.swift
//  CloudStorage
//
//  Created by Lado on 12/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import FirebaseAuth
import HSBitcoinKit
import Alamofire
import SwiftyJSON
import JWTDecode

class ViewController2: UIViewController {

    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    @IBAction func action(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "logout", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        email.text = Auth.auth().currentUser?.email
        let date = Auth.auth().currentUser?.metadata.creationDate
        info.text = date?.description
        print(Auth.auth().currentUser?.email)
        
        test()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func test() {
        //GET request form JSON
        Alamofire.request("https://blockchain.info/rawblock/0000000000000bae09a7a393a8acded75aa67e46cb81f7acaa5ad94f9eacd103").responseJSON {(resData) -> Void in
            if resData.result.value != nil {
                let swiftyJsonVar = JSON(resData.result.value!)
                print(swiftyJsonVar)
            }
        }
        
        //get name from JWT
        do {
            let jwt = try decode(jwt: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c")
            print(jwt.body)
            let claim = jwt.claim(name: "name")
            print(claim.string)
        } catch {
            print("Error")
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
