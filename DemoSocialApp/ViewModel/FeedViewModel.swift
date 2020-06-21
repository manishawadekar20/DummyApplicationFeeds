//
//  FeedViewModel.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/20/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import Foundation

private var feeds:Feed = Feed()

class FeedViewModel {
    
    typealias FeedsCompletionHandler = (Feed?, Error?) -> Void
    
    // MARK: - Initialize
    private init() {
    }
    // MARK: -
    
    // MARK: - Public Methods
    // MARK: -
}

extension FeedViewModel {
    static func fetchFeeds(onCompletion: @escaping FeedsCompletionHandler){
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
}
