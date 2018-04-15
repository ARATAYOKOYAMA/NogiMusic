//
//  SecondViewController.swift
//  NogiMusic
//
//  Created by 横山　新 on 2018/04/15.
//  Copyright © 2018年 横山　新. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    var color: UIColor?
    var colorName: String?
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景の色を設定
        self.view.backgroundColor = color
        // Labelに名前を入れる
        name.text = colorName
        
        if color != UIColor.white && color != UIColor.yellow {
            name.textColor = .white
        }
    }
    
    // 戻るボタンを押したときの処理
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
