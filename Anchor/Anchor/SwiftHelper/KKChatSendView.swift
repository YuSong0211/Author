//
//  KKChatSendView.swift
//  KK
//
//  Created by Gwynne on 2021/8/17.
//

import UIKit

@objc (KKChatSendViewDelegate)
public protocol KKChatSendViewDelegate {
    ///显示键盘
    func keyboardWillShow(_ keyboardHeight:CGFloat)
    ///隐藏键盘
    func keyboardWillHide()
    //输入改变
    func textViewDidChange(_ containerHeight: CGFloat)
    ///点击发送
    func sendActionWith(text: String)
}

public class KKChatSendView: UIView {
    
    @objc public var doneBtnBgColor: UIColor!
    
    @objc public var mainBgColor: UIColor!
    
    @objc public var textViewBgColor: UIColor!
    
    @objc public var textViewTextColor: UIColor!
    
    @objc public var textViewPlaceholderTextColor: UIColor!
    
    @objc public weak var delegate: KKChatSendViewDelegate?
    
    let minContainerHeight: CGFloat = 49

    var containerHeight: CGFloat = 0
    
    @objc public var textView: UITextView!
    
    @objc public var placeHolderLabel = UILabel()
    
    var residueLabel = UILabel()
    
    var container = UIView()
    
    var valueText: String?
    
    var keyboardHeight: CGFloat = 0
     
    var doneBtn = UIButton(type: .system)
    
    var placeholder = ""
    
    var keyboardType: UIKeyboardType = .default
    
    var maxCount = 1
    
    @objc public var confirmCallBack: ((String)->Void)?
    
    @objc public var showCallBack: ((CGFloat)->Void)?
    
    @objc public var dismissCallBack: ((CGFloat)->Void)?
    
    @objc public var textViewDidChangeCallBack: ((_ height:CGFloat,_ keybordHeight:CGFloat)->Void)?
    
    var safeAreaBottomeight: CGFloat = 0;
    
    @objc public init(valueText: String,placeholder: String,keyboardType: UIKeyboardType,maxCount: Int,containerHeight: CGFloat,doneBtnBgColor: UIColor,mainBgColor:UIColor,textViewBgColor: UIColor,textViewTextColor:UIColor) {
        super.init(frame: .zero)
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
    
    func getScreenWidth() -> CGFloat {
        return Screen.width > Screen.height ? Screen.height : Screen.width
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
        container.frame = CGRect.init(x: 0, y: 0, width: self.getScreenWidth(), height: containerHeight + 100)
        container.backgroundColor = self.mainBgColor
        self.addSubview(container)
        
        textView = UITextView()
        textView.frame = CGRect(x: 10, y: 7.5, width: self.getScreenWidth() - 10 - 60 - 10 - 10, height: containerHeight - 15)
        textView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        textView.backgroundColor = self.textViewBgColor
        textView.textColor = self.textViewTextColor
        textView.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textView.returnKeyType = .send
        textView.isScrollEnabled = true
        textView.keyboardType = self.keyboardType
        textView.layer.cornerRadius = (containerHeight - 15) / 2
        textView.delegate = self
        container.addSubview(textView)
        
        residueLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        container.addSubview(residueLabel)
        residueLabel.isHidden = true
        residueLabel.textColor = .gray
        residueLabel.font = UIFont.systemFont(ofSize: 10)
        residueLabel.textAlignment = .center

        doneBtn.frame = CGRect(x: self.getScreenWidth() - 10 - 60, y: containerHeight - 30 - 10, width: 60, height: 30)
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
        
        placeHolderLabel.frame = CGRect.init(x:5, y:2.5, width:self.getScreenWidth() - 10 - 60 - 10 - 10, height:containerHeight - 20)
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
                self.delegate?.keyboardWillHide()
            }
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue.size.height {
                self.delegate?.keyboardWillShow(keyboardHeight)
                self.keyboardHeight = keyboardHeight
                print(self.keyboardHeight)
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
        self .textViewDidChange(self.textView)
    }
    
    @objc public func dismiss() {
        textView.resignFirstResponder()
        if textView.text == nil || textView.text == ""{
            self.placeholder = "说点什么吧"
            self.placeHolderLabel.text = self.placeholder
        }
    }
    
    @objc public func remove() {
        self.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }

}

//MARK: - UITextViewDelegate
extension KKChatSendView: UITextViewDelegate {
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
        
    
        let maxHeight: CGFloat = 130.0
        let constraintSize: CGSize = CGSize(width: textView.frame.size.width - 20, height: maxHeight)
        let size = textView.sizeThatFits(constraintSize)
        
        if size.height > 70 {
            return
        }
        
        textView.frame.size.height = size.height
        self.containerHeight = size.height + 15
        self.delegate?.textViewDidChange(self.containerHeight)
        print("contentSize = \(textView.sizeThatFits(constraintSize))")
        
    }
    
    func confirmActionWith(text: String) {
        let text1 = text.replacingOccurrences(of: " ", with: "")
        if text1 == "" {
            return print("内容不能为空")
        }
        print(text)
        self.delegate?.sendActionWith(text: text)
        self.textView.text = ""
        self.textViewDidChange(self.textView)
    }
    
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.confirmActionWith(text: textView.text)
            return false
        }
        return true
    }
}
