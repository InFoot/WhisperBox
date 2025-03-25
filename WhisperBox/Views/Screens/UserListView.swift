//
//  UserListView.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel(users: users) 
    @Environment(\.dismiss) private var dismiss
    let onUserSelected: (User) -> Void
    var body: some View {
        NavigationView {
            VStack {
                TextField("편지를 보내고 싶은 상대를 검색하세요", text: $viewModel.searchText)
                    .padding()
                    .textFieldStyle(.roundedBorder)

                List(viewModel.filteredUsers) { user in
                    Button {
                        onUserSelected(user) // 선택한 유저를 WriteMessageView로 전달
                        dismiss()            // 👈 sheet 닫기!
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.nickname)
                                .font(.headline)
                            if let name = user.name {
                                Text(name)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("사람 선택하기")
        }
    }
}
