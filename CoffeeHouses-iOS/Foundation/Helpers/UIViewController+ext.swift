//
//  UIViewController+ext.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import UIKit

private let swizzling: (UIViewController.Type, Selector, Selector) -> Void = { forClass, originalSelector, swizzledSelector in
    if let originalMethod = class_getInstanceMethod(forClass, originalSelector), let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
        let didAddMethod = class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    static func swizzle() {
        let originalSelector1 = #selector(viewDidLoad)
        let swizzledSelector1 = #selector(swizzled_viewDidLoad)
        swizzling(UIViewController.self, originalSelector1, swizzledSelector1)
    }
    
    @objc open func swizzled_viewDidLoad() {
        if let _ = navigationController {
            if #available(iOS 14.0, *) {
                navigationItem.backButtonDisplayMode = .minimal
            } else {
                navigationItem.backButtonTitle = ""
            }
        }
        swizzled_viewDidLoad()
    }
}
