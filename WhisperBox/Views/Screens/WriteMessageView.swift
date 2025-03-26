//
//  WriteMessageView.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import SwiftUI

struct WriteMessageView: View {
    @StateObject private var viewModel = WriteMessageViewModel()
    @State private var isSelectingUser = false
    @ViewBuilder
    private var userSelectorSheet: some View {
        UserListView { selected in
            viewModel.selectedUser = selected
        }
    }
    
    // test, 제거 필요
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // 1. 제목
                    VStack(alignment: .leading, spacing: 4) {
                        Text("마음 전하기")
                            .font(.title)
                            .bold()
                        Text("따스한 말 한마디가 큰 파장이 돼요")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    // 2. 유저 선택
                    Text("받는 사람 선택하기")
                        .font(.headline)

                    Button {
                        if !viewModel.isAnonymous {
                            isSelectingUser = true
                        }
                    } label: {
                        HStack {
                            Text((viewModel.selectedUser?.nickname ?? (viewModel.isAnonymous ? viewModel.anonymousNickname : "누구에게 마음을 전해볼까요?"))!)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .disabled(viewModel.isAnonymous) // ← 익명이면 비활성화
                    .sheet(isPresented: $isSelectingUser) {
                        UserListView { selected in
                            viewModel.selectedUser = selected
                        }
                    }

                    // 3. 익명 스위치
                    HStack {
                        Text("익명에게 보내기")
                            .font(.subheadline)
                        Spacer()
                        Toggle("", isOn: $viewModel.isAnonymous)
                            .labelsHidden()
                            .onChange(of: viewModel.isAnonymous) {
                                if viewModel.isAnonymous {
                                    viewModel.clearSelectedUser()
                                }
                            }
                    }

                    // 4. 메시지 입력
                    Text("쪽지 작성하기")
                        .font(.headline)

                    TextEditor(text: $viewModel.message)
                        .frame(height: 120)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )

                    // 5. 템플릿 선택 (ChoiceChip)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(templates.indices, id: \.self) { index in
                                let template = templates[index]
                                Text(template.label)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(viewModel.selectedTemplateIndex == index ? Color.black : Color.gray.opacity(0.2))
                                    .foregroundColor(viewModel.selectedTemplateIndex == index ? .white : .black)
                                    .clipShape(Capsule())
                                    .onTapGesture {
                                        viewModel.selectedTemplateIndex = index
                                    }
                            }
                        }
                    }

                    // 6. 정보 텍스트
                    Text("익명에게 보내기는 랜덤 상대에게 쪽지를 보내는 기능입니다.\n추천 주제에 대한 쪽지를 보내주세요!\n익명의 상대로부터 비밀 답장을 받을 수 있어요.")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    // 7. 전송 버튼
                    Button("마음 전하기") {
                        // MARK: 먼저 네비게이션 스택에서 pop
                        dismiss()
                        // MARK: 하루 전송 횟수 1 증가
                        LocalData.sendCount += 1
                        Task {
                            await viewModel.sendMessage(from: users)
                        }
                    }
                    .disabled(!viewModel.isFormValid)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isFormValid ? Color.black : Color.gray.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .disabled(!viewModel.isFormValid)
                    NavigationLink(
                        destination: MessageSentView(nickname: viewModel.selectedUser?.nickname),
                        isActive: $viewModel.didSendMessage,
                        label: { EmptyView() }
                    )
                    .hidden()

                }
                .padding()
            }
            .navigationTitle("쪽지 작성")
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
