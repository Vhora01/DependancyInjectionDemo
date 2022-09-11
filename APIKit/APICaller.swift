//
//  APICaller.swift
//  APIKit
//
//  Created by Prakash on 10/09/22.
//

import Foundation
import MyAppUIKit


//dependency injection
public class APICaller{
    public static let shared = APICaller()
    private init(){}
    
    
    public func fetchCources(completionHandler: @escaping ([String])->Void){
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            completionHandler([])
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {
                completionHandler([])
                return
            }
            
            do{
                guard let result = try JSONSerialization.jsonObject(with: data,options: []) as? [[String:String]] else {
                    completionHandler([])
                    return
                }
                let names : [String] = result.compactMap({$0["name"]})
                completionHandler(names)
            }catch{
                completionHandler([])
            }

        }
        task.resume()
    }
}


extension APICaller :DataFetchable {}
