//
//  Movie.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 14/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation

protocol ErrorType {
    var error: String? { get }
    var response: String? { get }
}

struct MovieResponse: Codable, ErrorType {
    var totalResults: String?
    var movies: [Movie]? = []
    var error: String?
    var response: String?
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "totalResults"
        case movies = "Search"
        case error = "Error"
        case response = "Response"
    }
}

struct Movie: Codable {
    var year: String
    var type: String
    var title: String
    var imdbID: String
    var poster: String?
    var posterImage: String? {
        get {
            if poster == "N/A" {
                return nil
            } else {
                return poster
            }
        }
        set {
            poster = newValue
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case year = "Year"
        case type = "Type"
        case title = "Title"
        case imdbID = "imdbID"
        case poster = "Poster"
    }
}
