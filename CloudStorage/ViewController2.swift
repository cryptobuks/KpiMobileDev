//
//  ViewController2.swift
//  CloudStorage
//
//  Created by Lado on 12/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController2: UIViewController {

    @IBAction func action(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "logout", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(Auth.auth().currentUser?.email)
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
