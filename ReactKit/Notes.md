
## TODO

1. Translate Node Tree into Sections and Rows for ComponentCollectionViewDataSource
    - Section == Container?
    - During construction of tree, increment section count for every Container found
    - CHANGE:
        - CollectionViewDataSources are based on sections and rows, thus tree needs to be a 2D matrix
        - Component definition: reduces down to a UIElement --> Row
        - Container definition: holds a collection of Components --> Section
        - IndexPath(section: ContainerIndex, row: ComponentIndex)
2. Be able to show cells based on Node Tree
3. Test that equatable Props works and makes sense
4. Figure out diffing algorithm
    - Use Dwifft
5.
