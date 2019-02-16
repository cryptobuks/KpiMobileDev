//
//  OnlineOfflineService.swift
//  CloudStorage
//
//  Created by Lado on 15/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

//TODO: create database for firebase and send status

/*struct OnlineOfflineService {
    static func online(for uid: String, status: Bool, success: @escaping (Bool) -> Void) {
        //True == Online, False == Offline
        let onlinesRef = Database.database().reference().child(uid).child("isOnline")
        onlinesRef.setValue(status) {(error, _ ) in
            
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
            }
            success(true)
        }
    }
}*/
