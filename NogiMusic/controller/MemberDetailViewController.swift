//
//  SecondViewController.swift
//  NogiMusic
//
//  Created by 横山　新 on 2018/04/15.
//  Copyright © 2018年 横山　新. All rights reserved.
//

import UIKit
import MediaPlayer

class MemberDetailViewController: UIViewController {
    
    @IBOutlet weak var trackTableView: UITableView!
    
    // メンバーリストから渡された値を格納 0名前 1id
    var senderData : [String] = []
    
    // Firebaseの値を格納
    var tempTrackNameList = [String]()
    var tempSongIdList = [String]()
    var trackNameList = [String]()
    var songidList = [String]()
    
    // インジケータのインスタンス
    let indicator = UIActivityIndicatorView()
    
    // ミュージックプレイヤー
     let musicPlayer = MPMusicPlayerController.systemMusicPlayer
    
    // 利用可能かどうかをチェックするインスタンス
    let startObject = StartFuntion()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 利用可能かどうかのチェック
        startObject.musicLibraryPermission()
        startObject.appleMusicConfim()
        
        loadSongList()
        
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
        return trackNameList.count
    }
    
    /*
     cellの生成
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを取得する。
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! MusicTableViewCell
        
        cell.trackNo?.text = String(indexPath.row + 1)
        cell.trackName?.text = trackNameList[indexPath.row]
        
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
        
        // applemusicが利用可能かどうか判定する 利用不可の場合return
        guard startObject.canMusicCatalogPlayback else { return }
        
        // 音楽再生
         musicPlay(startTrackID: self.songidList[indexPath.row])
        // 検索結果へ遷移
        //self.performSegue(withIdentifier: "test", sender: nil)
    }
    
    /*
     遷移先をチェックして、値渡をする
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "test" { //Segueのid
//            // Detailをインスタンス化
//            let memberDetailViewController = segue.destination as! MemberDetailViewController
//            // 値を渡す
//            memberDetailViewController.senderData = sender as! [String]
            
        }else {
            // どちらでもない遷移
        }
        
    }
}

/*
 その他関数
 */
extension MemberDetailViewController{
    /*
     FirebaseのDB参照
     */
    
    func loadSongList(){
        let memberListObject = Firebase(nameiD: senderData[1])
        
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
            memberListObject.loadSongList({ (str:ResultTrackData?) -> () in
                self?.tempTrackNameList = (str?.songNames)!
                self?.tempSongIdList = (str?.songIds)!
                dispatchGroup.leave()
            })
        }
        
        // 全ての非同期処理完了後にメインスレッドで処理
        dispatchGroup.notify(queue: .main) {
            self.indicator.stopAnimating()
            self.trackNameList = self.tempTrackNameList
            self.songidList = self.tempSongIdList
            self.trackTableView.reloadData()
        }
    }
    
    /*
     音楽再生
     */
    func musicPlay(startTrackID : String){
        let trackIDs = self.songidList
        let descriptor = MPMusicPlayerStoreQueueDescriptor(storeIDs: trackIDs)
        descriptor.startItemID = startTrackID
        musicPlayer.setQueue(with: descriptor)
        musicPlayer.play()
    }
}
