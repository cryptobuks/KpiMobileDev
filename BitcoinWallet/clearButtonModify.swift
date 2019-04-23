//
//  clearButtonModify.swift
//  BitcoinWallet
//
//  Created by Lado on 20/3/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

extension UITextField {
    func modifyClearButton(with image : UIImage) {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 10.0, y: 10.0, width: 12.0, height: 12.0)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(UITextField.clear(_:)), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
    }
    
    @objc func clear(_ sender : AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}

