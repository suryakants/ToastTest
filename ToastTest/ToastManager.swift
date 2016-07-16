//
//  ToastManager.swift
//  SotiSurf
//
//  Created by Suryakant Sharma on 10/06/16.
//  Copyright © 2016 Suryakant Sharma. All rights reserved.
//

import Foundation
import UIKit

class ToastManager : CustomToastViewControllerDelegate{
    static let sharedToastManager = ToastManager();
    
    var isToastBeingDisplay : Bool = false;
    var customToastViewController : CustomToastViewController!
    //Private method
    init(){
    }
    
    func showSBToast(withMessage message:String){
        
        let stroyBoard = UIStoryboard(name: "Main", bundle: nil)
        customToastViewController =  stroyBoard.instantiateViewControllerWithIdentifier("SBCustomToastViewController") as! CustomToastViewController
        customToastViewController.toastDelegate = self;
        
        self.removeSBToast();
        customToastViewController.showSBToast(WithMessage:message, andDisposingTime: 3.5, and: 0.5);
    }
    
    func showSBToast(WithMessage message:String, andDisposingTime time:Double){
        
        let stroyBoard = UIStoryboard(name: "Main", bundle: nil)
        customToastViewController =  stroyBoard.instantiateViewControllerWithIdentifier("SBCustomToastViewController") as! CustomToastViewController
        customToastViewController.toastDelegate = self;
        if isToastBeingDisplay{
            self.removeSBToast();
            isToastBeingDisplay = false;
        }
        customToastViewController.showSBToast(WithMessage:message, andDisposingTime: time, and: 0.5);
    }
    
    
    func removeSBToast(){
        
        if nil != customToastViewController{
            customToastViewController.removeSBToast();
        }
    }
    
    func bringWindowToTop() {
        UIApplication.sharedApplication().windows.last?.addSubview(customToastViewController.view);
    }
    
    //MARK: - TaostViewController Delegate
    
    @objc func taostDidAppear(){
        self.isToastBeingDisplay = true;
    }
    @objc func taostDidDisappear(){
        self.isToastBeingDisplay = false;
        customToastViewController = nil;
    }
}

