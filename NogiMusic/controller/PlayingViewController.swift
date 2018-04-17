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
    
    var songID : [String] = ["1091127927","1047628482"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    /*
     音楽再生
     */
    func musicPlay(startTrackID : String){
        let trackIDs = self.songID
        let descriptor = MPMusicPlayerStoreQueueDescriptor(storeIDs: trackIDs)
        descriptor.startItemID = startTrackID
        musicPlayer.setQueue(with: descriptor)
        musicPlayer.play()
    }

    @IBAction func test(_ sender: Any) {
        
        musicPlay(startTrackID: "1047628482")
        
    }
    
}
