//
//  FirebaseTest.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//

import Testing
@testable import WhisperBox
import Foundation

struct FirebaseTests {
//    @Test func saveExampleData() async {
//        await FirebaseController.shared.saveUserData()
//    }
    
    @Test func saveTestUserData() async {
        let peppr: [String] = [
            "Wade", "Yeony", "Gigi", "Murphy", "Finn", "OneThing", "Junia", "Jacob", "Luke", "Pray",
            "iL", "Paran", "Bota", "Daisy", "JIN", "Noah", "Brandnew", "Demian", "Mingky", "Hidy",
            "Cherry", "Isla", "Weaver", "Paidion", "Joid", "Hari", "Monica", "Minbol", "Dora", "Moo",
            "J", "Chloe", "Kirby", "Steve", "Hama", "Angie 🪽", "Riel", "Miru", "Mumin", "Libby",
            "Lucas", "Bob", "Elena", "Glowny", "JudyJ", "Woody", "Dewy", "Julianne", "Rundo", "Howard",
            "May", "Echo", "Ted", "Bin", "Nyx", "KON", "Sandeul", "Ian", "Ivy", "Herry", "Lemon",
            "Loa", "Isaac", "Sera", "ssol", "Jun", "Avery", "ARI", "Isa", "Taki", "Zani", "Jenna",
            "Jiku", "Pherd", "Yan", "Cheshire", "Heggy", "Nike", "Frank", "Rohd", "Lina", "Rama",
            "Yuha", "Singsing", "Erin", "Judy", "Viera", "Min", "HappyJay", "gabi", "Dean", "Zhen",
            "Presence", "Luka", "Theo", "Eddey", "Seo", "Ken", "RIA", "Sana", "Jam", "Simi", "Kwango",
            "Kinder", "Excellenty", "Sally", "Jerry", "Anne", "Enoch", "Leeo", "Wish", "Jenki", "Gus",
            "Jomi", "Evan", "Martin", "Sena", "Romak", "Jeje", "Yoshi", "Emma", "Kaia", "Yoon", "Alex",
            "MK", "Ethan", "Fine", "Nika", "Bear", "Noter", "Mini", "Three", "One", "Hong", "Velko",
            "Kadan", "Jooni", "Jina", "Jung", "Nathan", "ⒼⓄ Go", "Taeni", "Ito", "Air", "Dodin",
            "Hyun", "Mosae", "Gil", "Coulson", "Karyn", "Eifer", "Wendy", "Nell", "Powel", "Saya",
            "Elian", "Leo", "Berry", "Yuu", "Sky", "Root", "Zigu", "Jack", "Nayl", "Tether", "Sup",
            "Lumi", "Friday", "Joy", "Snow", "Jaeryong 째룡", "Baba", "Ella", "WAY", "Ell", "Elphie",
            "Kave", "Wonjun", "Henry", "Green", "Skyler", "Cerin", "Paduck", "Mary", "My", "Gyeong",
            "Soop", "Oliver", "Daniely (L)", "JeOng", "Leon", "peppr"
        ]
        for str in peppr {
            let result = await FirebaseService.shared.saveUserAccount(nickName: str, password: "1234")
            switch result {
            case .success(let result):
                print("save user : \(result)")
            case .failure(let result):
                print(result.description)
            }
        }
//        let result = await FirebaseService.shared.saveUserAccount(nickName: "tech", password: "1234")
//        switch result {
//        case .success(let result):
//            print("save user : \(result)")
//        case .failure(let result):
//            print(result.description)
//        }
    }
    
    // 유저 정보를 가져오는 로직
    @Test func getTestUserDataTest() async {
        let result = await FirebaseService.shared.getUserAccountInfo(nickName: "ted")
        switch result {
        case .success(let userResModel):
            print(userResModel.nickname)
            print(userResModel.password)
        case .failure(let failure):
            print(failure.description)
        }
    }
    
    @Test func loginTest() async {
        let result = await FirebaseService.shared.login(nickName: "ted", password: "1236")
        switch result {
        case .success(let success):
            print("login success")
        case .failure(let failure):
            print(failure)
        }
    }
    
    @Test func sendLetterTest() async {
        do {
            let peppr: [String] = [
                "Wade", "Yeony", "Gigi", "Murphy", "Finn", "OneThing", "Junia", "Jacob", "Luke", "Pray",
                "iL", "Paran", "Bota", "Daisy", "JIN", "Noah", "Brandnew", "Demian", "Mingky", "Hidy",
                "Cherry", "Isla", "Weaver", "Paidion", "Joid", "Hari", "Monica", "Minbol", "Dora", "Moo",
                "J", "Chloe", "Kirby", "Steve", "Hama", "Angie 🪽", "Riel", "Miru", "Mumin", "Libby",
                "Lucas", "Bob", "Elena", "Glowny", "JudyJ", "Woody", "Dewy", "Julianne", "Rundo", "Howard",
                "May", "Echo", "Ted", "Bin", "Nyx", "KON", "Sandeul", "Ian", "Ivy", "Herry", "Lemon",
                "Loa", "Isaac", "Sera", "ssol", "Jun", "Avery", "ARI", "Isa", "Taki", "Zani", "Jenna",
                "Jiku", "Pherd", "Yan", "Cheshire", "Heggy", "Nike", "Frank", "Rohd", "Lina", "Rama",
                "Yuha", "Singsing", "Erin", "Judy", "Viera", "Min", "HappyJay", "gabi", "Dean", "Zhen",
                "Presence", "Luka", "Theo", "Eddey", "Seo", "Ken", "RIA", "Sana", "Jam", "Simi", "Kwango",
                "Kinder", "Excellenty", "Sally", "Jerry", "Anne", "Enoch", "Leeo", "Wish", "Jenki", "Gus",
                "Jomi", "Evan", "Martin", "Sena", "Romak", "Jeje", "Yoshi", "Emma", "Kaia", "Yoon", "Alex",
                "MK", "Ethan", "Fine", "Nika", "Bear", "Noter", "Mini", "Three", "One", "Hong", "Velko",
                "Kadan", "Jooni", "Jina", "Jung", "Nathan", "ⒼⓄ Go", "Taeni", "Ito", "Air", "Dodin",
                "Hyun", "Mosae", "Gil", "Coulson", "Karyn", "Eifer", "Wendy", "Nell", "Powel", "Saya",
                "Elian", "Leo", "Berry", "Yuu", "Sky", "Root", "Zigu", "Jack", "Nayl", "Tether", "Sup",
                "Lumi", "Friday", "Joy", "Snow", "Jaeryong 째룡", "Baba", "Ella", "WAY", "Ell", "Elphie",
                "Kave", "Wonjun", "Henry", "Green", "Skyler", "Cerin", "Paduck", "Mary", "My", "Gyeong",
                "Soop", "Oliver", "Daniely (L)", "JeOng", "Leon", "peppr"
            ]
            
            for str in peppr {
                let result = try await FirebaseService.shared.sendLetter(sender: "ted", recievers: [str], content: "오늘 보도블럭을 핥았는데 달더라구요. 오시면 보도블럭 맛집 추천드립니다", isAnonymous: false)
                switch result {
                case .success(let success):
                    print("success to send letter")
                case .failure(let failure):
                    print("fail to send letter")
                }
            }
            
        } catch {
            
        }
    }
    
    @Test func getLetterTest() async {
        let result = await FirebaseService.shared.getUserLetters(userNickname: "echo", date: Date())
        switch result {
        case .success(let letterList):
            print("---- Letter List ----")
            print(letterList)
        case .failure(let failure):
            print(failure)
        }
    }

    // 전체 유저 목록을 가져오는 테스트
    @Test func getAllUsersTest() async {
        let result = await FirebaseService.shared.getAllUsers()
        switch result {
        case .success(let users):
            print("\n---- 전체 유저 목록 ----")
            for user in users {
                print("닉네임: \(user.nickname), 비밀번호: \(user.password)")
            }
        case .failure(let error):
            print("유저 목록 가져오기 실패: \(error.description)")
        }
    }
}
