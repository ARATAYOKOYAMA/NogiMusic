//
//  ViewController.swift
//  NogiMusic
//
//  Created by 横山　新 on 2018/04/15.
//  Copyright © 2018年 横山　新. All rights reserved.
//

import UIKit
import Firebase

class MemberListViewController: UIViewController {

    var colors: [UIColor] = [.white, .black, .red, .blue, .yellow, .gray, .darkGray]
    var colorName: [String] = ["白", "黒", "赤", "青", "黄", "グレー", "ダークグレー"]
    
    @IBOutlet weak var MemberCollectionView: UICollectionView!
    // インジケータのインスタンス
    let indicator = UIActivityIndicatorView()
    
    // Firebaseの値を格納
    var tempMemberList = [String]()
    var tempMemberID = [String]()
    var memberList = [String]()
    var memberID = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startObject = StartFuntion()
        startObject.musicLibraryPermission()
        startObject.appleMusicConfim()
        
        //FiewbaseのDB呼び出し
        loadMemberList()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension MemberListViewController: UICollectionViewDataSource {
    
    /*
     cellの数
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberList.count
    }
    
    /*
     cellの情報
    */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        //cell.color.backgroundColor = colors[indexPath.item]
        cell.color.text = ""
        cell.name.text = memberList[indexPath.item]
        
        return cell
    }
}

extension MemberListViewController: UICollectionViewDelegate {
    
    /*
     画面遷移時の処理
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 画面遷移
        let senderData : [String] = [(self.memberList[indexPath.row]),(self.memberID[indexPath.row] )]
        // 検索結果へ遷移
        self.performSegue(withIdentifier: "toMemberMusic", sender: senderData)
    }
}

extension MemberListViewController {
    
    /*
     FirebaseのDB参照
     */
    
    func loadMemberList(){
        let memberListObject = Firebase(nameiD: "")
        
        let dispatchGroup = DispatchGroup()
        // 直列キュー / attibutes指定なし
        let dispatchQueue = DispatchQueue(label: "queue")
        
        // UIActivityIndicatorView のスタイルをテンプレートから選択
        self.indicator.activityIndicatorViewStyle = .whiteLarge
        
        // 表示位置
        self.indicator.center = self.view.center
        
        // 色の設定
        self.indicator.color = UIColor.black
        
        // アニメーション停止と同時に隠す設定
        self.indicator.hidesWhenStopped = true
        
        // 画面に追加
        self.view.addSubview(self.indicator)
        
        // 最前面に移動
        self.view.bringSubview(toFront: self.indicator)
        
        // アニメーション開始
        self.indicator.startAnimating()
        
        // 非同期処理を実行
        dispatchGroup.enter()
        dispatchQueue.async(group: dispatchGroup) {
            [weak self] in
            memberListObject.loadMemberList({ (str:ResultMemberData?) -> () in
                self?.tempMemberList = (str?.memberList)!
                self?.tempMemberID = (str?.memberID)!
                dispatchGroup.leave()
            })
        }
        
        // 全ての非同期処理完了後にメインスレッドで処理
        dispatchGroup.notify(queue: .main) {
            self.indicator.stopAnimating()
            self.memberList = self.tempMemberList
            self.memberID = self.tempMemberID
            self.MemberCollectionView.reloadData()
        }
    }
    
    /*
     遷移内容をチェックして、値渡しとかする
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMemberMusic" { //Segueのid
            // Detailをインスタンス化
            let memberDetailViewController = segue.destination as! MemberDetailViewController
            // 値を渡す
            memberDetailViewController.senderData = sender as! [String]

        }else {
            // どちらでもない遷移
        }
    }
    
}
