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
    
    @IBOutlet weak var MemberCollectionView: UICollectionView!
    // インジケータのインスタンス
    let indicator = UIActivityIndicatorView()
    
    // Firebaseの値を格納
    var tempMemberList_1 = [String]()
    var tempMemberID_1 = [String]()
    var memberList_1 = [String]()
    var memberID_1 = [String]()
    
    var tempMemberList_2 = [String]()
    var tempMemberID_2 = [String]()
    var memberList_2 = [String]()
    var memberID_2 = [String]()
    
    var tempMemberList_3 = [String]()
    var tempMemberID_3 = [String]()
    var memberList_3 = [String]()
    var memberID_3 = [String]()
    
    var tempMemberList_0 = [String]()
    var tempMemberID_0 = [String]()
    var memberList_0 = [String]()
    var memberID_0 = [String]()
    
    // 利用可能かどうかをチェックするインスタンス
    let startObject = StartFuntion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションアイテムの色変更
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "932993")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // ナビゲーションアイテムの色変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        // 利用可能かどうかのチェック
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
//        return memberList_1.count + memberList_2.count + memberList_3.count + memberList_0.count
        return memberList_2.count + memberList_3.count + memberList_0.count
    }
    
    /*
     cellの情報
    */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.color.text = ""
        cell.name.text = memberList_0[indexPath.item]
        
        return cell
    }
}

extension MemberListViewController: UICollectionViewDelegate {
    
    /*
     画面遷移時の処理
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 画面遷移
        let senderData : [String] = [(self.memberList_0[indexPath.row]),(self.memberID_0[indexPath.row] )]
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
                self?.tempMemberList_1 = (str?.memberList_1)!
                self?.tempMemberID_1 = (str?.memberID_1)!
                
                self?.tempMemberList_2 = (str?.memberList_2)!
                self?.tempMemberID_2 = (str?.memberID_2)!
                
                self?.tempMemberList_3 = (str?.memberList_3)!
                self?.tempMemberID_3 = (str?.memberID_3)!
                
                self?.tempMemberList_0 = (str?.memberList_0)!
                self?.tempMemberID_0 = (str?.memberID_0)!
                dispatchGroup.leave()
            })
        }
        
        // 全ての非同期処理完了後にメインスレッドで処理
        dispatchGroup.notify(queue: .main) {
            self.indicator.stopAnimating()
            self.memberList_1 = self.tempMemberList_1
            self.memberID_1 = self.tempMemberID_1
            
            self.memberList_2 = self.tempMemberList_2
            self.memberID_2 = self.tempMemberID_2
            
            self.memberList_3 = self.tempMemberList_3
            self.memberID_3 = self.tempMemberID_3
            
            self.memberList_0 = self.tempMemberList_0
            self.memberID_0 = self.tempMemberID_0
            self.MemberCollectionView.reloadData()
        }
    }
    
    /*
     遷移先をチェックして、値渡をする
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
