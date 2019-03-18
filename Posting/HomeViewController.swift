//
//  HomeViewController.swift
//  Posting
//
//  Created by Nakajima Mizuki on 2019/03/18.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PURINT_DEBUG : ログインしました")

    }
    

    @IBAction func handlePostingStartButton(_ sender: Any) {
        let mapViewController = self.storyboard?.instantiateViewController(withIdentifier: "Map")
        self.present(mapViewController!, animated: true, completion: nil)
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
