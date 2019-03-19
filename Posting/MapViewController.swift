//
//  MapViewController.swift
//  Posting
//
//  Created by Nakajima Mizuki on 2019/03/18.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import MapKit
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{

    @IBOutlet var mapView: MKMapView!
    //CLLocationManagerを定義
    var myLocationManager:CLLocationManager!
    //タップされた回数
    var tapped = 1
    //ロングタップしたときに立てるピンを定義
    var pinByLongPress:MKPointAnnotation!
    
    var annotationView: MKMarkerAnnotationView!
    var homeViewController: HomeViewController!
    //ユーザーが選択した色を受け取る用の変数
    var pinColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //選択した色を受け取れているかチェック　あとで消す
        if pinColor != nil {
            print("DEBUG_PRINT : pincolor = \(pinColor!)")
        }
        else {
            print("DEBUG_PRINT : pinColor = nilを受け取りました")
        }
        
        //デリゲート
        mapView.delegate = self
        
        //現在地周辺を表示する
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .followWithHeading
    }
    
    //必要なメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // これでわける
        if annotation is MKUserLocation {
            return nil
        }
    
        let pinID = "PIN"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pinID) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: pinID)
            //ピンの色を受け取った色に設定
            annotationView?.markerTintColor = pinColor
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }

    
    
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
        
        //ロングタップから位置情報を取得
        let location:CGPoint = sender.location(in: mapView)
        
        //取得した位置情報をCLLocationCoordinate2D（座標）に変換
        let longPressedCoordinate:CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
    
        
        //ロングタップした位置の座標をピンに入力
        pinByLongPress.coordinate = longPressedCoordinate
        print("DEBUG_PRINT : \(longPressedCoordinate)")
        //ピンを刺す
        mapView.addAnnotation(pinByLongPress)
    }
    
    

    
    //キャンセルボタンが押されたときのメソッド
    @IBAction func handleCanceiButton(_ sender: Any) {
        print("DEBUG_PRINT : キャンセルが押されました")
        let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
        self.present(tabBarViewController!, animated: true, completion: nil)
    }

    
}
