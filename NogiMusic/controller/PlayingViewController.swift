//
//  PlayingTableViewController.swift
//  NogiMusic
//
//  Created by 横山　新 on 2018/04/18.
//  Copyright © 2018年 横山　新. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayingViewController: UIViewController {
    
    // ミュージックプレイヤー
    let musicPlayer = MPMusicPlayerController.systemMusicPlayer
    
    // アートワークやトラック名
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var trackNameField: UILabel!
    let artworkSize:CGSize = CGSize(width:270, height:270)
    
    // プレイヤーのUI部品
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backBottun: UIButton!
    
    //　再生と一時停止の画像
    let playButtonImage:UIImage = UIImage(named: "play")!
    let pauseButtonImage:UIImage = UIImage(named: "pause")!
    
    // 再生と一時停止を判断するフラグ
    var playFlag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションアイテムの色変更
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "932993")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // ナビゲーションアイテムの色変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        // 再生中のItemが変わった時に通知を受け取る
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.nowPlayingItemChanged(notification:)), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: musicPlayer)
        
        // 通知の有効化
        musicPlayer.beginGeneratingPlaybackNotifications()
        
        loadTrackData()
        
        // UIButoonのアスペクトセット
        forAspectFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        loadTrackData()
    }
    
    /// 再生中の曲が変更になったときに呼ばれる
    @objc func nowPlayingItemChanged(notification: NSNotification) {
        loadTrackData()
    }
    
    func loadTrackData() {
        trackNameField.text = musicPlayer.nowPlayingItem?.title
        artwork.image = musicPlayer.nowPlayingItem?.artwork?.image(at: artworkSize)
    }
    
    deinit {
        // 再生中アイテム変更に対する監視をはずす
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: musicPlayer)
        // ミュージックプレーヤー通知の無効化
        musicPlayer.endGeneratingPlaybackNotifications()
    }
    
    /*
     トラックリストに戻る
    */
    @IBAction func backTrackList(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 再生・一時停止ボタン　未完成
    @IBAction func playMusic(_ sender: Any) {
        switch playFlag {
        case 0:
            musicPlayer.pause()
            playButton.setImage(playButtonImage, for: UIControlState())
            playFlag = 1
        default:
            musicPlayer.play()
            playButton.setImage(pauseButtonImage, for: UIControlState())
            playFlag = 0
        }
    }

    /*
     次の曲へ
    */
    @IBAction func nextMusic(_ sender: Any) {
        musicPlayer.skipToNextItem()
    }
    
    /*
     前の曲へ
    */
    @IBAction func previousMusic(_ sender: Any) {
        musicPlayer.skipToPreviousItem()
    }
    
}


extension PlayingViewController {
    
    /*
     UIButtonのアスペクト比を修正
    */
    func forAspectFit() {
        nextButton.imageView?.contentMode = .scaleAspectFit
        
        playButton.imageView?.contentMode = .scaleAspectFit
        
        backBottun.imageView?.contentMode = .scaleAspectFit
    }
}
