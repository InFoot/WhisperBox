//
//  CompletedSentView.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//
import SwiftUI

struct CompletedSentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var showMain = false
    var nickname: String?

    var body: some View {
        VStack {
            Spacer()
            Image("clap_illustration")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)

            Spacer()
            Text("마음이 전해졌어요!\n행복을 전해줘서 고마워요.")
                .font(.title2)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .transition(.opacity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    coordinator.popToRoot()
                }
            }
        }
    }
}
