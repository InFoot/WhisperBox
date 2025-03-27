//
//  FirebaseService.swift
//  WhisperBox
//
//  Created by 한건희 on 3/25/25.
//

import FirebaseDatabase

class FirebaseService {
    static let shared = FirebaseService()
    private let database = Database.database().reference()
    
    private init() { }
    
    // MARK: 닉네임, 비밀번호로 유저 저장, (3.26) 일단 직접 저장하는 것으로?
    func saveUserAccount(nickName: String, password: String) async -> Result<Bool, WhisperBoxError> {
        do {
            try await database.child("users").child(nickName).setValue(["nickName": nickName, "password": password])
            return .success(true)
        } catch {
            return .failure(.firebaseError)
        }
    }
    
    // MARK: 닉네임에 해당하는 유저 정보 불러오기 (닉네임, 비밀번호)
    func getUserAccountInfo(nickName: String) async -> Result<GetUserResModel, WhisperBoxError> {
        do {
            
            // ["nickName": nickName, "password": password]
            let result = try await database.child("users").child(nickName).getData()
            guard let resultJson = result.value as? [String: Any] else {
                // TODO: 에러 분기
                return .failure(.firebaseError)
            }
            let getUserResModel = GetUserResModel(nickName: resultJson["nickName"] as? String ?? "",
                                                  password: resultJson["password"] as? String ?? "")
            return .success(getUserResModel)
        } catch {
            // TODO: 에러 분기
            return .failure(.firebaseError)
        }
    }
    
    // MARK: 닉네임, 비밀번호로 로그인
    func login(nickName: String, password: String) async -> Result<Bool, WhisperBoxError> {
        do {
            let dataSnapshot = await database.child("users").observeSingleEventAndPreviousSiblingKey(of: .value).0
            for child in dataSnapshot.children {
                if let childSnapshot = child as? DataSnapshot, let childValue = childSnapshot.value as? [String: String] {
                    if childValue["nickName"] == nickName && childValue["password"] == password {
                        return .success(true)
                    }
                }
            }
            return .failure(.userNotFound)
        }
    }
    
    // MARK: 편지 정보 저장
    func sendLetter(sender: String, recievers: [String], content: String, isAnonymous: Bool) async throws -> Result<Bool, WhisperBoxError> {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        let keyDateString = "\(dateComponents.year!)_\(dateComponents.month!)_\(dateComponents.day!)"
        let valueDateString = "\(dateComponents.year!).\(dateComponents.month!).\(dateComponents.day!) \(dateComponents.hour!):\(dateComponents.minute!)"
        do {
            for reciever in recievers {
                try await database.child("letters").child(reciever).child(keyDateString).child(UUID().uuidString).setValue(["content": content, "sender": sender, "isAnonymous": isAnonymous, "letterDate": valueDateString])
            }
            return .success(true)
        } catch {
            return .failure(.firebaseError)
        }
    }
    
    func getUserLetters(userNickname: String, date: Date) async -> Result<[LetterInfo], WhisperBoxError> {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let keyDateString = "\(dateComponents.year!)_\(dateComponents.month!)_\(dateComponents.day!)"
        
        // MARK: date에 해당하는 날짜에 유저에게 도착한 편지 리스트
        var letterList: [LetterInfo] = []
        
        let dataSnapshot = await database.child("letters").child("ted").child(keyDateString).observeSingleEventAndPreviousSiblingKey(of: .value).0
        for child in dataSnapshot.children {
            if let childSnapshot = child as? DataSnapshot, let childValue = childSnapshot.value as? [String: Any] {
                var letter = LetterInfo()
                letter.sender = childValue["sender"] as? String
                letter.letterDate = childValue["letterDate"] as? String
                letter.content = childValue["content"] as? String
                letter.isAnonymous = childValue["isAnonymous"] as? Bool
                letterList.append(letter)
            }
        }
        return .success(letterList)
    }
    
    // MARK: 전체 유저 목록 가져오기
    func getAllUsers() async -> Result<[GetUserResModel], WhisperBoxError> {
        do {
            let dataSnapshot = try await database.child("users").getData()
            
            var userList: [GetUserResModel] = []

            for child in dataSnapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let childValue = childSnapshot.value as? [String: Any],
                   let nickName = childValue["nickName"] as? String,
                   let password = childValue["password"] as? String {
                    userList.append(GetUserResModel(nickName: nickName, password: password))
                }
            }
            
            return .success(userList)
        } catch {
            return .failure(.firebaseError)
        }
    }
}

struct GetUserResModel:  Identifiable, Hashable, Equatable {
    var id: String { nickName }
    var nickName: String
    var password: String = ""
}



struct LetterInfo: Hashable {
    var sender: String?
    var letterDate: String?
    var isAnonymous: Bool?
    var content: String?
}

enum WhisperBoxError: Error {
    // TODO: firebase 에러에 대한 분기 작업 필요
    case firebaseError
    case userNotFound
    
    var description: String {
        switch self {
        case .firebaseError:
            return "Firebase 내부 에러가 발생하였습니다."
            
        case .userNotFound:
            return "해당 유저 정보를 찾지 못하였습니다."
        }
    }
}
