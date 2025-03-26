//
//  WelcomeUserView.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/26/25.
//

import SwiftUI

struct WelcomeUserView: View {
    @State private var navigateToNextView = false
    var loginNickname :String = LocalData.loginNickname
    
    var body: some View{
        NavigationStack{
            VStack{
                Text("\(loginNickname), 반가워요!")
                    .font(.title)
                    .bold()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    navigateToNextView = true
                }
            }
            .navigationDestination(isPresented: $navigateToNextView) {
                InputPasswordView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WelcomeUserView()
}
