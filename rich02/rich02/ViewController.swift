//
//  ViewController.swift
//  rich02
//
//  Created by 垣本 桃弥 on 2023/04/09.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapBarButton)
        )
    }

    @objc func didTapBarButton(_ sender: UIBarButtonItem) {
        let vc = PopoverViewController()
        vc.preferredContentSize = CGSize(width: 300, height: 240)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .popover
        let presentationController = navVC.popoverPresentationController
        if let sourceView = sender.value(forKey: "view") as? UIView {
            presentationController?.sourceView = sourceView
            presentationController?.sourceRect = sourceView.bounds
        }
        presentationController?.permittedArrowDirections = .up
        presentationController?.delegate = self
        present(navVC, animated: true)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}


class PopoverViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("遷移する", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "画面１"
        
        button.frame = CGRect(x: 100, y: 100, width: preferredContentSize.width - 200, height: 40)
        view.addSubview(button)

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton() {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.title = "画面２"
        navigationController?.pushViewController(vc, animated: true)
    }
}

