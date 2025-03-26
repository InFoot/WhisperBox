//
//  Coordinator.swift
//  WhisperBox
//
//  Created by 한건희 on 3/26/25.
//

import Combine
import SwiftUI

final class Coordinator: ObservableObject {
    @Published var route: [ViewType] = []
    
    func push(_ viewPath: ViewType) {
        route.append(viewPath)
    }
    
    func pop() {
        route.removeLast()
    }
    
    func popToRoot() {
        route.removeAll()
    }
}
