//
//  inputPasswordViewModel.swift
//  WhisperBox
//
//  Created by 제하맥 on 3/26/25.
//

import Combine
import SwiftUI

class InputPasswordViewModel: ObservableObject {
    @Published var password: String = ""
//    @Published var filteredUsers: [User] = []
    @Published var isReceiverSelected = false
    @Published var shouldNavigate = false
}
