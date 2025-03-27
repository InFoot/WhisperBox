//
//  MainView.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//

import SwiftUI
import Combine

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(LocalData.userNickname), 오늘 기분은 어때요?").font(.system(size: 27, weight: .semibold))
                    .padding(.top, 30)
                    .padding(.bottom, 40)
                sendLetter
                    .padding(.bottom,30)
                receivedLetter
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            self.viewModel.viewAppeared()
        }
        .onDisappear {
            self.viewModel.viewDisappeared()
        }
    }
    
    var sendLetter: some View {
        Button(action: {
            coordinator.push(.writeMessage(nil))
        }) {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("쪽지 보내기").font(.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white).stroke(.gray).frame(height: 140)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("오늘의 TMI를 작성해보세요").font(.system(size: 14)).foregroundStyle(Color(.lightGray))
                            Text("ex) 오늘 실수로 보도블럭을 핥았는데 달더라구요").font(.system(size: 14)).foregroundStyle(Color(.lightGray))
                        }
                        .padding(.top, 15)
                        .padding(.leading, 15)
                    }
                }
                Image("success_illustration").resizable().aspectRatio(contentMode: .fit).frame(width: 130)
                    .offset(y: -45)
            }
        }
        .buttonStyle(.plain)
    }
    
    var receivedLetter: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("받은 쪽지함").font(.system(size: 20, weight: .semibold))
                Spacer()
            }
            .padding(.bottom, 20)
            todayLetterList
        }
    }
    
    var todayLetterList: some View {
        VStack(spacing: 0) {
            ForEach(self.viewModel.todayLetterList, id: \.self) { letter in
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 6).fill(.white).stroke(Color(.lightGray))
                    VStack(alignment: .leading, spacing: 0) {
                        // MARK: 편지 날짜
                        Text(letter.letterDate ?? "날짜~").font(.system(size: 18, weight: .bold)).foregroundStyle(.gray)
                            .padding(.top, 30)
                            .padding(.bottom, 15)
                        Text(letter.content ?? "편지 내용~").font(.system(size: 15, weight: .semibold)).foregroundStyle(.gray).lineLimit(nil)
                    }
                    .padding(.horizontal, 20)
                }
                .blur(radius: self.viewModel.todaySendCount < 2 ? 4 : 0)
                .frame(height: 145)
                .overlay(
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 6).fill(Color(.lightGray)).opacity(0.2)
                        Image("letter_top").resizable().aspectRatio(contentMode: .fit)
                        VStack(spacing: 0) {
                            Spacer().frame(height: 30)
                            Image("locker").resizable().aspectRatio(contentMode: .fit).frame(width: 16)
                                .padding(.bottom, 10)
                            Text("\(self.viewModel.todaySendCount) / 2").font(.system(size: 13, weight: .medium)).foregroundStyle(.gray)
                                .padding(.bottom, 5)
                            Text("새로 온 쪽지를 열어보려면\n두 개의 쪽지를 보내야 해요.").font(.system(size: 13, weight: .medium)).foregroundStyle(.gray)
                        }
                    }
                        .opacity(self.viewModel.todaySendCount < 2 ? 1 : 0)
                )
                .padding(.bottom, 10)
                .onTapGesture {
                    if self.viewModel.todaySendCount < 2 {
                        coordinator.push(.lockedLetter)
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
