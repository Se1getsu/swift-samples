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
    private let pointSize: Double = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var text = #"一次方程式$ax+b=0$の解は$x=-b/a$です。"# + "\n"
        text += #"$ax^2+bx+c=0$の解の公式は$x=-\left(\frac{b\pm\sqrt{b^2-4ac -\frac{b(a-a)\pm\sqrt{b^2-4ac}}{2a} }}{2a}\right)$です。"#
        let font = UIFont(name: "ArialMT", size: pointSize)!
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        textView.attributedText = decodeLatex(attributedString: attributedText)
        
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
    
    func decodeLatex(attributedString: NSMutableAttributedString) -> NSMutableAttributedString {
        let regex = try! NSRegularExpression(pattern: #"(?<!\\)\$(.+?)(?<!\\)\$"#, options: [])
        let entireRange = NSRange(location: 0, length: attributedString.length)
        let matches = regex.matches(in: attributedString.string, options: [], range: entireRange)
            
        for match in matches.reversed() {
            let matchRange = match.range(at: 0)
            let matchFormulaRange = match.range(at: 1)
            let formula = attributedString.attributedSubstring(from: matchFormulaRange).string
            
            if let attachment = getLatexAttachment(string: formula, pointSize: pointSize) {
                let replacement = NSAttributedString(attachment: attachment)
                attributedString.replaceCharacters(in: matchRange, with: replacement)
            }
        }
        
        return attributedString
    }

    func getLatexAttachment(string: String, pointSize: Double) -> NSTextAttachment? {
        let label = MTMathUILabel()
        label.latex = string
        label.fontSize = pointSize
        label.sizeToFit()
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let flip = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        let image = UIImage(cgImage: flip.cgImage!, scale: 1, orientation: .downMirrored)
        
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -label.bounds.height/2 + pointSize/3, width: label.bounds.width, height: label.bounds.height)
        return attachment
    }
}

