//
//  AnimationTextView.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

protocol AnimationTextViewDelegate: class {
    func didEndEditingText(animationTextView: AnimationTextView)
    func textFieldShouldReturn(animationTextView: AnimationTextView)
    func textFieldDidChange(animationTextView: AnimationTextView)
    func textFieldDidBeginEditing(animationTextView: AnimationTextView)
}

final class AnimationTextView: UIView, UITextFieldDelegate {
    
    private let leadingSpace: CGFloat = 0
    
    let label = UILabel()
    let field = UITextField()
    let line = UIView()
    var inactiveLineColor = UIColor(red: 0.73, green: 0.74, blue: 0.76, alpha: 1.0)
    
    weak var delegate: AnimationTextViewDelegate?
    
    var text: String {
        return field.text ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = .clear
        field.delegate = self
        field.tintColor = UIColor.main
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        addSubview(label)
        addSubview(field)
        addSubview(line)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let selfHeight = frame.size.height
        
        let width = frame.size.width - leadingSpace
        let fieldHeight = CGFloat(22)
        let lineHeight = CGFloat(0.5)
        line.frame = CGRect(x: leadingSpace,
                            y: selfHeight - lineHeight,
                            width: width,
                            height: lineHeight)
        field.frame = CGRect(x: leadingSpace,
                             y: selfHeight - lineHeight - fieldHeight - 5,
                             width: width,
                             height: fieldHeight)
        
        let labelY: CGFloat
        let labelHeight = field.frame.origin.y
        if (field.text != nil && !field.text!.isEmpty) || field.isFirstResponder {
            labelY = 0
        } else {
            labelY = field.frame.origin.y + (fieldHeight - labelHeight)/2
            
        }
        label.frame = CGRect(x: leadingSpace, y: labelY, width: width, height: labelHeight)
    }
    
    func configureForSignin(placeholder: String) {
        let signinFonts = UIFont.signinTextInputFonts()
        configureViews(placeholder: placeholder, fonts: signinFonts)
    }
    
    func configureForSignup(placeholder: String) {
        let signupFonts = UIFont.signupTextInputFonts()
        configureViews(placeholder: placeholder, fonts: signupFonts)
    }
    
    private func configureViews(placeholder: String, fonts: (label: UIFont, textField: UIFont)) {
        label.font = fonts.label
        field.font = fonts.textField
        if #available(iOS 13.0, *) {
            label.textColor = .tertiaryLabel
            field.textColor = .label
            inactiveLineColor = .opaqueSeparator
        } else {
            label.textColor = UIColor(white: 0, alpha: 0.3)
            field.textColor = .white
            inactiveLineColor = UIColor(white: 0, alpha: 0.1)
        }
        line.backgroundColor = inactiveLineColor
        label.text = placeholder
    }
    
    func updateText(_ text: String) {
        field.text = text
        let _ = textFieldShouldEndEditing(field)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if field.text == nil || field.text!.isEmpty {
            var frame = label.frame
            frame.origin.y = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.label.frame = frame
            })
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.line.backgroundColor = UIColor.main
        })
        delegate?.textFieldDidBeginEditing(animationTextView: self)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if field.text == nil || field.text!.isEmpty {
            UIView.animate(withDuration: 0.2, animations: {
                self.label.center = self.field.center
                self.line.backgroundColor = self.inactiveLineColor
            })
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.line.backgroundColor = self.inactiveLineColor
        })
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditingText(animationTextView: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn(animationTextView: self)
        return true
    }
    
    @objc private func textFieldDidChange() {
        delegate?.textFieldDidChange(animationTextView: self)
    }
}
