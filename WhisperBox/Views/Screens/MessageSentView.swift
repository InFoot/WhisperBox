//
//  MessageSentView.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import SwiftUI

struct MessageSentView: View {
    @Environment(\.dismiss) var dismiss

    var nickname: String?

    var body: some View {
        VStack(spacing: 40) {
            Image("start_illustration")
                .resizable()
                .scaledToFit()
            Spacer()

            Text("짝짝짝! 마음이 전해졌어요.\n행복을 전해줘서 고마워요.")
                .font(.title2)
                .multilineTextAlignment(.center)

            if let nickname = nickname {
                Text("받는 사람: \(nickname)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Button("처음으로") {
                dismiss() // 현재 화면 닫고 이전으로 돌아감
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(12)

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}
