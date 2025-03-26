//
//  InputNicknameView.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/26/25.
//

import SwiftUI
import Combine

struct InputNicknameView: View {
    @ObservedObject var viewModel: InputNicknameViewModel = InputNicknameViewModel()
    @FocusState private var isNicknameFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                //1. 닉네임 입력 안내 문구
                Text("아카데미 닉네임을 알려주세요")
                    .font(.title)
                    .bold()
                Text("쪽지는 익명이 보장돼요 :)")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 40)
                
                //2. 닉네임 검색창
                TextEditor(text: self.$viewModel.nickname)
                    .focused($isNicknameFocused)
                    .frame(height: 50)
                    .padding(.horizontal, 5)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
                    .multilineTextAlignment(.center)
                    .onChange(of: self.viewModel.nickname) { _ in
                        searchUsers()
                    }
                
                if !self.viewModel.filteredUsers.isEmpty && self.isNicknameFocused {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(self.viewModel.allUsers, id: \.self) { user in
                                if user.nickname.contains(self.viewModel.nickname) {
                                    searchedUser(userNickName: user.nickname)
                                        .onTapGesture {
                                            withAnimation {
                                                self.viewModel.nickname = user.nickname
                                                self.viewModel.isReceiverSelected = true
                                            }
                                            isNicknameFocused = false
                                        }
                                }
                            }
                        }
                        .background(.white)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                        .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 0)
                    }
                    .frame(width: UIScreen.main.bounds.width - 80, height: min(180, CGFloat(30 * self.viewModel.allUsers.filter{ $0.nickname.contains(self.viewModel.nickname)}.count)))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 0)
                    .scrollIndicators(.never)
                }
                Spacer()
                
                //3. 다음으로 버튼
                Button{
                    //To-do : 동작 구현하기
                } label: {
                    Text("다음으로")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(self.viewModel.isReceiverSelected ? .white : .gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(self.viewModel.isReceiverSelected ? .blue : Color.gray.opacity(0.1))
                        .clipShape(Capsule())
                    
                }
                .padding(.bottom, isNicknameFocused ? 10 : 20)
                .disabled(!self.viewModel.isReceiverSelected)
            }
            .padding()
            .onTapGesture {
                withAnimation {
                    isNicknameFocused = false
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                withAnimation {
                    isNicknameFocused = true
                }
            }
        }
    }
    
    private func searchedUser(userNickName: String) -> some View {
        HStack(spacing: 0) {
            Text(userNickName).font(.system(size: 24, weight: .bold)).foregroundStyle(.black)
                .padding(.trailing, 5)
            Spacer()
        }
        .padding(.horizontal, 25)
        .frame(height: 30)
        .background(Rectangle().fill(.white))
    }
    
    private func searchUsers() {
        if self.viewModel.nickname.isEmpty
        {
            withAnimation {
                self.viewModel.filteredUsers = []
            }
        } else {
            withAnimation {
                self.viewModel.filteredUsers = self.viewModel.allUsers.filter { $0.nickname.lowercased().contains(self.viewModel.nickname.lowercased()) }
            }
        }
    }
}

#Preview {
    InputNicknameView()
}
