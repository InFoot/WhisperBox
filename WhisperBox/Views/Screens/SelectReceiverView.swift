//
//  SelectReceiverView.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//
import SwiftUI
import Combine

struct SelectReceiverView: View {
    @ObservedObject var viewModel: SelectReceiverViewModel = SelectReceiverViewModel()
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            topBar
            userSearch
        }
        .onAppear {
            self.viewModel.fetchUserList()
        }
    }
    
    var topBar: some View {
        ZStack {
            HStack {
                Spacer()
                Text("받는 사람 선택하기").font(.system(size: 18, weight: .semibold))
                Spacer()
            }
            HStack(spacing: 0) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward").resizable().aspectRatio(contentMode: .fit).frame(width: 10, height: 10)
                }
                Spacer()
            }
        }
    }
    
    var userSearch: some View {
        RoundedRectangle(cornerRadius: 10).fill(Color(.lightGray)).frame(height: 48)
            .overlay(
                HStack(spacing: 0) {
                    Image("search").resizable().aspectRatio(contentMode: .fit).frame(width: 21)
                        .padding(.trailing, 15)
                    TextField("편지를 보내고 싶은 상대를 검색하세요", text: self.$viewModel.searchText) { }
                        .onChange(of: self.viewModel.searchText) {
                            
                        }
                }
            )
    }
}
