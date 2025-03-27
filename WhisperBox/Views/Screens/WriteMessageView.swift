//
//  WriteMessageView.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//
import SwiftUI

struct WriteMessageView: View {
    @ObservedObject private var viewModel: WriteMessageViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var isSelectingUser = false

    init(_ user: GetUserResModel? = nil) {
        self.viewModel = WriteMessageViewModel(user: user)
    }

    @ViewBuilder
    private var userSelectorSheet: some View {
        UserListView { selected in
            viewModel.selectedUser = selected
            self.isSelectingUser = false
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("따뜻한 말을 건네보세요")
                .font(.custom("Pretendard", size: 23.09).weight(.bold))
                .foregroundColor(Color(hex: "#262626"))

            Text("받는 사람 선택하기")
                .font(.custom("Pretendard", size: 16.58).weight(.semibold))
                .foregroundColor(Color(hex: "#212124"))

            Button {
                if !viewModel.isAnonymous {
                    isSelectingUser = true
                }
            } label: {
                HStack {
                    let displayName = viewModel.selectedUser?.nickName ?? (viewModel.isAnonymous ? (viewModel.anonymousNickname ?? "익명") : "받는 사람을 선택해주세요")
                    Text(displayName)
                        .foregroundColor(Color(hex: "#4D5159"))
                        .font(.custom("Pretendard", size: 14.63))
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(Color(hex: "#4D5159"))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5.85)
                        .stroke(Color(hex: "#D1D3D8"), lineWidth: 0.98)
                )
            }
            .disabled(viewModel.isAnonymous)
            .sheet(isPresented: $isSelectingUser) {
                userSelectorSheet
            }

            HStack {
                Text("쪽지 작성하기")
                    .font(.custom("Pretendard", size: 16.58).weight(.semibold))
                    .foregroundColor(Color(hex: "#212124"))
                Spacer()
                Text("익명에게 보내기")
                    .font(.custom("Pretendard", size: 13.65))
                    .foregroundColor(Color(hex: "#878B93"))
                Spacer().frame(width: 10)
                Toggle("", isOn: $viewModel.isAnonymous)
                    .labelsHidden()
                    .onChange(of: viewModel.isAnonymous) {
                        if viewModel.isAnonymous {
                            viewModel.clearSelectedUser()
                        }
                    }
            }

            ZStack(alignment: .topLeading) {
                TextEditor(text: $viewModel.message)
                    .frame(height: 148.2)
                    .padding(.horizontal, 8)
                    .background(Color.clear)
                if viewModel.message.isEmpty {
                    Text(templates[viewModel.selectedTemplateIndex].contents)
                        .foregroundColor(Color(hex: "#878B93"))
                        .padding(12)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5.85)
                    .stroke(Color(hex: "#D1D3D8"), lineWidth: 0.98)
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(templates.indices, id: \.self) { index in
                        let template = templates[index]
                        let isSelected = viewModel.selectedTemplateIndex == index
                        Text(template.label)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(isSelected ? Color(hex: "#4D5159") : Color.clear)
                            .foregroundColor(isSelected ? .white : .black)
                            .overlay(
                                Capsule()
                                    .stroke(Color(hex: "#4D5159"), lineWidth: 1)
                            )
                            .clipShape(Capsule())
                            .onTapGesture {
                                viewModel.selectedTemplateIndex = index
                            }
                    }
                }
            }

            Spacer()

            Text("익명에게 보내기는 랜덤 상대에게 쪽지를 보내는 기능입니다.\n추천 주제에 대한 쪽지를 보내주세요! \n익명의 상대로부터 비밀 답장을 받을 수 있어요.")
                .font(.custom("Pretendard", size: 13))
                .foregroundColor(Color(hex: "#6F6F6F"))
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .frame(maxWidth: .infinity)
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer()

            Button(action: {
                LocalData.sendCount += 1
                Task {
                    await viewModel.sendMessage(from: viewModel.allUsers)
                }
            }) {
                Text("다음으로")
                    .font(.custom("Pretendard", size: 16).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isFormValid ? Color(hex: "#262626") : Color(hex: "#F4F4F4"))
                    .foregroundColor(viewModel.isFormValid ? .white : Color(hex: "#A8A8A8"))
                    .cornerRadius(28)
            }
            .disabled(!viewModel.isFormValid)
            .padding(.horizontal, 20)
        }
        .padding()
    }
}
