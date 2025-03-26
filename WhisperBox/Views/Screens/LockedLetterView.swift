//
//  LockedLetterView.swift
//  WhisperBox
//
//  Created by kirby on 3/26/25.
//

import SwiftUI

public struct LockedLetterView: View {
    public var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            VStack {
                Spacer()
                ZStack {
                    Image("locked_letter")
                        .resizable()
                        .scaledToFit()
                        .offset( y: -30)
                }
                Spacer()
                Button("쪽지 보내고 자물쇠 풀기") {}
                    .frame(maxWidth: .infinity)
                    .padding()
                    .buttonStyle(.borderedProminent).tint(.white)
                    .foregroundColor(.black)
                    .cornerRadius(40)
            }
            Text("쪽지 두 개만 보내면\n쪽지함을 열어볼 수 있어요!")
              .font(
                Font.custom("Pretendard",size: 27)
                  .weight(.semibold)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(.black)
              .frame(width: 342, height: 96, alignment: .top)
        }
        
    }
}

#Preview {
    LockedLetterView()
}
