//
//  ViewType.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//

enum ViewType: Hashable {
    case inputNickname
    case welcomeUser
    case main
    case lockedLetter
    case writeMessage(User?)
    case searchReceiver
}
