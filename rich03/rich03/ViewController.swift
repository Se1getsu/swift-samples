//
//  ViewController.swift
//  rich03
//
//  Created by 垣本 桃弥 on 2023/04/09.
//

import UIKit

class ViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Bold", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Helvetica", size: 17)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.frame = CGRect(x: 10, y: 70, width: 60, height: 30)
        view.addSubview(button)
        textView.frame = CGRect(x: 10, y: 100, width: view.bounds.maxX-20, height: view.bounds.maxY-100)
        view.addSubview(textView)
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if textView.selectedRange.length > 0 {
            // 範囲選択部分を太字にする
            textView.textStorage.enumerateAttributes(in: textView.selectedRange, options: []) { (attributes, range, _) in
                let font = attributes[.font] as? UIFont ?? UIFont.systemFont(ofSize: 17)
                if font.fontName == "Helvetica" {
                    textView.textStorage.addAttribute(.font, value: UIFont(name: "Helvetica-Bold", size: font.pointSize)!, range: range)
                } else if font.fontName == "Helvetica-Bold" {
                    textView.textStorage.addAttribute(.font, value: UIFont(name: "Helvetica", size: font.pointSize)!, range: range)
                }
            }
        } else {
            // 太字入力にする
            var font = textView.typingAttributes[.font] as? UIFont ?? UIFont.systemFont(ofSize: 17)
            if font.fontName == "Helvetica" {
                font = UIFont(name: "Helvetica-Bold", size: font.pointSize)!
            } else if font.fontName == "Helvetica-Bold" {
                font = UIFont(name: "Helvetica", size: font.pointSize)!
            }
            textView.typingAttributes[.font] = font
        }
    }
}

