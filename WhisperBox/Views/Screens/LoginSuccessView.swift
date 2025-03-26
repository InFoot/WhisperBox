//
//  LoginSuccessView.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/27/25.
//

import SwiftUI

struct LoginSuccessView: View {
    @State private var navigateToNextView = false
    
    var body: some View{
        NavigationStack{
            VStack{
                Image(.loginSuccessIllustration)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    navigateToNextView = true
                }
            }
            .navigationDestination(isPresented: $navigateToNextView) {
                MyPageView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginSuccessView()
}
