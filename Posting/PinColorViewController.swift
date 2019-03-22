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
import FirebaseDatabase
import MapKit
import CoreLocation
import SVProgressHUD

class PinColorViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedColor : String = ""
    var myArray : [PostData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //デリゲート
        mapView.delegate = self
        
    //pinColor = serectedColor の　情報をfirebaseから取得する
        //もしGreenが選択されたとき
        let selectedColor = "Green"
        //pinColor:String （今回はGreen）で検索
        let uid = Auth.auth().currentUser?.uid
        let postRef = Database.database().reference().child("posts").child(uid ?? "")
        postRef
            .queryOrdered(byChild: "pinsColor")
            .queryEqual(toValue: selectedColor)
            .observeSingleEvent(of: .value, with: { snapshot in
                print("DEBUG_PRINT: .childAddedイベントが発生しました。")
                // PostDataクラスを生成して受け取ったデータを設定する
                if let uid = Auth.auth().currentUser?.uid {
                //let postData = PostData(snapshot: snapshot, myId: uid)
                //print("DEBUG_PRINT: coordinate →　\(postData)")
                    
                guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {
                    return
                }
                    
                //for文で繰り返される前にArrayを初期化
                self.myArray = []
                for snapshot in snapshots {
                    let postData = PostData(snapshot: snapshot, myId: uid)
                    self.myArray.insert(postData, at: 0)
                    //print("DEBUG_PRINT: postData →　\(myArray)")
                
                    
                    //firebaseから タップの数，色，チラシの種類，緯度の配列,　経度の配列，日付　を取得
                let uid = Auth.auth().currentUser?.uid
                    for location in postData.coordinate ?? [] {
                        let latStr = location["lat"] as? String ?? ""
                        let lngStr = location["lng"] as? String ?? ""
                        let postData = PostData(snapshot: snapshot, myId: uid ?? "")
                        print("DEBUG_PRINT : lngStr　→　\(lngStr)")
                        
                        if let lat = Double(latStr), let lng = Double(lngStr) {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2DMake(lat, lng)
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                    
                    }
                    
                }
                })
                
        }
    
    
    
    
    //戻るボタンが押されたときに呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        print("DEBUG_PRINT : キャンセルが押されました")
        let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
        self.present(tabBarViewController!, animated: true, completion: nil)
    }
    
    
}
