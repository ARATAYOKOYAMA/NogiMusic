//
//  SecondViewController.swift
//  NogiMusic
//
//  Created by 横山　新 on 2018/04/15.
//  Copyright © 2018年 横山　新. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {
    
    @IBOutlet weak var trackTableView: UITableView!
    
    // メンバーリストから渡された値を格納 0名前 1id
    var senderData : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(senderData)
        
        //自作セルをテーブルビューに登録する。
        let testXib = UINib(nibName:"MusicTableViewCell", bundle:nil)
        trackTableView.register(testXib, forCellReuseIdentifier:"TrackCell")
        
    }

}

/*
 データ・ソース
 */
extension MemberDetailViewController: UITableViewDataSource {
    
    /*
     セクション数
     */
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sectionName.count
//    }
    
    /*
     データ数
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return senderData.count
    }
    
    /*
     cellの生成
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを取得する。
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! MusicTableViewCell
        
        cell.trackNo?.text = String(indexPath.row + 1)
        cell.trackName?.text = senderData[indexPath.row]
        
        return cell
    }
    
    /*
     headerの設定
     */
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionName[section]
//    }
}

/*
 セルタップ時の動作定義など
 */
extension MemberDetailViewController: UITableViewDelegate {
    
    /*
     セクションヘッダの高さ
     */
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
    /*
     セルタップ時の挙動
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ハイライト消す
        tableView.deselectRow(at: indexPath, animated: false)
        print(indexPath)
    }
}

