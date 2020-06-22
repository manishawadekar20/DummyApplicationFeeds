//
//  FeedViewModel.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/20/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import Foundation
import UIKit

private var feeds:Feed = Feed()
var cache: NSCache<NSString, UIImage>! = NSCache()

class FeedViewModel {
    
    typealias FeedsCompletionHandler = (Feed?, Error?) -> Void
    typealias ImageCompletionHandler = (Data?, String, Error?) -> Void
    
    // MARK: - Initialize
    private init() {
    }
    // MARK: -
    
    // MARK: - Public Methods
    // MARK: -
}

extension FeedViewModel {
    static func fetchFeeds(onCompletion: @escaping FeedsCompletionHandler) {
        HomeService.getFeeds(onSuccess: { (Success) in
            if let data = Success.data {
                do {
                    feeds = try JSONDecoder().decode(Feed.self, from: data)
                    onCompletion(feeds, nil)
                }
                catch {
                    onCompletion(nil, error as? Error)
                }
            }
        }) { (Error) in
            onCompletion(nil, Error)
        }
    }
    
    static func downloadImage(url:String, onCompletion: @escaping ImageCompletionHandler) {
        HomeService.downLoadImageForMedia(request:URL(string: url)!, onSuccess: { (Success) in
            if let data = Success.data {
                let img: UIImage! = UIImage(data: data)
                cache.setObject(img, forKey: Success.request.url!.absoluteString as NSString)
                onCompletion(data, Success.request.url!.absoluteString, nil)
            }
        }) { (Error) in
            onCompletion(nil, "", Error)
        }
    }
}
