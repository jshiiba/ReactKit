# ReactKit
ReactKit is an experimental React and Redux inspired framework that encourages building declarative and composable UI components within a uni-directional data flow. It is written entirely in Swift and utilizes a native UICollectionView. 

**This is a work in progress**: All the pieces (Components, renderer, redux) of the overall framework have been built and work together but its very limited in functionality so far.

```swift

class HelloWorldViewController: BaseComponentViewController {
	override func render() -> Component {
		return Label(props: LabelProps(title: "Hello World"))
	}
}

```

### Components
Components are objects that take properties (PropTypes) as input and render UIViews or additional Components as output. Components can be composed of other Components or an array of Components (Container), but the important aspect is that they all reduce down to singular UIViews to be displayed.

### PropTypes
The PropTypes protocol defines the properties that each Component needs in order to render.

## Renderer
Similiar to React, ReactKit uses a **Renderer** to take Components as input, reconciles the changes that were made with a virtual UICollectionViewDataSource, and outputs a new UI by only updating the views with "stale data". The Renderer abstracts the below logic, so all you have to worry about is constructing your Component views and rerendering when there is new data (see the Redux section below).

### Render Flow
1. A Component Tree is given as input to the Renderer
2. Renderer translates the Component Tree into a "virtual UICollectionView datasource" represented as `Sections` containing `Rows`.
3. Renderer Caches the virtual datasource
4. Renderer reconciles the previously cached datasource with the newly constructed datasource and determines which Rows were changed based on diffing each Row's props.
5. Renderer takes the updated index paths and updates the real UICollectionViewDataSource

The above algorithm is very naive right now and will need to be optimized for speed and additional functionality.

## Redux
// TODO: (Check out the ReduxExample for now)

Inspiration:

- [React](https://facebook.github.io/react/)
- [BrickKit](https://github.com/wayfair/brickkit-ios)
- [Redux](http://redux.js.org/)

## TODOs and Issues
1. Make Container a subclas	s of Component to enable the layout to be more generic. Right now they are both BaseComponents, but this Model structure is problematic.
2. Allow for Composite Components (Components that do not reduce down to a single UIView)
3. Allow the Renderer to accept a Container or Component (this makes the above HelloWorld example not work)
4. Many levels of Containers within Containers does not work correctly
5. Make the Store take a Generic StateType
6. Make protocols for all objects in the Renderer 
7. More Unit Tests!
