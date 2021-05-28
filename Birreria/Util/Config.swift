//
//  Config.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 26/05/21.
//

import UIKit

class Config: NSObject {
    
    static let URL: String = "https://api.punkapi.com/v2/"
    
    //MARK:- Custom colors
    static let darkBlue = UIColor(named: "darkBlue")
    static let darkGray = UIColor(named: "darkGray")
    static let gray = UIColor(named: "gray")
    static let orange = UIColor(named: "orange")
    static let white = UIColor(named: "white")
    
    //MARK:- Custom Size
    static let largeTitle : CGFloat = 34
    static let title : CGFloat = 22
    static let headline : CGFloat = 17
    static let body : CGFloat = 16
    static let subhead : CGFloat = 13
    static let caption : CGFloat = 11
    static let cornerRadius: CGFloat = 15
}

//MARK:- Custom Fonts
func regular(_ sizeFont: CGFloat)->UIFont {
    return UIFont(name: "Poppins-Regular", size: sizeFont)!
}
func medium(_ sizeFont: CGFloat)->UIFont {
    return UIFont(name: "Poppins-Medium", size: sizeFont)!
}
func semiBold(_ sizeFont: CGFloat)->UIFont {
    return UIFont(name: "Poppins-SemiBold", size: sizeFont)!
}
func bold(_ sizeFont: CGFloat)->UIFont {
    return UIFont(name: "Poppins-Bold", size: sizeFont)!
}
