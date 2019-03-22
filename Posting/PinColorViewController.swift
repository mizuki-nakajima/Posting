//
//  PinColorViewController.swift
//  Posting
//
//  Created by Nakajima Mizuki on 2019/03/21.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class PinColorViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    //pinColor = serectedColor の　情報をfirebaseから取得する
    //例えばGreenを探す
        
      
        // Do any additional setup after loading the view.
    }
    
    
    
    
    //戻るボタンが押されたときに呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        print("DEBUG_PRINT : キャンセルが押されました")
        let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
        self.present(tabBarViewController!, animated: true, completion: nil)
    }
    
    
}
