//
//  HomeViewController.swift
//  Posting
//
//  Created by Nakajima Mizuki on 2019/03/18.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class HomeViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var flyerNameTextField: UITextField!
    @IBOutlet weak var colorPickerView: UIPickerView!
    var selectedColor : UIColor?
    var saveColor:String!
    
    var postArray: [PostData] = []
    var postData: PostData!
    
    
    let dataList = ["選択してください","Red","Green","Blue","Cyan","Yellow","Magenta","Orange","Purple"]
    let colorList =  [UIColor.red, UIColor.red, UIColor.green, UIColor.blue, UIColor.cyan, UIColor.yellow, UIColor.magenta, UIColor.orange,UIColor.purple]

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PURINT_DEBUG : ログインしました")
        

        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        self.flyerNameTextField.delegate = self
        
        //print("DEBUG_PRINT : 未選択の状態  \(selectedColor!)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        flyerNameTextField.resignFirstResponder()
        return true
    }
    
    
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
        self.selectedColor  = self.colorList[row]
        //保存用カラー
        self.saveColor  = self.dataList[row]
        print("DEBUG_PRINT : pickerViewで選択した色 = \(selectedColor!)")
        print("DEBUG_PRINT : saveColor = \(saveColor!)")
        
    }
    

    @IBAction func handlePostingStartButton(_ sender: Any) {
        
        
        // チラシ名のいずれかでも入力されていない時は何もしない
        if let flyerName = flyerNameTextField.text {
            // チラシの種類，色のいずれかでも入力されていない時は何もしない
            if flyerName.isEmpty || saveColor.isEmpty  {
                print("DEBUG_PRINT: 何かが空です")
                return
            }
        }

         SVProgressHUD.show(withStatus: "ポスティングを開始")
        //キャストする
        let mapViewController = self.storyboard?.instantiateViewController(withIdentifier: "Map") as! MapViewController
       
        //selectedColorをMapViewControllerのpinColorに渡す
        mapViewController.pinColor = self.selectedColor
        mapViewController.color = self.saveColor
        mapViewController.flyerNameText = self.flyerNameTextField.text
       
        self.present(mapViewController, animated: true, completion: nil)
    }
    

}
