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
import SVProgressHUD
import RAMAnimatedTabBarController

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{

    @IBOutlet var mapView: MKMapView!
    
    var postData: PostData!
    //CLLocationManagerを定義
    var myLocationManager:CLLocationManager!
    //座標（ピン）保存用の配列
    //var coordinateData:[CLLocationCoordinate2D?] = []
    var locations :[[String:String]] = []
    //タップされた回数
    var tapped = 1
    //ロングタップしたときに立てるピンを定義
    var pinByLongPress:MKPointAnnotation!
    
    var annotationView: MKMarkerAnnotationView!
    var homeViewController: HomeViewController!
    
    //Homeでユーザーが選択した値を受け取る用の変数
    var pinColor : UIColor?
    var color : String?
    var flyerNameText : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // HUDを消す
        SVProgressHUD.dismiss()
        
        //座標（ピン）保存用の配列を空にする
        //coordinateData = []
        print("DEBUG_PRINT : \(color) \(flyerNameText)")
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
        
        //Step1　ロングタップされた位置の緯度(x),経度(y)をString型に変換して別々に取り出す
        let x : String  = String("\(longPressedCoordinate.latitude)")
        let y : String = String("\(longPressedCoordinate.longitude)")
        print("DEBUG_PRINT : 緯度\(x) 経度 \(y)")
        
        //座標（ピン）を保存する配列に追加する
      //  locations.append("lat" : "x" ,"lng":"y")
        print("DEBUG_PRINT: coordinateData \(locations)")
        
        
        /// ここからメモ ///
       
        
        //Step2　緯度,経度をそれぞれ配列に追加する
        var latitudeArray : [String] = []
        var longitudeArray : [String] = []
        latitudeArray.append(x)
        longitudeArray.append(y)
        print("DEBUG_PRINT : 緯度 \([latitudeArray]) 経度\([longitudeArray])")
        
        //Step３　firebaseにそれぞれ保存
        

        //Step４　InformationViewControllerで　CLLocationCoordinate2D型のDictionaryを用意
        //Step5 InformationViewControllerで　firebaseからxとyの配列をとってきてCLLocationCoordinate2D型のDictionaryに保存
       // エラーでる let outputCoordinateData:[CLLocationCoordinate2D?]  = ["latitude" : [latitudeArray], "longitude" : [longitudeArray]]
        //エラーでる outputCoordinateData = ["latitude":latitudeArray[0],"longitude":longitudeArray[0]]
        
        
        //Step6 InformationViewControllerで　表示
        //エラーでる　self.mapView.addAnnotation(outputCoordinateData as! MKAnnotation)
      
    
        
        //ピン表示の確認
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(36.94815218508667, 140.4935543190183)
        self.mapView.addAnnotation(annotation)
        ///ここまで///
        
        
        
        
        //ロングタップした位置の座標をピンに入力
        pinByLongPress.coordinate = longPressedCoordinate
        print("DEBUG_PRINT : \(longPressedCoordinate)")
        //ピンを刺す
        mapView.addAnnotation(pinByLongPress)
        
    }
    
    //「ポスティングを終了する」ボタンが押されたときに呼ばれるメソッド
    @IBAction func handleEndPostingButton(_ sender: Any) {
        print("DEBUG_PRINT : 終了ボタンが押されました")
        
        
        // postDataに必要な情報を取得しておく
        let time = Date.timeIntervalSinceReferenceDate
        //ユーザーに紐づけて，色とチラシの名前を保存する　データをmapに渡して，座標と一緒に保存
        if let uid = Auth.auth().currentUser?.uid {
            // HUDで処理中を表示
            SVProgressHUD.show()
            
            let postRef = Database.database().reference().child(Const.PostPath).child(uid)
            let post = ["flyerName": flyerNameText!,
                        "pinsColor": color,
                        "time":String(time)]
            postRef.childByAutoId().setValue(post)
        }
        
        //本当に終了しますかアラート
        
        
        
        //ユーザーに紐づける
    //    let postRef = Database.database().reference().child(Const.UserPath).child(Const.PostPath)
      //  let postDic = ["coordinate": coordinateData]
    //    postRef.childByAutoId().setValue(postDic)
        
        
    }
    
    //キャンセルボタンが押されたときのメソッド
    @IBAction func handleCanceiButton(_ sender: Any) {
        print("DEBUG_PRINT : キャンセルが押されました")
        let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
        self.present(tabBarViewController!, animated: true, completion: nil)
        
        //リセットする動きを追加する
        
        
    }

    
}
