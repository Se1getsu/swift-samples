//
//  ViewController.swift
//  rich01
//
//  Created by 垣本 桃弥 on 2023/04/09.
//

import UIKit

class ViewController: UIViewController {
    private let textView = UITextView()
    
    private var keyboardHeight: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        textView.frame = view.bounds
        textView.delegate = self
        textView.text = String(repeating: "これは UITextView を使ったテストです。\n", count: 100)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        keyboardHeight = keyboardFrame.height
        
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        textViewDidChange(textView)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        textView.textContainerInset = UIEdgeInsets.zero
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        var contentOffset = textView.contentOffset
        let cursorPosition = textView.selectedTextRange?.start ?? textView.beginningOfDocument
        var cursorRect = textView.caretRect(for: cursorPosition)
        let visibleRect = CGRect(x: 0, y: 0, width: textView.bounds.width, height: textView.bounds.height - keyboardHeight)
        cursorRect.origin.y -= contentOffset.y

        if cursorRect.maxY > visibleRect.maxY {
            contentOffset.y += cursorRect.maxY - visibleRect.maxY
        }

        textView.setContentOffset(contentOffset, animated: true)
    }
}

