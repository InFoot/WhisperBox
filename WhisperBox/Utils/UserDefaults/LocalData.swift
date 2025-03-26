//
//  LocalData.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//

struct LocalData {
    @UserDefault(key: "userNickname", defaultValue: "")
    static var userNickname: String
    
    @UserDefault(key: "loginNickname", defaultValue: "")
    static var loginNickname: String
}
