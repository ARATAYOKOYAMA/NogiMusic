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
    var memberList_1 = [String]()
    var memberID_1 = [String]()
    var memberList_2 = [String]()
    var memberID_2 = [String]()
    var memberList_3 = [String]()
    var memberID_3 = [String]()
    var memberList_0 = [String]()
    var memberID_0 = [String]()
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
        
        var names_1 = [String]()
        var ids_1 = [String]()
        
        var names_2 = [String]()
        var ids_2 = [String]()
        
        var names_3 = [String]()
        var ids_3 = [String]()
        
        var names_0 = [String]()
        var ids_0 = [String]()
        
        ref.child("MemberList").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if ( snapshot.value is NSNull ) {
                
                // DATA WAS NOT FOUND
                print("– – – Data was not found – – –")
                
            } else {
                for folder in (snapshot.children) {
                    let member_snap = folder as! DataSnapshot
                    let dict = member_snap.value as! [String: Any?]
                    
                    switch dict["no"] as! Int {
                    case 1:
                        names_1.append(dict["name"] as! String)
                        ids_1.append(dict["id"] as! String)
                    case 2:
                        names_2.append(dict["name"] as! String)
                        ids_2.append(dict["id"] as! String)
                    case 3:
                        names_3.append(dict["name"] as! String)
                        ids_3.append(dict["id"] as! String)
                    case 0:
                        names_0.append(dict["name"] as! String)
                        ids_0.append(dict["id"] as! String)
                    default:
                        print(dict["name"] as! String, "– – – No much – – –")
                    }
                }
                
                let resultData = ResultMemberData(memberList_1 : names_1, memberID_1 : ids_1, memberList_2 : names_2, memberID_2 : ids_2,
                memberList_3 : names_3, memberID_3 : ids_3, memberList_0 : names_0, memberID_0 : ids_0)
                after(resultData)
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
