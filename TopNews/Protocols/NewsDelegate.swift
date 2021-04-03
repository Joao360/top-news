//
//  NewsDelegate.swift
//  TopNews
//
//  Created by João Graça on 03/04/2021.
//

import Foundation

protocol NewsDelegate{
    // Articles to be shown on the table view
    var articles: [Article] { get set }
    // Used to fetch the next page
    var category: Category? { get }
    // Used to retrieve articles according to the page
    func fetchArticles(page: Int, completionHandler: @escaping (String?, [Article]?) -> Void)
}
