//
//  Store.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

///
/// Represents an object that subscribes to updates to the state
///
protocol Subscriber {
    func update(_ state: AppState)
}

///
/// Stores the app state, provides methods to dispatch new actions
/// and notifies subscribers with an updated state.
///
final class Store {

    private var reducer: Reducer
    private var state: AppState
    private var subscribers: [Subscriber] = []

    init(state: AppState, reducer: Reducer) {
        self.state = state
        self.reducer = reducer
    }

    func getState() -> AppState {
        return state
    }

    func dispatch(action: Action) {
        state = reducer.handle(action, with: state)
        print(state)
        subscribers.forEach { $0.update(state) }
    }

    // listeners
    func subscribe(subscriber: Subscriber)  {
        subscribers.append(subscriber)
    }
}
