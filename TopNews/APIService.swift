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
            URLQueryItem(name: "country", value: countryCode ?? "us"),
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "pageSize", value: String(pageSize)),
            URLQueryItem(name: "page", value: String(page)),
            apiKeyQueryItem,
        ]
        
        var urlComponents = URLComponents(string: apiUrl + "/top-headlines")!
        urlComponents.queryItems = queryItems
        
        let url = urlComponents.url!
        
        let _ = fetchDataFrom(url: url) { error, data in
            if let data = data {
                do {
                    let topHeadlines = try JSONDecoder().decode(NewsListResponse.self, from: data)
                    print("Received \(topHeadlines.totalResults) new articles")
                    completionHandler(nil, topHeadlines.articles)
                } catch {
                    print(error)
                    completionHandler(error.localizedDescription, nil)
                }
            }
        }
    }
    
    func fetchEverything(query: String, page: Int, completionHandler: @escaping (String?, [Article]?) -> Void) -> URLSessionDataTask {
        let queryItems = [
            URLQueryItem(name: "pageSize", value: String(pageSize)),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: String(page)),
            apiKeyQueryItem,
        ]
        
        var urlComponents = URLComponents(string: apiUrl + "/everything")!
        urlComponents.queryItems = queryItems
        
        let url = urlComponents.url!
        
        return fetchDataFrom(url: url) { error, data in
            if let data = data {
                do {
                    let topHeadlines = try JSONDecoder().decode(NewsListResponse.self, from: data)
                    print("Received \(topHeadlines.totalResults) new articles")
                    completionHandler(nil, topHeadlines.articles)
                } catch {
                    print(error)
                    completionHandler(error.localizedDescription, nil)
                }
            }
        }
    }
    
    func fetchDataFrom(url: URL, completionHandler: @escaping (String?, Data?) -> Void) -> URLSessionDataTask {
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
                completionHandler(nil, data)
            } else {
                completionHandler(nil, nil)
            }
        }
        
        task.resume()
        return task
    }
}
