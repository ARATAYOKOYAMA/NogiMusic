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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    // cellの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    // cellの情報
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.color.backgroundColor = colors[indexPath.item]
        cell.color.text = ""
        cell.name.text = colorName[indexPath.item]
        
        return cell
    }
}

extension MemberListViewController: UICollectionViewDelegate {
    
    // 画面遷移時の処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = self.storyboard
        let secondView = storyboard?.instantiateViewController(withIdentifier: "secondView") as! MemberDetailViewController
        secondView.color = colors[indexPath.item]
        secondView.colorName = colorName[indexPath.item]
        
        present(secondView, animated: true, completion: nil)
    }
}

extension MemberListViewController {
    
    /*
     FirebaseのDB参照
     */
    
    func loadMemberList(){
        
        let ref = Database.database().reference()
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
                
                print(names)
//                self.memberList = names
//                self.memberID = ids
//                // tableviewの再読込
//                self.memberListTableView.reloadData()
            }
        })
    }
    
}
