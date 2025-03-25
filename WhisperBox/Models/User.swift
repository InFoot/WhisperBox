//
//  User.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import Foundation

struct User:  Identifiable, Equatable, Codable {
    var id = UUID()
    let nickname: String
    let name: String?
    let code: Int
}
