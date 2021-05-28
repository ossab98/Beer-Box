//
//  NetworkHandler.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 27/05/21.
//

import Foundation
import Alamofire

class NetworkHandler: NSObject {
    
    private let tag = "NetworkHandler"
    
    private func createRequest<T:Decodable>(method: HTTPMethod, urlPath: String, with decoded: T.Type, parameters: [String:Any]? = nil , returnWithData: @escaping(T?)->(), returnError: @escaping(Error?)->()){
        let urlRequest = Config.URL + urlPath
        //print("\(self.tag), \(urlRequest), Parameters: \(String(describing: parameters))")
        
        AF.request(urlRequest, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: .none).responseDecodable(of: decoded){
            response in
            self.handleResponse(urlPath: urlPath, response: response, returnWithData: returnWithData, returnError: returnError)
        }
    }
    
    private func handleResponse<T:Decodable>(urlPath: String, response: DataResponse<T,AFError>, returnWithData: @escaping(T?)->(), returnError: @escaping(Error?)->()) {
        //print("\(urlPath), Response: \(String(describing: response.value))")
        switch response.result{
        case .success( _ ):
            guard let data = response.value else {
                returnError( response.error ?? NSError(domain: "Api Failure", code: 1, userInfo: ["message": "could`t decode json data"] )); return
            }
            returnWithData(data)
        case .failure(let error):
            returnError(NSError(domain: "Api Failure", code: 1, userInfo: ["message": "\(error.localizedDescription)"]))
        }
    }
    
    func postData<T:Decodable>(urlPath: String, method: HTTPMethod, with decoded: T.Type, parameters: [String:Any]?, returnWithData: @escaping(T?)->(), returnError: @escaping(Error?)->()) {
        createRequest(method: method, urlPath: urlPath, with: decoded, parameters: parameters, returnWithData: returnWithData, returnError: returnError)
    }
    
}
