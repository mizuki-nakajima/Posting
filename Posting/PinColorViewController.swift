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

class PinColorViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedColor : String = ""
    var myArray : [PostData] = []
    
    @IBOutlet weak var colorPickerView: UIPickerView!
    let dataList = ["Red","Green","Blue","Cyan","Yellow","Magenta","Orange","Purple"]
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        print(dataList[row])
        return dataList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int,inComponent component: Int) {
        
        //datalistと同じ番地のcolorlistのカラーをselectedColorに代入
        self.selectedColor  = self.dataList[row]
         print("DEBUG_PRINT : 探す色 = \(selectedColor)")
        

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //デリゲート
        mapView.delegate = self
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        
        //現在地周辺を表示する
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .followWithHeading
       
        }
    
    
    @IBAction func handleSerch(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
        let postRef = Database.database().reference().child("posts").child(uid ?? "")
        postRef
            .queryOrdered(byChild: "pinsColor")
            .queryEqual(toValue: selectedColor)
            .observeSingleEvent(of: .value, with: { snapshot in
                print("DEBUG_PRINT: .childAddedイベントが発生しました。")
                // PostDataクラスを生成して受け取ったデータを設定する
                if let uid = Auth.auth().currentUser?.uid {
                    
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
