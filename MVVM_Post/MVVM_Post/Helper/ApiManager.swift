//
//  ApiManager.swift
//  MVVM_Post
//
//  Created by Adarsh Singh on 17/09/23.
//

import Foundation

enum DataError:Error{
    
    case invalidResponse
    case invalidUrl
    case invalidData
    case network(Error?)
}
typealias Helper<T> = (Result<T,DataError>)->Void
class ApiManager{
    
    static let shared = ApiManager()
    init(){}
    
    func fetchData<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        
        completionHandler: @escaping Helper<T>){
            
            guard let url = type.url else {
                completionHandler(.failure(.invalidUrl))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = type.methods.rawValue
            
            if let parameters = type.body{
                
                request.httpBody = try? JSONEncoder().encode(parameters).description.data(using: .utf8)
            }
            
            request.allHTTPHeaderFields = type.header
            
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data, error == nil else{
                    completionHandler(.failure(.invalidData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      200...299 ~= response.statusCode else{
                    completionHandler(.failure(.invalidResponse))
                    return
                }
                
                do{
                    let sampleData = try JSONDecoder().decode(modelType, from: data)
                    completionHandler(.success(sampleData))
                }catch{
                    completionHandler(.failure(.network(error)))
                }
                
            }.resume()
        
    }
    static var commonHeader: [String:String]{
        return [
            "Content-Type": "application/json; charset=UTF-8"
        
        ]
    }
}
