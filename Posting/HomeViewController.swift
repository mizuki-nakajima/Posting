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
import SVProgressHUD

class HomeViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var flyerNameTextField: UITextField!
    @IBOutlet weak var colorPickerView: UIPickerView!
    var selectedColor : UIColor?
    
    
    let dataList = ["Red","Green","Blue","Cyan","Yellow","Magenta","Orange","Purple"]
    let colorList =  [UIColor.red, UIColor.green, UIColor.blue, UIColor.cyan, UIColor.yellow, UIColor.magenta, UIColor.orange,UIColor.purple]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PURINT_DEBUG : ログインしました")
        

        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        
        print("DEBUG_PRINT : 未選択の状態  \(selectedColor!)")
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
        
        //selectedColorをMapViewControllerのpinColorに渡す
        //datalistと同じ番地のcolorlistのカラーをselectedColorに代入
        self.selectedColor  = self.colorList[row]
        print("DEBUG_PRINT : pickerViewで選択した色 = \(selectedColor!)")
        
        //ひとつでも空白があったらエラーを返す
        //if selectedColor.isEmpty || flyerNameTextField.isEmpty {
         //   print("DEBUG_PRINT: 何かが空文字です。")
            
           // return
        //}
        
    }
    

    @IBAction func handlePostingStartButton(_ sender: Any) {
        //キャストする
        let mapViewController = self.storyboard?.instantiateViewController(withIdentifier: "Map") as! MapViewController
        //モーダルで渡る前の準備
        mapViewController.pinColor = self.selectedColor
        self.present(mapViewController, animated: true, completion: nil)
    }
    

}
