//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

struct ToDoItem {
    let id: UUID
    let title: String
    
    init(title: String) {
        self.id = UUID()
        self.title = title
    }
}

private let cellIdentifier = "ToDoItemCell"

class ToDoListViewController: UITableViewController {
    var items: [ToDoItem] = []
    weak var addButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        addButton = navigationItem.rightBarButtonItem
    }

    @objc func addButtonPressed(_ sender: Any) {
        let newCount = items.count + 1
        let title = "ToDo Item \(newCount)"
        items.append(.init(title: title))
        let indexPath = IndexPath(row: newCount - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        if newCount >= 10 {
            addButton?.isEnabled = false
        }
    }
}

extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, view, done in
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            if self.items.count < 10 {
                self.addButton?.isEnabled = true
            }
            done(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

let navigationViewController = UINavigationController(rootViewController: ToDoListViewController())
PlaygroundPage.current.liveView = navigationViewController



//: [Next](@next)
