//
//  MessageService.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import Foundation

struct MessageService {

    static func save(message: String, to user: User) async throws {
        _ = FileManager.default
        let directory = try getDirectory(for: user.nickname)

        let timestamp = ISO8601DateFormatter().string(from: Date())
        let fileURL = directory.appendingPathComponent("\(timestamp).txt")

        try message.write(to: fileURL, atomically: true, encoding: .utf8)
        print("✅ 메시지 저장됨: \(fileURL.path)")
    }

    static func saveToRandomUsers(message: String, from users: [User], count: Int = 5) async throws {
        let selected = users.shuffled().prefix(count)
        for user in selected {
            try await save(message: message, to: user)
        }
    }

    private static func getDirectory(for nickname: String) throws -> URL {
        let root = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let folder = root.appendingPathComponent("Messages/\(nickname)")
        if !FileManager.default.fileExists(atPath: folder.path) {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        }
        return folder
    }
}
