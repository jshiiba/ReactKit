# ReactKit

ReactKit is an experimental React and Redux inspired framework that encourages building declarative and composable UI components within a uni-directional data flow. It is written entirely in Swift and utilizes a native UICollectionView. 

**This is a work in progress**: All the pieces (components, renderer, redux) of the overall framework have been built and work together but its very limited in functionality so far. (Name is subject to change as well)

```swift

class HelloWorldViewController: BaseComponentViewController {
	override func render() -> Component {
		return Label(props: LabelProps(title: "Hello World!"))
	}
}

```

## Motivation
I have recently been interested in the move towards immutability and functional programming and I wanted to try bringing the Redux or Flux type uni-directional architecture to a native Swift framework. What I realised is that Redux's power comes when combined with a functional UI framework such as React. At my current company, [Wayfair](https://wayfair.com), we use our own in-house collection view framework [BrickKit](https://github.com/wayfair/brickkit-ios) to construct our UI interfaces with reusable bricks (UICollectionViews). While the composability and dynamic layouts it offers are powerful, it requires the use of identifiers and delegate callbacks to explicitly reload, initialize and modify views. This imperative approach to constructing UI elements allows for mutability of state within the controller and even the views themselves, which makes understanding the current state of your app incredibly complex.

I decided to build my own React-inspired UI framework in an attempt to make a Redux-inspired architecture possible in an iOS Swift app. I know there are several similar frameworks that already exist and have thriving communities, but I wanted the challenge of understanding how each individual piece of this overall architecture works together, and in the process get a better understanding of how React and Redux work behind the scenes.

## ReactKit Overview

### Components
Components are objects that take properties (PropTypes) as input and render UIViews or additional Components as output. Components can be composed of other Components  (Composite) or an array of Components (Container), but the important aspect is that they all reduce down to singular UIViews to be displayed.

### PropTypes
The PropTypes protocol defines the properties that each Component needs in order to render. These props are used to define the layout attributes of each component. They are also the values diffed during reconcilation, which means they must conform to the `Equatable` protocol.

### BaseComponentViewController
Any view controller that wants to use Components needs to subclass `BaseComponentViewController` and overrides its `render` method by providing the Component(s) you'd like the render. All of the complex rendering and reconcilation are done behind-the-scenes and abstracted behind the `Renderer`. When new state is received, call `triggerRender` and the View will rerender based on the new state. See the ReduxExample.

## Renderer
Similiar to React, ReactKit uses a **Renderer** to take Components as input, reconciles the changes that were made with a virtual UICollectionViewDataSource, and outputs a new UI by only updating the views with "stale data". The Renderer abstracts the below logic, so all you have to worry about is constructing your Component views and rerendering when there is new data (see the Redux section below).

### Render Flow
1. A Component Tree is given as input to the Renderer
2. Renderer translates the Component Tree into a "virtual UICollectionView datasource" represented as `Sections` containing `Rows`.
3. Renderer Caches the virtual datasource
4. Renderer reconciles the previously cached datasource with the newly constructed datasource and determines which Rows were changed based on diffing each Row's props.
5. Renderer takes the updated index paths and updates the real UICollectionViewDataSource

### Renderer Algorithm
1. Translate Component Tree to VirtualDataSource containing Sections and Rows - O(*n*)
2. Calculate Layout: Post Order Depth-First Search - O(*n*)

	```
	Start at Root Section
	For each child:
	    if row
	        Calculate Row layout
	    if section
	        Recurse on section given its width and origin
	            When this returns, all of its childrens layout will be calculated
    Update section's height based on its children
    
	```
3. Reconcile new VirtualDataSource with previously cached DataSource - O(*n*)

The above algorithm is very naive right now and will need to be optimized for speed and additional functionality.

## Redux
// TODO: (Check out the ReduxExample for now)

Inspiration:

- [React](https://facebook.github.io/react/)
- [BrickKit](https://github.com/wayfair/brickkit-ios)
- [Redux](http://redux.js.org/)

## TODOs and Issues
1. Fix my broken unit tests!
2. Make the Store take a Generic StateType
3. Make protocols for all objects in the Renderer for easier testability
4. Optimizations to renderer algorithms
5. Allow for Other types of Layouts within a Section, not just FlowLayout
6. Allow inserting and removing of index paths. Right now only updating works.
7. Support rotations
