//
//  Container.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

protocol ContainerPropType: PropType {}

struct ContainerProps: ContainerPropType {
    let layout: ComponentLayout?
    init(layout: ComponentLayout) {
        self.layout = layout
    }
}

///
/// A container can hold an array of components.
/// Allows for components to be grouped in separate sections
///
struct Container: ComponentContaining {
    let components: [Component]
    let props: PropType

    init(components: [Component], props: ContainerPropType) {
        self.components = components
        self.props = props
    }
}
