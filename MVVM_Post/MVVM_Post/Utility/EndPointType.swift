//
//  EndPointType.swift
//  MVVM_Post
//
//  Created by Adarsh Singh on 17/09/23.
//

import Foundation

enum HTTPMethods: String{
    
    case get = "GET"
    case post = "POST"
}

protocol EndPointType{
    
    var path: String {get}
    var baseURL: String {get}
    var url: URL? {get}
    
    var methods: HTTPMethods {get}
    var body: Codable? {get}
    var header: [String:String]? {get}
}
