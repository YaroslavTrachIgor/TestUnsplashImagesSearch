//
//  ImageAPIResult.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import Foundation

final class ImageAPIResponse: Codable {
    var total: Int!
    var total_pages: Int!
    var results: [ImageAPIResult]
    
    init(total: Int!, total_pages: Int!, results: [ImageAPIResult]) {
        self.total = total
        self.total_pages = total_pages
        self.results = results
    }
}

final class ImageAPIResult: Codable {
    let id: String!
    let created_at: String!
    let urls: ImageAPIURLs!
    let user: User!
    
    init(id: String!, created_at: String!, user: User!, urls: ImageAPIURLs) {
        self.id = id
        self.urls = urls
        self.user = user
        self.created_at = created_at
    }
}

final class ImageAPIURLs: Codable {
    let full: String!
    let regular: String!
    
    init(full: String!, regular: String!) {
        self.full = full
        self.regular = regular
    }
}

final class User: Codable {
    let name: String!
    let username: String!
    
    init(name: String!, username: String!) {
        self.name = name
        self.username = username
    }
}

final class FavouriteImage: Codable {
    let name: String!
    let username: String!
    let stringURL: String!
    let dateString: String!
    
    init(name: String!,
         username: String!,
         stringURL: String!,
         dateString: String!) {
        self.name = name
        self.username = username
        self.stringURL = stringURL
        self.dateString = dateString
    }
}
