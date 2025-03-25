//
//  StartView.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import SwiftUI

struct StartView: View {
    @State private var navigateToWrite = false

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Image("start_illustration")
                    .resizable()
                    .scaledToFit()
                Spacer()

                Text("작은 응원 메시지를 보내요.\n행복이 전염될 거예요!")
                    .font(.title2)
                    .multilineTextAlignment(.center)

                Button("마음 전하기") {
                    navigateToWrite = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(12)

                Spacer()

                // 👇 NavigationLink로 WriteMessageView로 이동
                NavigationLink(
                    destination: WriteMessageView(),
                    isActive: $navigateToWrite,
                    label: { EmptyView() }
                )
                .hidden()
            }
            .padding()
            .navigationTitle("시작하기")
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
