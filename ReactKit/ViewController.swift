//
//  ViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    struct MyComponentProps: MyComponentPropType {
        let backgroundColor: UIColor
        let title: String
    }

    private let identifier = "ID"
    private var container: Container?

    override func viewDidLoad() {
        super.viewDidLoad()

        let flow = ComponentFlowLayout()
        flow.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        collectionView?.collectionViewLayout = flow
        collectionView?.register(BaseComponentCell.self, forCellWithReuseIdentifier: identifier)
        configureComponents()
    }

    func configureComponents() {
        container = Container(components: [
            MyComponent(props: MyComponentProps(backgroundColor: .green, title: "Hello")),
            MyComponent(props: MyComponentProps(backgroundColor: .blue, title: "World")),
            MyComponent(props: MyComponentProps(backgroundColor: .green, title: "Hello")),
            MyComponent(props: MyComponentProps(backgroundColor: .blue, title: "World")),
            GenericComponent<UIButton> { [weak self] (button) in
                button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
                button.backgroundColor = .red
                button.setTitle("Press me", for: .normal)
                button.add(for: .touchUpInside) {
                    self?.dispatch()
                }
            }
        ])
    }

    func dispatch() {
        print("dispatch action")
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BaseComponentCell

        guard let component = container?.components[indexPath.row].render() else {
            return UICollectionViewCell()
        }

        cell.configure(with: component)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return container?.childrenCount ?? 0
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

