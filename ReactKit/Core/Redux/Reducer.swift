//
//  Reducer.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

/// Represents a pure function in the form of (action, state) -> (state)
/// Should have no side-effects, returns a new copy of the state after an action is performed
protocol Reducer {
    /// - parameters:
    ///     - action: An action to perform on state
    ///     - state: the current app state
    /// - returns:
    ///     - a new app state after performing the given action
    func handle(_ action: Action, with state: AppState) -> AppState
}

struct AppReducer: Reducer {
    func handle(_ action: Action, with state: AppState) -> AppState {
        return countersReducer(action: action, state: state)
    }
}
