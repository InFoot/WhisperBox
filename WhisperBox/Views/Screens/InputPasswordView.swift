//
//  InputPasswordView.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/26/25.
//

import SwiftUI
import Combine

struct InputPasswordView: View {
    @FocusState private var isPasswordFocused: Bool
    @ObservedObject var viewModel: InputPasswordViewModel = InputPasswordViewModel()
    
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
                        if filtered.count > 3 {
                            self.viewModel.password = String(filtered.prefix(4))
                            self.viewModel.isPasswordFilled = true
                        } else {
                            self.viewModel.password = filtered
                            self.viewModel.isPasswordFilled = false
                        }
                    }
                Spacer()
                
                // 3. 다음으로 버튼
                NavigationLink(destination: LoginSuccessView(), isActive: self.$viewModel.shouldNavigate){
                    Button{
                        self.viewModel.login()
                    } label: {
                        Text("다음으로")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(self.viewModel.isPasswordFilled ? .white : .gray)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(self.viewModel.isPasswordFilled ? .black : Color.gray.opacity(0.1))
                            .clipShape(Capsule())
                    }
                    .padding(.bottom, isPasswordFocused ? 10 : 20)
                    .disabled(!self.viewModel.isPasswordFilled)
                }
            }
            .padding()
            .onTapGesture {
                withAnimation {
                    isPasswordFocused = false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                withAnimation {
                    isPasswordFocused = true
                }
            }
        }
    }
}

#Preview {
    InputPasswordView()
}
