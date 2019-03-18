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
import MapKit
import CoreLocation
import SVProgressHUD

class ViewController: UIViewController ,CLLocationManagerDelegate{

    //CLLocationManagerの入れ物を用意
    var myLocationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CLLocationManagerをインスタンス化
        myLocationManager = CLLocationManager()
    
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        myLocationManager.requestWhenInUseAuthorization()

        
    }
    


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
            // ログインしていないときの処理
            print("DEBUG_PRINT : ログインしていない場合の処理へ")
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }else{
            //2秒ログイン成功HUDを設定
            SVProgressHUD.showSuccess(withStatus: "ログイン")
            SVProgressHUD.dismiss(withDelay: 2)
            
            let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
            self.present(tabBarViewController!, animated: true, completion: nil)
        }
    }
    
    //位置情報取得に失敗したときに呼び出されるメソッド
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG_PURINT : error")
    }
    

}

