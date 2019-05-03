//
//  SegueFromLeft.swift
//  BitcoinWallet
//
//  Created by Lado on 11/3/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import Foundation
import UIKit
class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .moveIn
        transition.subtype = .fromLeft
        
        source.view.window!.layer.add(transition, forKey: kCATransition)
        source.present(destination, animated: false, completion: nil)
    }
}
