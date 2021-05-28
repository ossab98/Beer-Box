//
//  UIActivityIndicator-Extention.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 26/05/21.
//

import UIKit

extension UIView {
    
    // Default loading
    func startLoading(){
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.tag = 4756471
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .gray
        }
        
        activityIndicator.color = Config.orange // Custom Color
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }
    
    func stopLoading(){
        if let background = viewWithTag(4756471){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
    
}
