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
    
    let musicPlayer = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var trackNameField: UILabel!
    let artworkSize:CGSize = CGSize(width:270, height:270)

    override func viewDidLoad() {
        super.viewDidLoad()

        // 再生中のItemが変わった時に通知を受け取る
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.nowPlayingItemChanged(notification:)), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: musicPlayer)
        
        // 通知の有効化
        musicPlayer.beginGeneratingPlaybackNotifications()
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

    
}
