//
//  GYTextView.swift
//  VideoPro
//
//  Created by Gwynne on 2020/7/4.
//  Copyright © 2020 Gwynne. All rights reserved.
//

import UIKit

func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

let ColorWhiteAlpha10:UIColor = RGBA(r:255.0, g:255.0, b:255.0, a:0.1)
let ColorWhiteAlpha20:UIColor = RGBA(r:255.0, g:255.0, b:255.0, a:0.2)
let ColorWhiteAlpha40:UIColor = RGBA(r:255.0, g:255.0, b:255.0, a:0.4)
let ColorWhiteAlpha60:UIColor = RGBA(r:255.0, g:255.0, b:255.0, a:0.6)
let ColorWhiteAlpha80:UIColor = RGBA(r:255.0, g:255.0, b:255.0, a:0.8)

let ColorBlackAlpha5:UIColor = RGBA(r:0.0, g:0.0, b:0.0, a:0.05)
let ColorBlackAlpha10:UIColor = RGBA(r:0.0, g:0.0, b:0.0, a:0.1)
let ColorBlackAlpha20:UIColor = RGBA(r:0.0, g:0.0, b:0.0, a:0.2)
let ColorBlackAlpha30:UIColor = RGBA(r:0.0, g:0.0, b:0.0, a:0.3)
let ColorBlackAlpha40:UIColor = RGBA(r:0.0, g:0.0, b:0.0, a:0.4)
let ColorBlackAlpha60:UIColor = RGBA(r:0.0, g:0.0, b:0.0, a:0.6)
let ColorBlackAlpha80:UIColor = RGBA(r:0.0, g:0.0, b:0.0, a:0.8)
let ColorBlackAlpha90:UIColor = RGBA(r:0.0, g:0.0, b:0.0, a:0.9)

public struct Screen {
    public static let frame = UIScreen.main.bounds
    public static let width = UIScreen.main.bounds.width
    public static let height = UIScreen.main.bounds.height
    public static let scale = UIScreen.main.scale
    public static let statusBarFrame = UIApplication.shared.statusBarFrame.size.height
}

public class GYCommentTextView: UIView {
    
    var bottomHeight: CGFloat = 0;
    
    let minContainerHeight: CGFloat = 49

    var containerHeight: CGFloat = 0
    
    @objc public var textView: UITextView!
    
    @objc public var doneBtnBgColor: UIColor!
    
    @objc public var mainBgColor: UIColor!
    
    @objc public var textViewBgColor: UIColor!
    
    @objc public var textViewTextColor: UIColor!
    
    @objc public var textViewPlaceholderTextColor: UIColor!
    
    var placeHolderLabel = UILabel()
    
    var residueLabel = UILabel()
    
    var container = UIView()
    
    var valueText: String?
    
    var keyboardHeight: CGFloat = 0
     
    @objc public var confirmCallBack: ((String)->Void)?
    
    var doneBtn = UIButton(type: .system)
    
    var placeholder = ""
    
    var keyboardType: UIKeyboardType = .default
    
    var maxCount = 1
    
    @objc public var showCallBack: ((CGFloat)->Void)?
    
    @objc public var dismissCallBack: ((CGFloat)->Void)?
    
    @objc public var textViewDidChangeCallBack: ((String)->Void)?
    
    var safeAreaBottomeight: CGFloat = 0;
    
    var newWidth: CGFloat = Screen.width
    
    @objc public init(width:CGFloat, valueText: String,placeholder: String,keyboardType: UIKeyboardType,maxCount: Int,containerHeight: CGFloat,doneBtnBgColor: UIColor,mainBgColor:UIColor,textViewBgColor: UIColor,textViewTextColor:UIColor) {
        super.init(frame: UIScreen.main.bounds)
        self.newWidth = width
        self.valueText = valueText
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.maxCount = maxCount > 200 ? 200 : maxCount
        self.containerHeight = containerHeight > 240 ? 240 : containerHeight
        self.doneBtnBgColor = doneBtnBgColor
        self.mainBgColor = mainBgColor
        self.textViewBgColor = textViewBgColor
        self.textViewTextColor = textViewTextColor
        initSubView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        initSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubView() {
        
        if #available(iOS 11.0, *) {
            if let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom , bottom > 0 {
                self.safeAreaBottomeight = bottom;
            }
        } else {
            // Fallback on earlier versions
        }
        
//        self.backgroundColor = RGBA(r: 37, g: 39, b: 47, a: 1)
        self.backgroundColor = self.mainBgColor
        self.backgroundColor = .clear
        self.containerHeight = self.containerHeight < minContainerHeight ? minContainerHeight : self.containerHeight
        self.maxCount = self.maxCount < 1 ? 1 : self.maxCount
        //添加手势
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleGuesture(sender:)))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGestureRecognizer)
        
        let swileft = UISwipeGestureRecognizer(target: self, action: #selector(swiAction(sender:)))
        swileft.direction = .left
        self.addGestureRecognizer(swileft)
        
        let swiright = UISwipeGestureRecognizer(target: self, action: #selector(swiAction(sender:)))
        swiright.direction = .right
        self.addGestureRecognizer(swiright)
        
        let swiup = UISwipeGestureRecognizer(target: self, action: #selector(swiAction(sender:)))
        swiup.direction = .up
        self.addGestureRecognizer(swiup)
        
        let swidown = UISwipeGestureRecognizer(target: self, action: #selector(swiAction(sender:)))
        swidown.direction = .down
        self.addGestureRecognizer(swidown)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(swiAction(sender:)))
        self.addGestureRecognizer(pan)
        
        //添加容器层底部view
        container.frame = CGRect.init(x: 0, y: 0, width: newWidth, height: containerHeight + safeAreaBottomeight)
//        KKRGBA(37, 39, 47, 1)
//        container.backgroundColor = RGBA(r: 37, g: 39, b: 47, a: 1)
        container.backgroundColor = self.mainBgColor
        self.addSubview(container)
        
        textView = UITextView()
        textView.frame = CGRect(x: 10, y: 7.5, width: newWidth - 10 - 60 - 10 - 10, height: containerHeight - 15)
        textView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//        textView.backgroundColor = RGBA(r: 56, g: 58, b: 68, a: 1)
//        textView.textColor = .white
        textView.backgroundColor = self.textViewBgColor
        textView.textColor = self.textViewTextColor
        textView.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textView.returnKeyType = .send
        textView.isScrollEnabled = true
        textView.keyboardType = self.keyboardType
        textView.layer.cornerRadius = (containerHeight - 15) / 2
        textView.layer.masksToBounds = true
//        textView.keyboardAppearance = .dark
        textView.delegate = self
        container.addSubview(textView)
        
        residueLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        container.addSubview(residueLabel)
        residueLabel.isHidden = true
        residueLabel.textColor = .gray
        residueLabel.font = UIFont.systemFont(ofSize: 10)
        residueLabel.textAlignment = .center

        doneBtn.frame = CGRect(x: newWidth - 10 - 60, y: containerHeight - 30 - 10, width: 60, height: 30)
        doneBtn.setTitle("发送", for: .normal)
        let color = RGBA(r: 37, g: 248, b: 208, a: 1)
        doneBtn.setTitleColor(color, for: .normal)
        doneBtn.backgroundColor = .clear
        doneBtn.layer.cornerRadius = 15.0
        doneBtn.layer.masksToBounds = true
        doneBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        doneBtn.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        self.doneBtnisEnabled(false)
        container.addSubview(doneBtn)
        
        placeHolderLabel.frame = CGRect.init(x:5, y:2.5, width:textView.frame.size.width - 10, height:containerHeight - 20)
        placeHolderLabel.text = self.placeholder
        placeHolderLabel.textColor = .gray
        placeHolderLabel.font = UIFont.systemFont(ofSize: 15)
        textView.addSubview(placeHolderLabel)
        
        if self.valueText != "" {
            textView.text = self.valueText
            placeHolderLabel.isHidden = true
        }else {
            placeHolderLabel.isHidden = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(GYCommentTextView.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(GYCommentTextView.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismiss), name: UIApplication.willResignActiveNotification, object: nil)

    }
    
    @objc public func updateWidth(_ width: CGFloat,isFullScreen: Bool) {
        let safeAreaHeight: CGFloat = isFullScreen ? 33 : 0
        newWidth = width;
        container.frame = CGRect.init(x: 0, y: 0, width: newWidth, height: containerHeight + safeAreaBottomeight)
        textView.frame = CGRect(x: 10, y: 7.5, width: newWidth - 10 - 60 - 10 - 10 - safeAreaHeight, height: containerHeight - 15)
        textView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        placeHolderLabel.frame = CGRect.init(x:5, y:2.5, width:textView.frame.size.width - 10, height:containerHeight - 20)
        doneBtn.frame = CGRect(x: newWidth - 10 - 60 - safeAreaHeight, y: 10, width: 60, height: 30)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in self.layoutIfNeeded()})
    }
    
    @objc public func setCurrentText(_ text: String) {
        self.textView.text = text
        self.textViewDidChange(self.textView)
    }
    
    @objc func swiAction(sender :UISwipeGestureRecognizer) {
        let point = sender.location(in: container)
        if !container.layer.contains(point){
            dismiss()
        }
    }
    
    func doneBtnisEnabled(_ isEnabled: Bool) {
        self.doneBtn.isEnabled = isEnabled
//        let color = isEnabled ? doneBtnBgColor : RGBA(r: 255, g: 255, b: 255, a: 0.4)
        let color = isEnabled ? doneBtnBgColor : .gray
        self.doneBtn.setTitleColor(color, for: .normal)
    }
    
    @objc func doneAction() {
        self.confirmActionWith(text: self.valueText ?? "")
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let _ = (userInfo["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue.size.height {
                self.keyboardHeight = 0;
                self.bottomHeight = self.safeAreaBottomeight;
                self.dismissCallBack?(self.containerHeight)
                self.container.frame = CGRect.init(x: 0, y: 0, width: newWidth, height: containerHeight + safeAreaBottomeight)
            }
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo["UIKeyboardBoundsUserInfoKey"] as? NSValue)?.cgRectValue.size.height {
                self.showCallBack?(0)
                self.keyboardHeight = keyboardHeight
                self.bottomHeight = 0;
                print(self.keyboardHeight)
                self.container.frame = CGRect(x: 0, y: self.frame.size.height - (self.keyboardHeight) - containerHeight, width: newWidth, height: containerHeight + 3)
            }
        }
    }
    
    @objc func handleGuesture(sender: UITapGestureRecognizer) {
        let point = sender.location(in: container)
        if !container.layer.contains(point){
            dismiss()
        }
    }
    
    @objc public func showPlaceholder(text: String) {
        self.textView.becomeFirstResponder()
        self.placeholder = text
        placeHolderLabel.text = self.placeholder
        self.textView.text = "";
        self.textViewDidChange(self.textView)
    }
    
    
    @objc public func show(text: String) {
        self.textView.becomeFirstResponder()
        self.textView.text = text
        self.textViewDidChange(self.textView)
    }
    
    @objc public func dismiss() {
        textView.resignFirstResponder()
        if textView.text == nil || textView.text == ""{
            self.placeholder = "说点好听的"
            self.placeHolderLabel.text = self.placeholder
        }
    }
    
    @objc public func remove() {
        self.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }

}

//MARK: - UITextViewDelegate
extension GYCommentTextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        if !textView.hasText {
            placeHolderLabel.isHidden = false
        } else {
            placeHolderLabel.isHidden = true
        }
        
        //限制字数拼音联想时不算
        if textView.markedTextRange == nil {
            if textView.text.count > maxCount {
                textView.text = String(textView.text.prefix(maxCount))
                textView.undoManager?.removeAllActions()
//                SVProgressHUD.showInfo(withStatus: "最多输入\(maxCount)个字")
            }
            self.valueText = textView.text
            
//            print("字数 = \(textView.text.count)")
            self.doneBtnisEnabled(textView.text.count == 0 ? false : true)
            let count = maxCount - textView.text.count
            if count <= 0 {
                residueLabel.isHidden = true
            }else {
                if count <= 10 {
                    residueLabel.isHidden = false
                    residueLabel.text = "剩余\(count)字"
                }else {
                    residueLabel.isHidden = true
                }
            }
            
        }
        //改变输入框高度
        let maxHeight: CGFloat = 130.0
        let constraintSize: CGSize = CGSize(width: textView.frame.size.width - 20, height: maxHeight)
        let size = textView.sizeThatFits(constraintSize)
        let tempHeight: CGFloat = size.height > 90 ? 90 : size.height
        textView.frame.size.height = tempHeight
        self.containerHeight = tempHeight + 15
        self.container.frame = CGRect(x: 0, y: self.frame.size.height - (self.keyboardHeight) - containerHeight - self.bottomHeight, width: newWidth, height: containerHeight + self.bottomHeight + 3)
        print("contentSize = \(textView.sizeThatFits(constraintSize))")
        self.textViewDidChangeCallBack?(textView.text)
        
    }
    ///点击发送
    @objc public func confirmActionWith(text: String) {
        let text1 = text.replacingOccurrences(of: " ", with: "")
        if text1 == "" {
            return print("内容不能为空")
        }
        print(text)
        self.confirmCallBack?(text)
        self.textView.text = ""
        self.textViewDidChange(self.textView)
        self.dismiss()
    }
    
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.confirmActionWith(text: textView.text)
            return false
        }
        return true
    }
}


