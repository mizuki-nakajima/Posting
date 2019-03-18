//
//  ViewController.swift
//  Posting
//
//  Created by Nakajima Mizuki on 2019/03/18.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit
import RAMAnimatedTabBarController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG_PRINT : viewcontroller")
        
        
    }
    


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("DEBUG_PRINT : viewDidAppear")
        // currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
            // ログインしていないときの処理
            print("DEBUG_PRINT : ログインしていない場合の処理へ")
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }else{
            let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
            self.present(tabBarViewController!, animated: true, completion: nil)
        }
    }
    

}

