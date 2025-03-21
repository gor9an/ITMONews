//
//  News.swift
//  NewsApp
//
//  Created by Andrey Gordienko on 21.03.2025.
//

import Foundation

struct Articles: Codable {
    let articles: [News]
}

struct News: Codable {
    let title: String?
    let description: String?
    let urlToImage: URL?
}
