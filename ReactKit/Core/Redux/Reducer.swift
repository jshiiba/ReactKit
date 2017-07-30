//
//  Reducer.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

protocol Reducer {
    func handle(_ action: Action, with state: AppState) -> AppState
}

struct AppReducer: Reducer {
    func handle(_ action: Action, with state: AppState) -> AppState {
        return AppState() // replace with reduces
    }
}
