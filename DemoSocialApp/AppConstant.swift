//
//  AppConstant.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/20/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import Foundation

struct API {
    private init(){}
    
    static let feedURL = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=10"
}

struct Success {
    var data: Data?
    var request: URLRequest!
    
    init(data: Data?, request: URLRequest) {
        self.data = data
        self.request = request
    }
}

struct Error: Codable {
    var errorCode: Int
    var errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "message"
    }
    
    init() {
        self.errorCode = 0
        self.errorMessage = ""
    }
    
    init(errorCode: Int, errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let errorCode: Int = try (container.decodeIfPresent(Int.self, forKey: .errorCode) ?? 0)
            let errorMessage: String = try (container.decodeIfPresent(String.self, forKey: .errorMessage) ?? "")
            
            self.errorCode = errorCode
            self.errorMessage = errorMessage
        } catch {
            self.errorCode = ErrorCode.decoding.rawValue
            self.errorMessage = error.localizedDescription
        }
    }
}

enum ErrorCode: Int {
    case generic = -500001
    case noNetwork = -500002
    case invalidToken = -500003
    case failedValidation = -500004
    case decoding = -500005
    case notAllowToCall = -500006
    
    enum AddressBook: Int {
        case notAllow = -500101
        case contactAlreadyPresent = -500102
        case failedToSave = -500103
        case noContactFound = -500104
    }
}

struct AlertMessages {
    private init() {
    }
    
    static let generic = "Sorry, something went wrong. Please try again"
    static let noInternet = "No Internet"
    static let noData = "No data"
}
