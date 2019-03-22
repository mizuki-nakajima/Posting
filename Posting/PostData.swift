//
//  PostData.swift
//  Posting
//
//  Created by Nakajima Mizuki on 2019/03/19.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreLocation

class PostData: NSObject {
    var id: String? //投稿ID
    var profileId: String? //検索用グループID（アカウント作成時に取得　uidのコピー）
    var flyerName: String? //チラシの種類
    var date: Date?  //ポスティング日時
    var coordinate: [[String:String]] = []//ピンの位置 
    var pins: String?  //ポスティング件数
    var pinsColor: String? //ピンの色
    
    
    init(snapshot: DataSnapshot, myId: String) {
        print("DEBUG_PRINT : PostData/snapshot \(snapshot)")
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        self.profileId = valueDictionary["profileId"] as? String
        
        if let coordinate = valueDictionary["coordinate"] as? [[String:String]] {
            self.coordinate = coordinate
        }
        
        self.flyerName = valueDictionary["flyerName"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        self.pins = valueDictionary["pins"] as? String
        
        self.pinsColor = valueDictionary["pinsColor"] as? String
        
    }
}
