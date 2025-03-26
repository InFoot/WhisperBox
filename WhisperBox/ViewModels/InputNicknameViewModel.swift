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
    @Published var filteredUsers: [GetUserResModel] = [] //객체 확인하기
    @Published var isReceiverSelected = false
    @Published var shouldNavigate = false
    @Published var allUsersList: [GetUserResModel] = []

    init() {
        fetchUsers()
    }

    func fetchUsers() {
        Task {
            let result = await FirebaseService.shared.getAllUsers()
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.allUsersList = users
                case .failure(let error):
                    print("Error fetching users: \(error.description)")
                }
            }
        }
    }
}
