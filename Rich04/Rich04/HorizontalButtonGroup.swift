//
//  HorizontalButtonGroup.swift
//  rich04
//
//  Created by 垣本 桃弥 on 2023/04/19.
//

import UIKit

class HorizontalButtonGroup: UIView {
    var separatorColor: UIColor = .clear
    
    private var buttons: [UIButton] = []
    private var separators: [UIView] = []
    private var pushViews: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    func addSubButton(_ button: UIButton) {
        buttons.append(button)
        if buttons.count > 1 {
            let separator = UIView()
            separator.backgroundColor = separatorColor
            separators.append(separator)
            separator.translatesAutoresizingMaskIntoConstraints = false
            addSubview(separator)
        }
        button.backgroundColor = .clear
        button.layer.cornerRadius = layer.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        let pushView = UIView()
        pushView.backgroundColor = .systemPink.withAlphaComponent(0.3)
        pushViews.append(pushView)
        pushView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pushView)
    }
    
    override func layoutSubviews() {
        layoutButtons()
    }
    
    private func layoutButtons() {
        guard buttons.count > 0 else { return }
        
        for (index, button) in buttons.enumerated() {
            if index != 0 {
                NSLayoutConstraint.activate([
                    separators[index-1].centerYAnchor.constraint(equalTo: centerYAnchor),
                    separators[index-1].topAnchor.constraint(equalTo: topAnchor, constant: 7),
                    separators[index-1].leadingAnchor.constraint(equalTo: buttons[index-1].trailingAnchor),
                    separators[index-1].widthAnchor.constraint(equalToConstant: 1)
                ])
            }
            NSLayoutConstraint.activate([
                button.centerYAnchor.constraint(equalTo: centerYAnchor),
                button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / CGFloat(buttons.count), constant: index == 0 ? 0 : -1),
                button.heightAnchor.constraint(equalTo: heightAnchor),
                pushViews[index].centerXAnchor.constraint(equalTo: button.centerXAnchor),
                pushViews[index].centerYAnchor.constraint(equalTo: button.centerYAnchor)
            ])
            if index == 0 {
                button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: separators[index-1].trailingAnchor).isActive = true
            }
        }
    }
}
