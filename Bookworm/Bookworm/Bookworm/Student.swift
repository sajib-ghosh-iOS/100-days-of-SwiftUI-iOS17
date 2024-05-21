//
//  Student.swift
//  Bookworm
//
//  Created by Sajib Ghosh on 10/01/24.
//

import SwiftData
import Foundation

@Model
class Student{
    let id: UUID
    let name: String
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
