//
//  APIManager.swift
//  WamaTest
//
//  Created by Prakash on 31/05/22.
//

import Foundation





class APIManager{
    let strURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=444ad0895ee94130972d070cead5fcb3"
    
    static let sharedInstance = APIManager()
    func getAPIResponse(completionHandler:@escaping((_ response:[Article]?,_ errorMesage:String?)->())){
        guard let url = URL(string: self.strURL) else {return}
        print(url)
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
              if let error = error {
                print("Error with fetching films: \(error)")
                  completionHandler(nil,error.localizedDescription)
                return
              }
              
              guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                  completionHandler(nil,"Error with the response, unexpected status code: \(response)")
                return
              }

              if let data = data,
                let response = try? JSONDecoder().decode(JSONResponse.self, from: data) {
                  if response.status == "ok"{
                  completionHandler(response.articles as! [Article],nil)
                  }
                  
              }else {
//                  print("Invalid Response")
                  completionHandler(nil,"Invalid Response")
              }
            })
            task.resume()
        
    }
}

// MARK: - Welcome
struct JSONResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
//    let source: Source
    let author: String
    let title: String
    let articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        articleDescription = try values.decodeIfPresent(String.self, forKey: .articleDescription) ?? ""
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        content = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
    }
}

//// MARK: - Source
//struct Source: Codable {
//    let id: String?
//    let name: String
//}
