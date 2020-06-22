//
//  HomeService.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/20/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import Foundation

class HomeService: NetworkManager {
    
    // MARK: - Initialize
    private init() {
    }
    // MARK: -
    
    // MARK: - Public Methods
    // MARK: -
}

// MARK: - Private Methods
extension HomeService {
}
// MARK: -

// MARK: - Internal Methods
extension HomeService {
    static func getFeeds(onSuccess: @escaping SuccessHandler, onError: @escaping ErrorHandler) {
        let request = URLRequest(url: URL(string: API.feedURL)!)
        self.doAPICall(request: request, onSuccess: { (Success) in
            onSuccess(Success)
        }) { (Error) in
            onError(Error)
        }
    }
    
    static func downLoadImageForMedia(request: URL, onSuccess: @escaping SuccessHandler, onError: @escaping ErrorHandler) {
        self.downLoadImage(request: request, onSuccess: { (Success) in
            onSuccess(Success)
        }) { (Error) in
            onError(Error)
        }
    }
}
