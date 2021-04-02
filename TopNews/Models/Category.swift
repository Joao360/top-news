//
//  Category.swift
//  TopNews
//
//  Created by João Graça on 02/04/2021.
//

import Foundation

struct Category {
    var name: String
    var apiParameter: String
}

let DEFAULT_CATEGORIES: [Category] = [
    Category(name: "Business", apiParameter: "business"),
    Category(name: "Entertainment", apiParameter: "entertainment"),
    Category(name: "General", apiParameter: "general"),
    Category(name: "Health", apiParameter: "health"),
    Category(name: "Science", apiParameter: "science"),
    Category(name: "Sports", apiParameter: "sports"),
    Category(name: "Technology", apiParameter: "technology")
]
