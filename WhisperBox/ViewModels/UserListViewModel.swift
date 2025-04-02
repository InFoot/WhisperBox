//
//  UserListViewModel.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import Foundation
import Combine

final class UserListViewModel: ObservableObject {
    // 입력 상태
    @Published var searchText: String = ""

    // 전체 유저 목록 (고정)
    private let allUsers: [User] = [
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
        "Hyun", "Mosae", "Gil", "Coulson", "Karyn", "Eifer", "Wendy", "Nell", "Powel", "Saya",
        "Elian", "Leo", "Berry", "Yuu", "Sky", "Root", "Zigu", "Jack", "Nayl", "Tether", "Sup",
        "Lumi", "Friday", "Joy", "Snow", "Jaeryong 째룡", "Baba", "Ella", "WAY", "Ell", "Elphie",
        "Kave", "Wonjun", "Henry", "Green", "Skyler", "Cerin", "Paduck", "Mary", "My", "Gyeong",
        "Soop", "Oliver", "Daniely (L)", "JeOng", "Leon", "peppr"
    ].enumerated().map { index, name in
        User(nickname: name, name: name, code: index + 1)
    }

    // 필터링된 결과 → View에서 바인딩됨
    @Published var filteredUsers: [User] = []

    private var cancellables = Set<AnyCancellable>()

    init(users: [User]) {
        // self.allUsers = users
        setupBindings()
    }

    private func setupBindings() {
        // 검색어가 바뀔 때마다 필터링 결과를 업데이트
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                if query.isEmpty {
                    self.filteredUsers = self.allUsers
                } else {
                    self.filteredUsers = self.allUsers.filter {
                        $0.nickname.lowercased().contains(query.lowercased())
                    }
                }
            }
            .store(in: &cancellables)
    }
}
