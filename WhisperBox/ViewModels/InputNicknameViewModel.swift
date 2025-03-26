//
//  InputNicknameViewModel.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/26/25.
//

import Combine
import SwiftUI

class InputNicknameViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var filteredUsers: [User] = []
    @Published var isReceiverSelected = false
    
    //가상데이터
    //To-do : DB에서 사용자 목록 불러오기 구현 필요
    @State var allUsers: [User] = [
        User(nickname: "Echo", name: "에코", code: 101),
        User(nickname: "Ted", name: "테드", code: 102),
        User(nickname: "Ted", name: "테드", code: 102),
        User(nickname: "Tea", name: "테드", code: 110),
        User(nickname: "Tew", name: "테드", code: 109),
        User(nickname: "Tee", name: "테드", code: 108),
        User(nickname: "Ter", name: "테드", code: 107),
        User(nickname: "Ted", name: "테드", code: 111),
        User(nickname: "Tea", name: "테드", code: 112),
        User(nickname: "Tew", name: "테드", code: 113),
        User(nickname: "Tee", name: "테드", code: 114),
        User(nickname: "Ter", name: "테드", code: 115),
        User(nickname: "Kirby", name: "커비", code: 116),
        User(nickname: "Go", name: "고", code: 104),
        User(nickname: "Wish", name: "위시", code: 105),
        User(nickname: "Elphie", name: "엘피", code: 106)
    ]
}
