//
//  CounterReducer.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/31/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

enum Action {
    case addCounter
    case removeCounter(Int)
    case increaseCount(Int)
    case decreaseCount(Int)
}

struct Counter {
    let id: Int
    let count: Int
}

struct CounterAppState: AppState {
    let counters: [Counter]
    let nextCounterId: Int
    let totalCount: Int

    static let initial = CounterAppState(counters: [Counter(id: 0, count: 0)], nextCounterId: 1, totalCount: 1)
}

func countersReducer(action: Action, state: AppState) -> AppState {
    guard let counterState = state as? CounterAppState else {
        return state
    }

    switch action {
    case .addCounter:
        let lastCounterId = counterState.counters.isEmpty ? 0 : (counterState.counters.last?.id ?? 0) + 1
        let counter = Counter(id: lastCounterId, count: 0)
        let newCounters = counterState.counters + [counter]
        return CounterAppState(counters: newCounters,
                               nextCounterId: counter.id + 1,
                               totalCount: totalCountReducer(counters: newCounters))

    case .removeCounter(let id):
        guard let counterIndex = counterState.counters.index(where: { $0.id == id }) else { return counterState }

        let newCounters = remove(at: counterIndex, from: counterState.counters)
        return CounterAppState(counters: newCounters,
                               nextCounterId: newCounters.isEmpty ? 0 : counterState.nextCounterId,
                               totalCount: totalCountReducer(counters: newCounters))
    case .increaseCount: fallthrough
    case .decreaseCount:
        return valueChangedReducer(action, state: counterState)
    }
}

func totalCountReducer(counters: [Counter]) -> Int {
    return counters.map{ $0.count }.reduce(0, +)
}

// Helpers

func valueChangedReducer(_ action: Action, state: AppState) -> AppState {
    guard let counterState = state as? CounterAppState else {
        return state
    }

    switch action {
    case .increaseCount(let counterId):
        guard let counterIndex = counterState.counters.index(where: { $0.id == counterId }) else { return counterState }

        let newCounters = modify(counterState.counters, at: counterIndex, transform: increment)
        return CounterAppState(counters: newCounters,
                               nextCounterId: counterState.nextCounterId,
                               totalCount: totalCountReducer(counters: newCounters))
    case .decreaseCount(let counterId):
        guard let counterIndex = counterState.counters.index(where: { $0.id == counterId }) else { return counterState }

        let newCounters = modify(counterState.counters, at: counterIndex, transform: decrement)
        return CounterAppState(counters: newCounters,
                               nextCounterId: counterState.nextCounterId,
                               totalCount: totalCountReducer(counters: newCounters))
    default:
        return counterState
    }
}

func increment(counter: Counter) -> Counter {
    return changeCount(+, counter: counter)
}

func decrement(counter: Counter) -> Counter {
    return changeCount(-, counter: counter)
}

func changeCount(_ sign: (Int, Int) -> Int, counter: Counter) -> Counter {
    return Counter(id: counter.id, count: sign(counter.count, 1))
}
