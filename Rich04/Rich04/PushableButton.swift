//
//  PushableButton.swift
//  rich04
//
//  Created by 垣本 桃弥 on 2023/04/20.
//

import UIKit

class PushableButton: UIButton {
    
    private var effectView: UIView = UIView()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        effectView.backgroundColor = .black
        effectView.layer.cornerRadius = layer.cornerRadius
        effectView.alpha = 0.2
        addSubview(effectView)
    }
    
    @objc func executeAction() {
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        handleRelease()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        handleRelease()
    }
    
    func handleRelease() {
        effectView.removeFromSuperview()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        effectView.frame = bounds
    }
}
