//
//  WriteMessageViewModel.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//
import Foundation
import Combine

final class WriteMessageViewModel: ObservableObject {
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
    @Published var selectedUser: GetUserResModel? = nil
    @Published var selectedTemplateIndex: Int = 0

    // MARK: - Output
    @Published var anonymousNickname: String? = nil
    @Published var didSendMessage: Bool = false
    @Published var allUsers: [GetUserResModel] = []

    init(user: GetUserResModel? = nil) {
        self.selectedUser = user
        fetchAllUsers()
    }

    // MARK: - Validation
    var isFormValid: Bool {
        if isAnonymous {
            return !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        } else {
            return selectedUser != nil &&
                message.trimmingCharacters(in: .whitespacesAndNewlines).count >= 10
        }
    }

    // MARK: - Firebase 호출
    func sendMessage(from allUsers: [GetUserResModel]) async {
        guard isFormValid else { return }

        do {
            if isAnonymous {
                let filtered = allUsers.filter { $0.nickName != LocalData.loginNickname }
                let shuffled = filtered.shuffled()
                let selected = Array(shuffled.prefix(min(5, shuffled.count)))
                let nicknames = selected.map { $0.nickName }

                let result = try await FirebaseService.shared.sendLetter(sender: LocalData.loginNickname, recievers: nicknames, content: message, isAnonymous: true)
                switch result {
                case .success:
                    didSendMessage = true
                case .failure(let error):
                    print("전송 실패: \(error.description)")
                }

            } else if let user = selectedUser {
                let result = try await FirebaseService.shared.sendLetter(sender: LocalData.loginNickname, recievers: [user.nickName], content: message, isAnonymous: false)
                switch result {
                case .success:
                    didSendMessage = true
                case .failure(let error):
                    print("전송 실패: \(error.description)")
                }
            }
        } catch {
            print("💥 전송 중 오류: \(error.localizedDescription)")
        }
    }

    func fetchAllUsers() {
        Task {
            let result = await FirebaseService.shared.getAllUsers()
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.allUsers = users
                case .failure(let error):
                    print("유저 불러오기 실패: \(error.description)")
                }
            }
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

