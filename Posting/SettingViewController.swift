//
//  SettingViewController.swift
//  Posting
//
//  Created by Nakajima Mizuki on 2019/03/18.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class SettingViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // ログアウトボタンをタップしたときに呼ばれるメソッド
    }

    
    @IBAction func handleLogoutButton(_ sender: Any) {
        // ログアウトする
            try! Auth.auth().signOut()
            
            // ログイン画面を表示する
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
            
            // ログイン画面から戻ってきた時のためにホーム画面（index = 0）を選択している状態にしておく
            //let tabBarController = parent as! ESTabBarController
            //tabBarController.setSelectedIndex(0, animated: false)
            
        
        
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
