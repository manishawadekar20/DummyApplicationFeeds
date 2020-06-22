//
//  NetworkManager.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/20/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import Foundation

protocol NetworkManager {
    typealias SuccessHandler = (Success) -> Void
    typealias ErrorHandler = (Error) -> Void
    

    static func doAPICall(request: URLRequest, onSuccess: @escaping SuccessHandler, onError: @escaping ErrorHandler)
    static func downLoadImage(request: URL, onSuccess: @escaping SuccessHandler, onError: @escaping ErrorHandler)
}

extension NetworkManager {
    
    static func doAPICall(request: URLRequest, onSuccess: @escaping SuccessHandler, onError: @escaping ErrorHandler) {
    
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let dataTaskJob = session.dataTask(with: request) { data, response, error in
            if let error = error {
                let error = Error(errorCode: error._code, errorMessage: error.localizedDescription)
                onError(error)
            }
            else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        if let data = data {
                            let success = Success(data: data, request: request)
                            onSuccess(success)
                        }
                    }
                    else {
                        var error = Error(errorCode: ErrorCode.generic.rawValue, errorMessage: AlertMessages.generic)
                        if let data = data, data.isEmpty == false {
                            do {
                                error = try JSONDecoder().decode(Error.self, from: data)
                            }
                            catch {
                                //Do nothing
                            }
                        }
                        else {
                            error = Error(errorCode: response.statusCode, errorMessage: AlertMessages.generic)
                        }
                        onError(error)
                    }
                }
                else {
                    let error = Error(errorCode: ErrorCode.generic.rawValue, errorMessage: AlertMessages.generic)
                    onError(error)
                }
            }
        }
        dataTaskJob.resume()
    } //end of doAPICall
    
    static func downLoadImage(request: URL, onSuccess: @escaping SuccessHandler, onError: @escaping ErrorHandler) {
        let session = URLSession.shared
        
        let task = session.downloadTask(with: request, completionHandler: { (location, response, error) in
            if let data = try? Data(contentsOf: request) {
                DispatchQueue.main.async {
                    let success = Success(data: data, request: URLRequest(url: request))
                    onSuccess(success)
                }
            }
        })
        task.resume()
    }
    
}
