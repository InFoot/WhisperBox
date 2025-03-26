//
//  InputPasswordView.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/26/25.
//

import SwiftUI

struct InputPasswordView: View {
    @FocusState private var isPasswordFocused: Bool
    @ObservedObject var viewModel: InputPasswordViewModel = InputPasswordViewModel()
    
    @State private var shouldNavigate : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                //1. 비밀번호 입력 안내 문구
                Text("부여받은 비밀번호를")
                    .font(.title)
                    .bold()
                Text("입력해주세요")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 40)
                
                // 2. 비밀번호 입력창
                SecureField("", text: self.$viewModel.password)
                    .focused($isPasswordFocused)
                    .keyboardType(.numberPad) // 숫자 키보드
                    .frame(height: 50)
                    .padding(.horizontal, 5)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
                    .multilineTextAlignment(.center)
                    .onChange(of: self.viewModel.password) { newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered.count > 4 {
                            self.viewModel.password = String(filtered.prefix(4)) // 4자리로 제한
                        } else {
                            self.viewModel.password = filtered
                        }
                    }
                Spacer()
                
                // 3. 다음으로 버튼
                NavigationLink(destination: WelcomeUserView(), isActive: $shouldNavigate){
                    Button{
                        if self.viewModel.isReceiverSelected {
                            shouldNavigate = true
                        }
                    } label: {
                        Text("다음으로")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(self.viewModel.isReceiverSelected ? .white : .gray)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(self.viewModel.isReceiverSelected ? .blue : Color.gray.opacity(0.1))
                            .clipShape(Capsule())
                        
                    }
                    .padding(.bottom, isPasswordFocused ? 10 : 20)
                    .disabled(!self.viewModel.isReceiverSelected)
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//                //2. 닉네임 검색창
//                TextEditor(text: self.$viewModel.nickname)
//                    .focused($isNicknameFocused)
//                    .frame(height: 50)
//                    .padding(.horizontal, 5)
//                    .overlay(
//                        Rectangle()
//                            .frame(height: 1)
//                            .foregroundColor(.gray),
//                        alignment: .bottom
//                    )
//                    .multilineTextAlignment(.center)
//                    .onChange(of: self.viewModel.nickname) { _ in
//                        searchUsers()
//                    }
//
//                if !self.viewModel.filteredUsers.isEmpty && self.isNicknameFocused {
//                    ScrollView {
//                        VStack(alignment: .leading, spacing: 0) {
//                            ForEach(self.viewModel.allUsers, id: \.self) { user in
//                                if user.nickname.contains(self.viewModel.nickname) {
//                                    searchedUser(userNickName: user.nickname)
//                                        .onTapGesture {
//                                            withAnimation {
//                                                self.viewModel.nickname = user.nickname
//                                                self.viewModel.isReceiverSelected = true
//                                            }
//                                            isNicknameFocused = false
//                                        }
//                                }
//                            }
//                        }
//                        .background(.white)
//                        .clipShape(
//                            RoundedRectangle(cornerRadius: 10)
//                        )
//                        .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 0)
//                    }
//                    .frame(width: UIScreen.main.bounds.width - 80, height: min(180, CGFloat(30 * self.viewModel.allUsers.filter{ $0.nickname.contains(self.viewModel.nickname)}.count)))
//                    .clipShape(
//                        RoundedRectangle(cornerRadius: 10)
//                    )
//                    .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 0)
//                    .scrollIndicators(.never)
//                }
//                Spacer()
//
//                //3. 다음으로 버튼
//                NavigationLink(destination: WelcomeUserView(), isActive: $shouldNavigate){
//                    Button{
//                        if self.viewModel.isReceiverSelected {
//                            LocalData.loginNickname = self.viewModel.nickname
//                            shouldNavigate = true
//                        }
//                    } label: {
//                        Text("다음으로")
//                            .font(.system(size: 20, weight: .semibold))
//                            .foregroundColor(self.viewModel.isReceiverSelected ? .white : .gray)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(self.viewModel.isReceiverSelected ? .blue : Color.gray.opacity(0.1))
//                            .clipShape(Capsule())
//
//                    }
//                    .padding(.bottom, isNicknameFocused ? 10 : 20)
//                    .disabled(!self.viewModel.isReceiverSelected)
//                }
//            }
//            .padding()
//            .onTapGesture {
//                withAnimation {
//                    isNicknameFocused = false
//                }
//            }
//        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//                withAnimation {
//                    isNicknameFocused = true
//                }
//            }
//        }
//    }
//
//    private func searchedUser(userNickName: String) -> some View {
//        HStack(spacing: 0) {
//            Text(userNickName).font(.system(size: 24, weight: .bold)).foregroundStyle(.black)
//                .padding(.trailing, 5)
//            Spacer()
//        }
//        .padding(.horizontal, 25)
//        .frame(height: 30)
//        .background(Rectangle().fill(.white))
//    }
//
//    private func searchUsers() {
//        if self.viewModel.nickname.isEmpty
//        {
//            withAnimation {
//                self.viewModel.filteredUsers = []
//            }
//        } else {
//            withAnimation {
//                self.viewModel.filteredUsers = self.viewModel.allUsers.filter { $0.nickname.lowercased().contains(self.viewModel.nickname.lowercased()) }
//            }
//        }
//    }
//}

#Preview {
    InputPasswordView()
}
