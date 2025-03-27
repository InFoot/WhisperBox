//
//  SelectReceiverViewModel.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//

import Combine

class SelectReceiverViewModel: ObservableObject {
    @Published var userList: [GetUserResModel] = []
    @Published var searchText: String = ""
    
    func fetchUserList() {
        
    }
}
