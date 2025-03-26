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

    // 전체 유저 목록을 가져오는 테스트
    @Test func getAllUsersTest() async {
        let result = await FirebaseService.shared.getAllUsers()
        switch result {
        case .success(let users):
            print("\n---- 전체 유저 목록 ----")
            for user in users {
                print("닉네임: \(user.nickName), 비밀번호: \(user.password)")
            }
        case .failure(let error):
            print("유저 목록 가져오기 실패: \(error.description)")
        }
    }
}
