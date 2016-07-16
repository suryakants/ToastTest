//
//  CustomTaostViewController.swift
//  ToastTest
//
//  Created by Suryakant Sharma on 08/06/16.
//  Copyright © 2016 Suryakant Sharma. All rights reserved.
//

import UIKit

let taostViewTag : Int = 456
let defaultCornerRadius : CGFloat = 5.0;
let defaultBackgroundColor : UIColor = UIColor(white: 0, alpha: 0.7);
let defaultToastMessageFontColor : UIColor = UIColor.whiteColor();
let defaultTimeToDisposeToast : Double = 2.0;
let defaultDisposingAnimationTime : Double = 0.5;
let defaultFontSize : CGFloat = 12.0;
let defaultShadowCplor : UIColor = UIColor.darkGrayColor();


// shadow appearance
let toastShadowOpacity  : CGFloat   = 0.8
let toastShadowRadius   : CGFloat   = 6.0
let toastShadowOffset   : CGSize    = CGSizeMake(CGFloat(4.0), CGFloat(4.0))

@objc
protocol CustomToastViewControllerDelegate {
    optional func taostWillAppear();
    optional func taostDidAppear();
    optional func taostWillDisappear();
    optional func taostDidDisappear();
}

class CustomToastViewController: UIViewController {
    
    @IBOutlet weak var sbToastView: UIView!
    @IBOutlet weak var sbToastMessage: UILabel!
    
    @IBOutlet weak var leadingCon: NSLayoutConstraint!
    @IBOutlet weak var traillingCon: NSLayoutConstraint!
    
    weak var toastDelegate: CustomToastViewControllerDelegate? = nil
    
    var displayShadow : Bool = true;
    var toastMessage : String = "";
    var timeToDisposeToast: Double = defaultTimeToDisposeToast;
    var disposingAnimationTime : Double = defaultDisposingAnimationTime;
    var toastMessageCornerRadius : CGFloat  = defaultCornerRadius;
    var taostMessageBackgroundColor : UIColor = defaultBackgroundColor;
    var toastMessageFontColor : UIColor = defaultToastMessageFontColor;
    var toastFontSize = defaultFontSize
    
    var toastDisplayShadow : Bool = true;
    var aWindow : UIWindow!
    var newWindow: UIWindow!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.bringWindowToTop), name: UIWindowDidBecomeVisibleNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidHide), name:  UIKeyboardWillShowNotification, object: nil);
        
        self.view.userInteractionEnabled = false;
        sbToastView.layer.cornerRadius = toastMessageCornerRadius;
        sbToastView.backgroundColor    = taostMessageBackgroundColor;
        sbToastMessage.font = UIFont.systemFontOfSize(toastFontSize);
        sbToastMessage.textColor = toastMessageFontColor;
        sbToastMessage.text = toastMessage;
        
        if displayShadow {
            sbToastView.layer.shadowColor   = defaultShadowCplor.CGColor;
            sbToastView.layer.shadowOpacity = Float(toastShadowRadius)
            sbToastView.layer.shadowRadius = toastShadowRadius
            sbToastView.layer.shadowOffset = toastShadowOffset
        }
        
        //assign a tag to toast view
        self.view.tag = taostViewTag;
    }
    
    override func viewDidLayoutSubviews() {
        let size = self.view.bounds
        let sizeToFit = sbToastMessage.sizeThatFits(CGSizeMake(size.width-40, CGFloat.max))
        let remainingSize = size.width - sizeToFit.width
        leadingCon.constant = remainingSize/2 - 10
        traillingCon.constant = remainingSize/2 - 10
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        if nil != toastDelegate{
            toastDelegate!.taostDidAppear?();
        }
    }
    
    func toastSetting(){
        
    }
    
    func setToastMessage(WithMessage message:String){
        toastMessage = message;
    }
    
    func showSBToast(WithMessage message:String, andDisposingTime time:Double){
        timeToDisposeToast = time;
        toastMessage = message;
        
        if nil != toastDelegate{
            toastDelegate!.taostWillAppear?()
        }

        JLToastWindow.sharedWindow.addSubview(self.view)
//        print("toast message window = \(topWindow())");
//        topWindow().addSubview(self.view);
        
        delay(timeToDisposeToast) {
            UIView.animateWithDuration(self.disposingAnimationTime, animations: {
                self.sbToastView.alpha = 0.0
                }, completion: { (true) in
                    self.view.removeFromSuperview();
                    if nil != self.toastDelegate{
                        self.toastDelegate!.taostDidDisappear?()
                    }
            })
        }
    }
    
    func showSBToast(WithMessage message:String, andDisposingTime time:Double, and disposingAnimationTime:Double){
        self.timeToDisposeToast = time;
        self.toastMessage = message;
        self.disposingAnimationTime = disposingAnimationTime;
        
        if nil != toastDelegate{
            toastDelegate!.taostWillAppear?()
        }
//        JLToastWindow.sharedWindow.addSubview(self.view)
        print("toast message window = \(topWindow())");
        topWindow().addSubview(self.view);
        
        
        delay(timeToDisposeToast) {
            UIView.animateWithDuration(self.disposingAnimationTime, animations: {
                self.sbToastView.alpha = 0.0
                }, completion: { (true) in
                    self.view.removeFromSuperview();
                    if nil != self.toastDelegate{
                        self.toastDelegate!.taostDidDisappear?()
                    }
            })
        }
    }
    
    func removeSBToast() {
//        let window =  UIApplication.sharedApplication().windows.last;
        JLToastWindow.sharedWindow.viewWithTag(taostViewTag)?.removeFromSuperview();
    }
    
    //perform action with specified 'delay' in second
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func bringWindowToTop(notification: NSNotification) {
        let windows = UIApplication.sharedApplication().windows;
        let lastWindow = windows.last;
        aWindow.windowLevel = lastWindow!.windowLevel + 1;
    }
    
    func keyboardDidHide(notification: NSNotification) {
      
        
        let secondTopWindow = UIApplication.sharedApplication().windows;
        secondTopWindow[secondTopWindow.count-2].addSubview(JLToastWindow.sharedWindow.viewWithTag(taostViewTag)!)
        
//        let windows = UIApplication.sharedApplication().windows;
//        let lastWindow = windows.last;
//        
//        if lastWindow?.viewWithTag(taostViewTag) == nil {
//            self.showSBToast(WithMessage: toastMessage, andDisposingTime: 3.5, and: 0.5);
//        }
//        
//        aWindow.windowLevel = lastWindow!.windowLevel + 1;
    }

//    if(!self.overlayView.superview){
//    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
//    
//    for (UIWindow *window in frontToBackWindows)
//    if (window.windowLevel == UIWindowLevelNormal) {
//    [window addSubview:self.overlayView];
//    break;
//    }
//    }
    
    func topWindow()-> UIWindow {
        var topWindow : UIWindow!
        
        
        let frontToBackWindow = UIApplication.sharedApplication().windows;
        
        for aWindow in frontToBackWindow {
            topWindow = aWindow;
            if topWindow.windowLevel < aWindow.windowLevel {
                topWindow = aWindow
            }
        }
        return topWindow
    }
}