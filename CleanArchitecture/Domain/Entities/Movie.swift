//
//  Movie.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 14/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
    var totalResults: String
    var movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "totalResults"
        case movies = "Search"
    }
}

struct Movie: Codable {
    var year: String
    var type: String
    var title: String
    var imdbID: String
    var posterImage: String
    
    enum CodingKeys: String, CodingKey {
        case year = "Year"
        case type = "Type"
        case title = "Title"
        case imdbID = "imdbID"
        case posterImage = "Poster"
    }
}