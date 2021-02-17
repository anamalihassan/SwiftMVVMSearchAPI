//
//  Utils.swift
//  TV Shows
//
//  Created by Ali Hassan on 10/02/2021.
//


import UIKit

class Utils {
    static func displayAlert(forViewController vc:UIViewController, with title: String, message: String, actions: [UIAlertAction]? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        vc.present(alertController, animated: true)
    }
    
    // MARK: - Print logs, generic function to hide logs for release
    
    static func printLog(_ items: Any..., separator: String = " ", terminator: String = "\n"){
//        let output = items.map { "*\($0)" }.joined(separator: separator)
//        Swift.print(output, terminator: terminator)
    }
}
