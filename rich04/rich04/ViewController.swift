//
//  ViewController.swift
//  rich04
//
//  Created by 垣本 桃弥 on 2023/04/21.
//

import UIKit

class ViewController: UIViewController {

    let buttonGroup: HorizontalButtonGroup = {
        let buttonGroup = HorizontalButtonGroup()
        buttonGroup.backgroundColor = .systemCyan.withAlphaComponent(0.2)
        buttonGroup.separatorColor = .systemCyan
        buttonGroup.layer.cornerRadius = 10
        return buttonGroup
    }()

    let leftButton: HoldableButton = {
        let button = HoldableButton()
        button.setTitle("←", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    let centerButton: PushableButton = {
        let button = PushableButton()
        button.setTitle("⚪︎", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    let rightButton: HoldableButton = {
        let button = HoldableButton()
        button.setTitle("→", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Menlo-Regular", size: 46)
        label.textColor = .black
        label.text = "0"
        return label
    }()

    private var _count = 0
    private var count: Int {
        get {
            return _count
        }
        set {
            _count = max(0, newValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonGroup.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        buttonGroup.addSubButton(leftButton)
        buttonGroup.addSubButton(centerButton)
        buttonGroup.addSubButton(rightButton)
        view.addSubview(buttonGroup)
        view.addSubview(numberLabel)

        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            buttonGroup.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            buttonGroup.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 30),
            buttonGroup.widthAnchor.constraint(equalToConstant: 180),
            buttonGroup.heightAnchor.constraint(equalToConstant: 30),
            numberLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

        rightButton.addEvent(self, action: #selector(rightButtonTapped))
        leftButton.addEvent(self, action: #selector(leftButtonTapped))
        centerButton.addTarget(self, action: #selector(centerButtonPressed), for: .touchUpInside)
    }

    @objc func rightButtonTapped() {
        count += 1
        numberLabel.text = "\(count)"
    }

    @objc func leftButtonTapped() {
        count -= 1
        numberLabel.text = "\(count)"
    }

    @objc func centerButtonPressed() {
        count = Int.random(in: 10...99)
        numberLabel.text = "\(count)"
    }
}
