//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Sajib Ghosh on 10/05/24.
//

import Foundation
extension EditView {
    @Observable
    class ViewModel {
        var onSave: (Location) -> Void = { _ in }
        func save(location: Location) {
            onSave(location)
        }
        init() {
        }
    }
    
}
