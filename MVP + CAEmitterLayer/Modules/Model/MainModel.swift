//
//  MainModel.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 03.01.25.
//

import Foundation

struct ProgressModel {
    private(set) var progress: Int = 0
    let maxProgress = 10

    mutating func increment() {
        if progress < maxProgress {
            progress += 1
        }
    }

    mutating func decrement() {
        if progress > 0 {
            progress -= 1
        }
    }

    mutating func reset() {
        progress = 0
    }
}

enum ProgressAction {
    case increment, decrement, reset
}

enum ProgressBarAction {
    case add, delete, reset
}
