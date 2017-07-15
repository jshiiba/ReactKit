//
//  ComponentRenderer.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

///
/// - parameters: Current Components with new props
/// - returns: Components to update
class ComponentReconciler {
    func reconcile(_ currentSections: [SectionComponent], cachedSections: [SectionComponent]?) -> [SectionComponent] {
        let updatedComponents = ComponentDiffer.diff(currentSections, cachedSections)
        return updatedComponents
    }
}

///
/// - parameters: currentTree and cached tree
/// - returns: an array of components to update
class ComponentDiffer {
    static func diff(_ currentSections: [SectionComponent], _ cachedSections: [SectionComponent]?) -> [SectionComponent] {
        return currentSections
    }
}
