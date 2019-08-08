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
import FirebaseDatabase
import MapKit
import CoreLocation

class InformationViewController: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var postArray: [PostData] = []
    var location :String?
    
    // DatabaseのobserveEventの登録状態を表す
    //var observing = false
    
    //ピン検索が押されたときに呼ばれるメソッド
    @IBAction func handlePinButton(_ sender: Any) {
        let pinColorViewController = self.storyboard?.instantiateViewController(withIdentifier: "PinColor") as! PinColorViewController
        
        self.present(pinColorViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG_PRINT: mapViewDidLoad")
        
        //現在地周辺を表示する
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .followWithHeading
        
        
        if Auth.auth().currentUser != nil {
            print("DEBUG_PRINT: currentUserはnilじゃない")
                // 要素が追加されたらpostArrayに追加してmapView再表示する
            let uid = Auth.auth().currentUser?.uid
            let postsRef = Database.database().reference().child(Const.PostPath).child(uid ?? "")
            postsRef.observe(.childAdded, with: { snapshot in
                print("DEBUG_PRINT: .childAddedイベントが発生しました。")
                    
                // PostDataクラスを生成して受け取ったデータを設定する
                if let uid = Auth.auth().currentUser?.uid {
                let postData = PostData(snapshot: snapshot, myId: uid)

                print("DEBUG_PRINT: coordinate →　\(postData.coordinate)")
                   
                //firebaseから タップの数，色，チラシの種類，緯度の配列,　経度の配列，日付　を取得
                    for location in postData.coordinate ?? [] {
                        let latStr = location["lat"] as? String ?? ""
                        let lngStr = location["lng"] as? String ?? ""
                        print("DEBUG_PRINT : lngStr　→　\(lngStr)")
            
                        if let lat = Double(latStr), let lng = Double(lngStr) {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2DMake(lat, lng)
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                    }
                })

        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        
    }
    
}
