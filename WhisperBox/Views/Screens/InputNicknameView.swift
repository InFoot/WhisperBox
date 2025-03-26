//
//  InputNicknameView.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/26/25.
//

import SwiftUI

struct InputNicknameView: View {
    @State private var nickName: String = ""
    @FocusState private var isNicknameFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                Text("아카데미 닉네임을 알려주세요")
                    .font(.title)
                    .bold()
                Text("쪽지는 익명이 보장돼요 :)")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 40)
                TextEditor(text: $nickName)
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
                    .onTapGesture {
                        isNicknameFocused = true
                    }
                
                Spacer()
                Button{
                    //To-do : 동작 구현하기
                } label: {
                    Text("다음으로")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Capsule())
                    
                }
                .padding(.bottom, isNicknameFocused ? 10 : 20)
            }
            .padding()
            .onTapGesture {
                isNicknameFocused = false
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                isNicknameFocused = true
            }
        }
    }
}
    
#Preview {
    InputNicknameView()
}
