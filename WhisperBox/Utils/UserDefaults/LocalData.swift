//
//  LocalData.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//

import Foundation

struct LocalData {
    @UserDefault(key: "userNickname", defaultValue: "")
    static var userNickname: String
    
    @UserDefault(key: "loginNickname", defaultValue: "")
    static var loginNickname: String
    
    @UserDefault(key: "today", defaultValue: "")
    static var today: String
    
    @UserDefault(key: "countViewDay", defaultValue: String(Calendar.current.dateComponents([.day], from: Date()).day!))
    static var coundViewDay: String
    
    @UserDefault(key: "sendCount", defaultValue: 0)
    static var sendCount: Int
}
