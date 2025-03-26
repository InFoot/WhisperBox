//
//  inputPasswordViewModel.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/26/25.
//

import Combine
import SwiftUI

class InputPasswordViewModel: ObservableObject {
    @Published var password: String = ""
    @Published var isPasswordFilled = false
    @Published var shouldNavigate = false
    @Published var isLoginSuccessful = false
    
    func login() {
        Task {
            let result = await FirebaseService.shared.login(nickName: LocalData.loginNickname, password: self.password)
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isLoginSuccessful = true
                    self.shouldNavigate = true
                    LocalData.userNickname = LocalData.loginNickname
                case .failure(let error):
                    self.isLoginSuccessful = false
                    print("Error fetching users: \(error.description)") // 에러 메시지 출력
                }
            }
        }
    }
}
