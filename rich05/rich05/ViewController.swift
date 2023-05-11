//
//  ViewController.swift
//  rich05
//
//  Created by 垣本 桃弥 on 2023/05/11.
//

import UIKit
import iosMath

class ViewController: UIViewController {
    
    private let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var s = #"一次方程式$ax+b=0$の解は$x=-b/a$です。"# + "\n"
        s += #"$ax^2+bx+c=0$の解の公式は$x=-\left(\frac{b\pm\sqrt{b^2-4ac -\frac{b(a-a)\pm\sqrt{b^2-4ac}}{2a} }}{2a}\right)$です。"#
        textView.text = s

        if (textView.text?.contains("$"))! {
            let tempString = textView.text!
            let tempMutableString = NSMutableAttributedString(string: tempString)
            let pattern = NSRegularExpression.escapedPattern(for: "$")
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            if let matches = regex?.matches(in: tempString, options: [], range: NSRange(location: 0, length: tempString.count)) {
                var i = 0
                while i < matches.count {
                    let range1 = matches.reversed()[i+1].range
                    let range2 = matches.reversed()[i].range
                    let finalDistance = range2.location - range1.location + 1
                    let finalRange = NSRange(location: range1.location, length: finalDistance)
                    let startIndex = String.Index(utf16Offset: range1.location + 1, in: tempString)
                    let endIndex = String.Index(utf16Offset: range2.location, in: tempString)
                    let substring = String(tempString[startIndex..<endIndex])
                    var image = UIImage()
                    image = imageWithLabel(string: substring)
                    let flip = UIImage(cgImage: image.cgImage!, scale: 4, orientation: .downMirrored)
                    let attachment = NSTextAttachment()
                    attachment.image = flip
                    attachment.bounds = CGRect(x: 0, y: -flip.size.height/2 + 5, width: flip.size.width, height: flip.size.height)
                    let replacement = NSAttributedString(attachment: attachment)
                    tempMutableString.replaceCharacters(in: finalRange, with: replacement)
                    textView.attributedText = tempMutableString
                    i += 2
                }
            }
        }
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            textView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -10),
            textView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    func imageWithLabel(string: String) -> UIImage {
        let label = MTMathUILabel()
        label.latex = string
        label.sizeToFit()
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}

