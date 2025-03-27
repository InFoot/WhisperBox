//
//  WelcomeUserView.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/26/25.
//

import SwiftUI

struct WelcomeUserView: View {
    @State private var navigateToNextView = false
    @EnvironmentObject var coordinator: Coordinator
    var loginNickname :String = LocalData.loginNickname
    
    var body: some View{
        VStack{
            Text("\(loginNickname), 반가워요!")
                .font(.title)
                .bold()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                coordinator.push(.main)
            }
        }
        .navigationDestination(isPresented: $navigateToNextView) {
            InputPasswordView()
        }
    }
}

#Preview {
    WelcomeUserView()
}
