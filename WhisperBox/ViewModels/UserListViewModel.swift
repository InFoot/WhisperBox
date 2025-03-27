//
//  UserListViewModel.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//
import Foundation
import Combine

final class UserListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredUsers: [GetUserResModel] = []
    private(set) var allUsers: [GetUserResModel] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchUsers()
        setupBindings()
    }

    private func fetchUsers() {
        Task {
            let result = await FirebaseService.shared.getAllUsers()
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.allUsers = users
                    self.filteredUsers = users
                case .failure(let error):
                    print("Error fetching users: \(error.description)")
                }
            }
        }
    }

    private func setupBindings() {
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                if query.isEmpty {
                    self.filteredUsers = self.allUsers
                } else {
                    self.filteredUsers = self.allUsers.filter {
                        $0.nickName.lowercased().contains(query.lowercased())
                    }
                }
            }
            .store(in: &cancellables)
    }
}
