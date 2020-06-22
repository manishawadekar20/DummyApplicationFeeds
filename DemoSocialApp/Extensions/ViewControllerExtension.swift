//
//  ViewControllerExtension.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/22/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    internal final func showLoader(withColor color: UIColor = UIColor.black)
    {
        DispatchQueue.main.async {
            if self.view.viewWithTag(viewTags.loaderViewTag) == nil {
                let vwLoader: UIView = UIView(frame: UIScreen.main.bounds)
                vwLoader.tag = viewTags.loaderViewTag
                vwLoader.backgroundColor = UIColor.clear
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                let w: CGFloat = CGFloat(viewTags.loaderViewWidth)
                let x: CGFloat = (vwLoader.frame.size.width / 2) - (w / 2)
                let y: CGFloat = (vwLoader.frame.size.height / 2) - (w / 2)
                
                let frame: CGRect = CGRect(x: x, y: y, width: w, height: w)
                let avwLoader: UIActivityIndicatorView = UIActivityIndicatorView(frame: frame)
                avwLoader.tag = viewTags.activityLoaderViewTag
                avwLoader.style = .whiteLarge
                avwLoader.color = color
                
                avwLoader.hidesWhenStopped = true
                avwLoader.startAnimating()
                
                vwLoader.addSubview(avwLoader)
                self.view.addSubview(vwLoader)
            }
        }
    }
    
    // function for hiding loader from screen
    internal final func hideLoader()
    {
        DispatchQueue.main.async {
            if let vwLoader = self.view.viewWithTag(viewTags.loaderViewTag) {
                //let vwLoader: UIView = self.view.viewWithTag(viewTags.loaderViewTag)!
                let avwLoader: UIActivityIndicatorView = vwLoader.viewWithTag(viewTags.activityLoaderViewTag)! as! UIActivityIndicatorView
                avwLoader.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                avwLoader.removeFromSuperview()
                vwLoader.removeFromSuperview()
            }
        }
    }
    
    typealias completionHandler = ((_ tappedButtonTitle: String) -> Void)?
    
    internal final func showAlert(title: String, message: String, buttonTitle:String, completion:completionHandler)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: buttonTitle, style: .default) { (UIAlertAction) in
            completion?(buttonTitle)
        }
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
