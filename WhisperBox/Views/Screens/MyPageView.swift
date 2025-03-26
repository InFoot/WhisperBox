//
//  MyPageView.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/25/25.
//

import SwiftUI

struct MyPageView: View {
    
    private var userName : String = "Go"
    //To-do : UserName 저장하기
    
    var receivedMessageList : [ReceivedMessage]
    
    //임시 데이터
    init() {
        receivedMessageList = [
            ReceivedMessage(date: "3.26. 14:33", content: "테드! 개발하는 모습이 정말 멋집니다.ㅎㅎ\n언제 한 번 커피챗 하고 싶어요!\n조만간 연락할게요 :)", isTodayLetter: true),
            ReceivedMessage(date: "3.25. 14:33", content: "테드! 개발하는 모습이 정말 멋집니다.ㅎㅎ\n언제 한 번 커피챗 하고 싶어요!\n조만간 연락할게요 :)", isTodayLetter: false),
            ReceivedMessage(date: "3.25. 14:33", content: "누구인지는 모르겠지만, 오늘 하루 힘냈으면 해요!\n저는 오늘 기분이 우울했는데, 쪽지를 받고 위로가 됐거든요. 그러니까 힘내세요! ><", isTodayLetter: false)
        ]
    }
    
    var body : some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 40){
                    // 1. 제목
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(userName), 오늘 기분은 어때요?")
                            .font(.title)
                            .bold()
                    }
                    
                    // 2. 쪽지 보내기
                    Button {
                        //To-do : WriteMessageView와의 연결
                    } label: {
                        ZStack{
                            VStack{
                                HStack{
                                    Text("쪽지 보내기")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.black)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.bottom, 20)
                                
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("오늘의 TMI를 작성해보세요.")
                                        .foregroundColor(.gray.opacity(0.8))
                                    Text("ex) 오늘 보도블럭을 핥았는데 달더라구요.")
                                        .foregroundColor(.gray.opacity(0.8))
                                        .padding(.bottom, 70)
                                    //To-do : grey 색상값 찾는 방법 물어보기
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            }
                        }
                        .overlay(
                            Image("success_illustration")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 130)
                                .offset(x: 10, y: -40),
                            alignment: .topTrailing
                        )
                    }
                    
                    // 3. 받은 쪽지함
                    VStack{
                        HStack{
                            Text("받은 쪽지함")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        
                        ForEach(receivedMessageList, id: \.id) { message in
                            if message.isTodayLetter {
                                ZStack {
                                    VStack(alignment: .leading) {
                                        Text("\(message.date)")
                                            .foregroundColor(.black)
                                            .padding(.bottom, 10)
                                        Text("\(message.content)")
                                            .foregroundColor(.gray.opacity(0.8))
                                            .padding(.bottom, 10)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.gray)
                                    
                                    VStack {
                                        Text("0/2")
                                        Text("새로 온 쪽지를 열어보려면")
                                        Text("두 개의 쪽지를 보내야 해요.")
                                    }
                                }
                            } else {
                                VStack(alignment: .leading) {
                                    Text("\(message.date)")
                                        .foregroundColor(.black)
                                        .padding(.bottom, 10)
                                    Text("\(message.content)")
                                        .foregroundColor(.gray.opacity(0.8))
                                        .padding(.bottom, 10)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            }
                        }
                    }
                }.padding(16)
            }
        }
    }
}


#Preview {
    MyPageView()
}

// 임시 struct
// To-do : 받은 쪽지 받아올 struct 상의해서 구성하기
struct ReceivedMessage {
    var id = UUID()
    var date : String
    var content : String
    var isTodayLetter : Bool
}
