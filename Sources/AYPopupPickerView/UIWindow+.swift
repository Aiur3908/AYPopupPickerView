//
//  UIWindow+.swift
//  HelloQQ
//
//  Created by JerryYu on 2020/8/13.
//  Copyright © 2020 DolphinBro. All rights reserved.
//

import UIKit

extension UIWindow {
    static var keyWindow: UIWindow? {
        var keyWindow: UIWindow?
        if #available(iOS 13, *) {
            keyWindow = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first(where: { $0.isKeyWindow })
        } else {
            keyWindow = UIApplication.shared.keyWindow
        }
        return keyWindow
    }
}
