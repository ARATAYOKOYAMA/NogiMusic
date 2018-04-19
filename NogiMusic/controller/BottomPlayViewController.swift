//
//  BottomPlayViewController.swift
//  NogiMusic
//
//  Created by 横山　新 on 2018/04/20.
//  Copyright © 2018年 横山　新. All rights reserved.
//

import UIKit
import MediaPlayer

class BottomPlayViewController: UIViewController {

    let musicPlayer = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artwork: UIImageView!
    let artworkSize:CGSize = CGSize(width:270, height:270)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 再生中のItemが変わった時に通知を受け取る
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.nowPlayingItemChanged(notification:)), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: musicPlayer)
        
        // 通知の有効化
        musicPlayer.beginGeneratingPlaybackNotifications()
        
        loadTrackData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 再生中の曲が変更になったときに呼ばれる
    @objc func nowPlayingItemChanged(notification: NSNotification) {
        loadTrackData()
    }
    
    func loadTrackData() {
        if musicPlayer.nowPlayingItem?.title == nil {
            trackName.text = "再生停止中"
            trackName.textColor = UIColor.black
        }else {
            trackName.text = musicPlayer.nowPlayingItem?.title
            trackName.textColor = UIColor(hex: "932993")
            artwork.image = musicPlayer.nowPlayingItem?.artwork?.image(at: artworkSize)
        }
        //trackName.text = musicPlayer.nowPlayingItem?.title
        //artwork.image = musicPlayer.nowPlayingItem?.artwork?.image(at: artworkSize)
    }

    @IBAction func testChange(_ sender: Any) {
        let parentVC = self.parent as! MemberDetailViewController
        parentVC.testChange()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
