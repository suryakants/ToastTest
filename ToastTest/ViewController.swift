//
//  ViewController.swift
//  ToastTest
//
//  Created by Suryakant Sharma on 08/06/16.
//  Copyright © 2016 Suryakant Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var textField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.makeToast(message: "Simple Toast")
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longTap(_:)))
        textField.addGestureRecognizer(longGesture)
        
//        self.view.makeToast(message: "Simple Toast", duration: 2.0, position: HRToastPositionDefault, image: UIImage(named: "ic_120x120")!)
        
//        self.view.makeToast(message: "It is just awesome", duration: 2.0, position: HRToastPositionDefault, title: "Simple Toast")
//        
//        self.view.makeToast(message: "It is just awesome", duration: 2.0, position: HRToastPositionCenter, title: "Simple Toast", image: UIImage(named: "ic_120x120")!)
        
//        self.view.makeToastActivity()
//        self.view.makeToastActivity(message: HRToastPositionCenter)
//        self.view.makeToastActivity(position: HRToastPositionDefault, message: "Loading")
//        self.view.makeToastActivityWithMessage(message: "Loading")

    }
    
    func longTap(sender : UIGestureRecognizer){
        print("Long tap")
        if sender.state == .Ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .Began {
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func longPresslongPressed(sender: UILongPressGestureRecognizer){
        print("Hello ji");
    }
    
    @IBAction func letsShowToast(){
        
    

        ToastManager.sharedToastManager.showSBToast(withMessage: "Download Download added self.view.makeToast(message: It is just awesome, duration: 2.0, position: HRToastPositionCenter, title: Simple Toast, image: UIImage(named: ic_120x120)!)Download added self.view.makeToast(message: It is just awesome, duration: 2.0, position: HRToastPositionCenter, title: Simple Toast, image: UIImage(named: ic_120x120)!)Download added self.view.makeToast(message: It is just awesome, duration: 2.0, position: HRToastPositionCenter, title: Simple Toast, image: UIImage(named: ic_120x120)!)Download added self.view.makeToast(message: It is just awesome, duration: 2.0, position: HRToastPositionCenter, title: Simple Toast, image: UIImage(named: ic_120x120)!)Download added self.view.makeToast(message: It is just awesome, duration: 2.0, position: HRToastPositionCenter, title: Simple Toast, image: UIImage(named: ic_120x120)!)Download added self.view.makeToast(message: It is just awesome, duration: 2.0, position: HRToastPositionCenter, title: Simple Toast, image: UIImage(named: ic_120x120)!)Download added self.view.makeToast(message: It is just awesome, duration: 2.0, position: HRToastPositionCenter, title: Simple Toast, image: UIImage(named: ic_120x120)!)Download added self.view.makeToast(message: It is just awesome, duration: 2.0, position: HRToastPositionCenter, title: Simple Toast, image: UIImage(named: ic_120x120)!)");
    }
    
    @IBAction func letsShowToastAgain(){
        
        ToastManager.sharedToastManager.showSBToast(withMessage: "Download added");
//        UIMenuItem *someAction = [[UIMenuItem alloc]initWithTitle:@"Something" action:@selector(doSomething:)];
//        UIMenuController *menu = [UIMenuController sharedMenuController];
//        menu.menuItems = [NSArray arrayWithObject:someAction];
//        [menu update];
        
        let customMenu =  UIMenuItem(title: "Share…", action: #selector(self.bhaago(_:)));
        let menuController = UIMenuController.sharedMenuController();
        menuController.menuItems = [customMenu,customMenu];
        menuController.update();
    }
    
    func bhaago(Obj :AnyObject){
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func configureChildViewController(childController: UIViewController, onView: UIView?) {
        var holderView = self.view
        if let onView = onView {
            holderView = onView
        }
        addChildViewController(childController)
        holderView.addSubview(childController.view)
        childController.didMoveToParentViewController(self)
    }


}

