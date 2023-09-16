//
//  SampleEndPoint.swift
//  MVVM_Post
//
//  Created by Adarsh Singh on 17/09/23.
//

import Foundation

enum SampleEndPoint{
    case sample
    case addSample(data: AddData)
}

extension SampleEndPoint: EndPointType{
    var path: String {
        switch self {
        case .sample:
            return "posts"
        case .addSample:
            return "posts"
        }
    }
    
    var baseURL: String {
        switch self {
        case .sample:
            return "https://jsonplaceholder.typicode.com/"
        case .addSample:
            return "https://jsonplaceholder.typicode.com/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var methods: HTTPMethods {
        switch self {
        case .sample:
           return .get
        case .addSample:
            return .post
        }
    }
    
    var body: Codable? {
        switch self {
        case .sample:
            return nil
        case .addSample(let data):
            return data
        }
    }
    
    var header: [String : String]? {
        ApiManager.commonHeader
    }
    
    
}
