//
//  LockedLetterView.swift
//  WhisperBox
//
//  Created by kirby on 3/26/25.
//

import SwiftUI

struct LockedLetterView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                topBar
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
                Spacer()
                bottomButton
            }
            content
        }
        .background(.black.opacity(0.7))
    }
        
    var topBar: some View {
        HStack(spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark").resizable().frame(width: 20, height: 20).foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            Spacer()
        }
    }
    
    var content: some View {
        VStack {
            ZStack {
                Image("locked_letter").resizable().aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width - 40)
                Text("쪽지 두 개만 보내면\n쪽지함을 열어볼 수 있어요!").font(.system(size: 25))
                    .offset(y: 50)
                    .multilineTextAlignment(.center)
            }
            Spacer().frame(height: 100)
        }
    }
    
    var bottomButton: some View {
        Button(action: {
            
        }) {
            Capsule().fill(.white)
                .overlay(
                    Text("쪽지 보내고 자물쇠 풀기")
                )
        }
        .buttonStyle(.plain)
        .frame(height: 54)
        .padding(.horizontal, 20)
    }
}

#Preview {
    LockedLetterView()
}
