//
//  StartFunction.swift
//  NogiMusic
//
//  Created by 横山　新 on 2018/04/18.
//  Copyright © 2018年 横山　新. All rights reserved.
//

import StoreKit

class StartFuntion {
    
    let cloudServiceController = SKCloudServiceController()
    
    func musicLibraryPermission(){
        SKCloudServiceController.requestAuthorization { status in
            guard status == .authorized else { return }
            
            // 後続の処理 ...
            //print("hoge")
        }
    }
    
    func appleMusicConfim(){
        cloudServiceController.requestCapabilities { capabilities, error in
            guard capabilities.contains(.musicCatalogPlayback) else { return }
            
            // 後続の処理 ...
            //print("hoge2")
        }
    }
}
