//
//  Firebase.swift
//  NogiMusic
//
//  Created by 横山　新 on 2018/04/16.
//  Copyright © 2018年 横山　新. All rights reserved.
//

import Foundation
import Firebase

struct ResultMemberData {
    // サーバーからの値を格納する変数
    var memberList = [String]()
    var memberID = [String]()
}

struct ResultTrackData {
    var songNames = [String]()
    var songIds = [String]()
}

class Firebase {
    
    var memberiD: String
    
    let ref = Database.database().reference()
    
    init(nameiD:String) {
        self.memberiD = nameiD
    }
    
    /*
     FirebaseのDB参照
     */
    
    func loadMemberList(_ after:@escaping (ResultMemberData) -> ()){
        
        var names = [String]()
        var ids = [String]()
        
        ref.child("MemberList").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if ( snapshot.value is NSNull ) {
                
                // DATA WAS NOT FOUND
                print("– – – Data was not found – – –")
                
            } else {
                for folder in (snapshot.children) {
                    let member_snap = folder as! DataSnapshot
                    let dict = member_snap.value as! [String: Any?]
                    names.append(dict["name"] as! String)
                    ids.append(dict["id"] as! String)
                }
                
                let resultData = ResultMemberData(memberList : names, memberID : ids)
                after(resultData)
                print(names)
            }
        })
    }
    
    func loadSongList(_ after:@escaping (ResultTrackData) -> ()){
        
        var tempSongNames : [String] = []
        var tempSongIds : [String] = []
        
        ref.child(memberiD).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if ( snapshot.value is NSNull ) {
                
                // DATA WAS NOT FOUND
                print("– – – Fire Base Data was not found – – –")
                
            } else {
                for folder in (snapshot.children) {
                    let member_snap = folder as! DataSnapshot
                    let dict = member_snap.value as! [String: Any?]
                    tempSongNames.append(dict["Title"] as! String)
                    tempSongIds.append(dict["id"] as! String)
                }
                
                let resultData = ResultTrackData(songNames : tempSongNames, songIds : tempSongIds)
                after(resultData)
            }
            
        })
        
    }
}
