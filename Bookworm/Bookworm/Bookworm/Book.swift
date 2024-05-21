//
//  Book.swift
//  Bookworm
//
//  Created by Sajib Ghosh on 10/01/24.
//

import SwiftData
import Foundation

@Model
class Book{
    let title: String
    let author: String
    let genre: String
    let review: String
    let rating: Int
    let date = Date.now
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
    
}
