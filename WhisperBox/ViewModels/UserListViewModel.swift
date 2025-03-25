//
//  UserListViewModel.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import Foundation
import Combine

final class UserListViewModel: ObservableObject {
    // 입력 상태
    @Published var searchText: String = ""

    // 전체 유저 목록 (고정)
    private let allUsers: [User]

    // 필터링된 결과 → View에서 바인딩됨
    @Published var filteredUsers: [User] = []

    private var cancellables = Set<AnyCancellable>()

    init(users: [User]) {
        self.allUsers = users
        setupBindings()
    }

    private func setupBindings() {
        // 검색어가 바뀔 때마다 필터링 결과를 업데이트
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                if query.isEmpty {
                    self.filteredUsers = self.allUsers
                } else {
                    self.filteredUsers = self.allUsers.filter {
                        $0.nickname.lowercased().contains(query.lowercased())
                    }
                }
            }
            .store(in: &cancellables)
    }
}
