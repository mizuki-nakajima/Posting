//
//  InformationViewController.swift
//  Posting
//
//  Created by Nakajima Mizuki on 2019/03/18.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseAuth
import MapKit
import CoreLocation

class InformationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    //ピン検索が押されたときに呼ばれるメソッド
    @IBAction func handlePinButton(_ sender: Any) {
        let pinColorViewController = self.storyboard?.instantiateViewController(withIdentifier: "PinColor") as! PinColorViewController
        
        self.present(pinColorViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    //firebaseから タップの数，色，チラシの種類，緯度の配列,　経度の配列，日付　を取得
    
    
    ////ここからメモ/////
    //Greenのピンだけ表示させるとき
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
    }
    
}
