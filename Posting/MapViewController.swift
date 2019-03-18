//
//  MapViewController.swift
//  Posting
//
//  Created by Nakajima Mizuki on 2019/03/18.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    //CLLocationManagerを定義
    var myLocationManager:CLLocationManager!
    //タップされた回数
    var tapped = 1
    //ロングタップしたときに立てるピンを定義
    var pinByLongPress:MKPointAnnotation!
    
    //var pinTintColor:UIColor!
    
    //ロングタップされたときに呼ばれるメソッド
    @IBAction func longPressMap(_ sender: UILongPressGestureRecognizer) {
        //ロングタップの最初の感知のみ受け取る
        if(sender.state != UIGestureRecognizer.State.began){
            return
        }
        //ロングタップを検出したことと回数をログに表示
        print("DEBUG_PRINT : long tapped \(tapped)")
        tapped += 1
        
        //インスタンス化
        pinByLongPress = MKPointAnnotation()
        
        //ピンの色を設定
        //mapView?.pinTintColor = UIColor.purpleColor()
       
        
        //ロングタップから位置情報を取得
        let location:CGPoint = sender.location(in: mapView)
        
        //取得した位置情報をCLLocationCoordinate2D（座標）に変換
        let longPressedCoordinate:CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
        
        
        
        //ロングタップした位置の座標をピンに入力
        pinByLongPress.coordinate = longPressedCoordinate
        print("DEBUG_PRINT : \(longPressedCoordinate)")
        //ピンを追加する（立てる）
        mapView.addAnnotation(pinByLongPress)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //現在地周辺を表示する
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .followWithHeading
    }
    

    
    //キャンセルボタンが押されたときのメソッド
    @IBAction func handleCanceiButton(_ sender: Any) {
        print("DEBUG_PRINT : キャンセルが押されました")
        let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
        self.present(tabBarViewController!, animated: true, completion: nil)
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
