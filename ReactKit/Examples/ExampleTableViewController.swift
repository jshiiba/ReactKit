//
//  ExampleTableViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

protocol ExampleTableViewControllerDelegate {
    func didSelectHelloWorldExample()
    func didSelectLayoutExample()
    func didSelectReduxExample()
}

final class ExampleTableViewController: UITableViewController {

    struct Row {
        let title: String
        let handler: () -> ()
    }

    private let identifier = "reuseIdentifier"
    var rows: [Row] = []
    var delegate: ExampleTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        rows = [
            Row(title: "Hello World Example") { [weak self] in
                self?.delegate?.didSelectHelloWorldExample()
            },
            Row(title: "Layout Example") { [weak self] in
                self?.delegate?.didSelectLayoutExample()
            },
            Row(title: "Redux Example") { [weak self] in
                self?.delegate?.didSelectReduxExample()
            }
        ]
    }

    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        cell.textLabel?.text = rows[indexPath.row].title

        return cell
    }

    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rows[indexPath.row].handler()
    }

}
