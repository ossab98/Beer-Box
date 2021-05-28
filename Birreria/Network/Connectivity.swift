//
//  Connectivity.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 27/05/21.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
