//
//  ReduxExample.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

final class ReduxViewController: BaseComponentViewController {
    var props: ReduxProps! { // find a way to not force unwrap
        didSet {
            triggerRender()
        }
    }

    let store: Store

    init(store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
        self.props = updatedProps(for: store.getState())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        store.subscribe(subscriber: self)
    }

    override func render() -> Component {
        return ReduxView(props: props)
    }

    func updatedProps(for state: AppState) -> ReduxProps {
        let counterState = state as? CounterAppState ?? CounterAppState.initial
        let counter = counterState.counters[0] // temporary until this can support multiple counters

        return ReduxProps(
            counter: CounterViewProps(count: counter.count, layout: ComponentLayout(dimension: .fill, height: 100)),
            buttons: [
                ButtonProps(title: "Increase",
                            titleColor: .black,
                            layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 50),
                            handler: { [weak self] control in
                        self?.store.dispatch(action: .increaseCount(counter.id))
                }),
                ButtonProps(title: "Decrease",
                            titleColor: .black,
                            layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 50),
                            handler: { [weak self] control in
                        self?.store.dispatch(action: .decreaseCount(counter.id))
                }),
            ]
        )
    }
}

// MARK: - Subscriber
extension ReduxViewController: Subscriber {
    func update(_ state: AppState) {
        props = updatedProps(for: state)
    }
}
