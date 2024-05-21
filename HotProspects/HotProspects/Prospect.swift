//
//  Prospect.swift
//  HotProspects
//
//  Created by Sajib Ghosh on 12/05/24.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var joinDate: Date
    init(name: String, emailAddress: String, isContacted: Bool, joinDate: Date) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.joinDate = joinDate
    }
}
