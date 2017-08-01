# ReactKit
ReactKit is an experimental React and Redux inspired framework that encourages building declarative and composable UI components within a uni-directional data flow.

Inspiration:

- [React](https://facebook.github.io/react/)
- [BrickKit](https://github.com/wayfair/brickkit-ios)
- [Redux](http://redux.js.org/)

## TODOs and Issues
1. **In progress**: Separate Layout code from the Translator into its own framework (or at least a different class)
    - Abstract the renderer models (Row, Section) from FlowLayout
    - Add the concepts of different Layout behaviors other than "Flow" (Justified, Directions)
2. Make Container a subclass of Component to enable the layout to be more generic. Right now they are both BaseComponents, but this model of structure is problematic.
3. Allow for Composite Components (Components that do not reduce down to a single UIView)
4. Allow the Renderer to accept a Container or Component
5. Many levels of Containers within Containers does not work correctly
6. Make the Store take a Generic StateType
