# ReactKit
ReactKit is an experimental React and Redux inspired framework that allows for declarative and reuseable UI components within a uni-directional data flow.


## TODOs and Issues
1. Separate Layout code from the Translator into its own framework (or at least a different class)
2. Make Container a subclass of Component to enable the layout to be more generic. Right now they are both BaseComponents, but this model of structure is problematic.
3. Allow for Composite Components (Components that do not reduce down to a single UIView)
4. Many levels of Containers within Containers does not work correctly
5. Make the Store take a Generic StateType