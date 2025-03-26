//
//  MainViewModel.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var todayLetterList: [LetterInfo] = [LetterInfo(sender: "hi", letterDate: "2025.03.26 10:00:00", isAnonymous: true, content: "안녕 나는 나는 안녕 안녕 안녕 나는 나는 안녕 안녕안녕 나는 나는 안녕 안녕안녕 나는 나는 안녕 안녕")]
    @Published var todaySendCount: Int = LocalData.sendCount
    
    func viewAppeared() {
        Task {
            print(LocalData.sendCount)
            DispatchQueue.main.async {
                self.todaySendCount = LocalData.sendCount
            }
            
            let result = await FirebaseService.shared.getUserLetters(userNickname: LocalData.userNickname, date: Date())
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    withAnimation {
                       // self.todayLetterList = success
                    }
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    // MARK: 다음 날로 넘어갔다면, 카운트 0으로 초기화하도록
    func viewDisappeared() {
        if LocalData.coundViewDay == String(Calendar.current.dateComponents([.day], from: Date()).day!) {
            LocalData.sendCount = self.todaySendCount
        } else {
            LocalData.sendCount = 0
            LocalData.coundViewDay = String(Calendar.current.dateComponents([.day], from: Date()).day!)
        }
    }
}
