//
//  FirebaseTest.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//

import Testing
@testable import WhisperBox
import Foundation

struct FirebaseTests {
//    @Test func saveExampleData() async {
//        await FirebaseController.shared.saveUserData()
//    }
    
    @Test func saveTestUserData() async {
        let result = await FirebaseService.shared.saveUserAccount(nickName: "ted", password: "1234")
        switch result {
        case .success(let result):
            print("save user : \(result)")
        case .failure(let result):
            print(result.description)
        }
    }
    
    // 유저 정보를 가져오는 로직
    @Test func getTestUserDataTest() async {
        let result = await FirebaseService.shared.getUserAccountInfo(nickName: "ted")
        switch result {
        case .success(let userResModel):
            print(userResModel.nickName)
            print(userResModel.password)
        case .failure(let failure):
            print(failure.description)
        }
    }
    
    @Test func loginTest() async {
        let result = await FirebaseService.shared.login(nickName: "ted", password: "1236")
        switch result {
        case .success(let success):
            print("login success")
        case .failure(let failure):
            print(failure)
        }
    }
    
    @Test func sendLetterTest() async {
        do {
            let result = try await FirebaseService.shared.sendLetter(sender: "elphie", recievers: ["go", "kirby", "wish", "echo", "ted"], content: "letter send test message2", isAnonymous: true)
            switch result {
            case .success(let success):
                print("success to send letter")
            case .failure(let failure):
                print("fail to send letter")
            }
        } catch {
            
        }
    }
    
    @Test func getLetterTest() async {
        let result = await FirebaseService.shared.getUserLetters(userNickname: "echo", date: Date())
        switch result {
        case .success(let letterList):
            print("---- Letter List ----")
            print(letterList)
        case .failure(let failure):
            print(failure)
        }
    }
    
    
}
