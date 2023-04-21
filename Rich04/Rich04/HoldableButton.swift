//
//  HoldableButton.swift
//  rich04
//
//  Created by 垣本 桃弥 on 2023/04/19.
//

import UIKit

class HoldableButton: UIButton {

    var countingInterval: (Int) -> Double = { count in
        return count >= 20 ? 0.05
        : count >= 5 ? 0.1
        : 0.5
    }
    
    private var effectView: UIView = UIView()
    private var timer: Timer?
    private var count = 0

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        effectView.backgroundColor = .black
        effectView.layer.cornerRadius = layer.cornerRadius
        effectView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        effectView.alpha = 0.1
        addSubview(effectView)

        UIView.animate(withDuration: 0.2) {
            self.effectView.transform = CGAffineTransform.identity
            self.effectView.alpha = 0.2
        }
        
        if timer == nil || !timer!.isValid {
            count = 1
            timer = Timer.scheduledTimer(
                timeInterval: countingInterval(count),
                target: self,
                selector: #selector(executeAction),
                userInfo: nil,
                repeats: false)
        }
    }
    
    @objc func executeAction() {
        count += 1
        timer = Timer.scheduledTimer(
            timeInterval: countingInterval(count),
            target: self,
            selector: #selector(executeAction),
            userInfo: nil,
            repeats: false)
        sendActions(for: .touchDown)
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
        UIView.animate(withDuration: 0.2, animations: {
            self.effectView.alpha = 0.1
        }) { (_) in
            self.effectView.removeFromSuperview()
        }
        timer?.invalidate()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        effectView.frame = bounds
    }
    
    func addEvent(_ target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchDown)
    }
}
