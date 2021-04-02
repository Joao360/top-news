//
//  APIService.swift
//  TopNews
//
//  Created by João Graça on 02/04/2021.
//

import Foundation

struct APIService {
    var pageSize = 10
    
    private let apiUrl = "https://newsapi.org/v2"
    private let apiKeyQueryItem = URLQueryItem(name: "apiKey", value: "")
    
    func fetchTopHeadlinesFor(category: String, page: Int, completionHandler: @escaping (String?, [Article]?) -> Void) {
        let countryCode = Locale.current.regionCode
        
        let queryItems = [
            URLQueryItem(name: "country", value: countryCode),
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "pageSize", value: String(pageSize)),
            apiKeyQueryItem,
        ]
        
        var urlComponents = URLComponents(string: apiUrl + "/top-headlines")!
        urlComponents.queryItems = queryItems
        
        let url = urlComponents.url!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler("Error accessing api: \(error)", nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler("Error with the response, unexpected status code: \(String(describing: response))", nil)
                return
            }
            
            if let data = data {
                do {
                    let topHeadlines = try JSONDecoder().decode(TopHeadlinesResponse.self, from: data)
                    completionHandler(nil, topHeadlines.articles)
                } catch {
                    print(error)
                    completionHandler(error.localizedDescription, nil)
                }
            }
        }
        
        task.resume()
    }
}
