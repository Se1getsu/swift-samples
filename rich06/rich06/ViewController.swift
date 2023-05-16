//
//  ViewController.swift
//  rich06
//
//  Created by 垣本 桃弥 on 2023/05/15.
//

// [Stack Overflow] UITableViewCell shows an unexpected blue outer frame
// https://stackoverflow.com/questions/76254824/uitableviewcell-shows-an-unexpected-blue-outer-frame

import UIKit

class ViewController: UIViewController {
    
    let splitVC = UISplitViewController(style: .doubleColumn)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstVC = MenuViewController()
        let secondVC = SecondViewController()
        
        splitVC.viewControllers = [
            UINavigationController(rootViewController: firstVC),
            UINavigationController(rootViewController: secondVC)
        ]
        
        splitVC.modalPresentationStyle = .fullScreen
        present(splitVC, animated: false)
        splitVC.show(.primary)
    }
}

class SecondViewController: UIViewController {
    private let textView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        textView.frame = CGRect(x: 100, y: 200, width: 400, height: 100)
        view.addSubview(textView)
    }
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .systemGray5
        table.layer.cornerRadius = 10
        return table
    }()
    
    private var contents = ["aaa", "bbb", "ccc", "ddd", "eee"]
    private var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            table.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -55),
            table.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5),
            table.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -5),
        ])
        
        table.dataSource = self
        table.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = contents[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .systemYellow
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let selectedIndexPath = selectedIndexPath {
            tableView.cellForRow(at: selectedIndexPath)?.backgroundColor = .systemYellow
        }
        tableView.cellForRow(at: indexPath)?.backgroundColor = .systemOrange
        selectedIndexPath = indexPath
    }
}
