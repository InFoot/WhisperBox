//
//  WriteMessageViewModel.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import Foundation
import Combine
import Foundation
import Combine

class WriteMessageViewModel: ObservableObject {
    // MARK: - Input
    @Published var message: String = ""
    @Published var isAnonymous: Bool = false {
        didSet {
            if isAnonymous {
                anonymousNickname = Self.generateAnonymousNickname()
                selectedUser = nil
            } else {
                anonymousNickname = nil
            }
        }
    }

    @Published var selectedUser: User?
    @Published var selectedTemplateIndex: Int = 0

    // MARK: - Output
    @Published var anonymousNickname: String? = nil
    @Published var didSendMessage: Bool = false
    

    // MARK: - Validation
    var isFormValid: Bool {
        if isAnonymous {
            return !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        } else {
            return selectedUser != nil &&
                message.trimmingCharacters(in: .whitespacesAndNewlines).count >= 10
        }
    }
    
    // MARK: - Initialize
    init(user: User?) {
        self.selectedUser = user
    }

    // MARK: - Message Sending
    func sendMessage(from allUsers: [User]) async {
        guard isFormValid else { return }

        do {
            if isAnonymous {
//                try await MessageService.saveToRandomUsers(message: message, from: allUsers)
                // try await FirebaseService.shared.sendLetter(sender: LocalData.userNickname, recievers: [], content: "", isAnonymous: <#T##Bool#>)
            } else if let user = selectedUser {
//                try await MessageService.save(message: message, to: user)
                let result = try await FirebaseService.shared.sendLetter(sender: LocalData.userNickname, recievers: [selectedUser?.nickname], content: self.message, isAnonymous: false)
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
            didSendMessage = true
        } catch {
            print("💥 전송 중 오류: \(error)")
        }
    }

    // MARK: - Helpers
    func clearSelectedUser() {
        selectedUser = nil
    }

    static func generateAnonymousNickname() -> String {
      
        return anonymousNicknames.randomElement() ?? "익명의 친구"
    }
}
