//
//  Order.swift
//  CupcakeCorner
//
//  Created by Sajib Ghosh on 08/01/24.
//

import Foundation
@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
    }

    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var address: Address?
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        cost += Decimal(type) / 2
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}
@Observable
class Address: Codable {
    
    var name = ""{
        didSet{
            saveAddress()
        }
    }
    var streetAddress = ""{
        didSet{
            saveAddress()
        }
    }
    var city = ""{
        didSet{
            saveAddress()
        }
    }
    var zip = ""{
        didSet{
            saveAddress()
        }
    }
    
    func saveAddress() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "Address")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    var isValidAddress: Bool{
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
}

class SavedAddress {
    var address = Address(){
        didSet{
            if let encoded = try? JSONEncoder().encode(address) {
                UserDefaults.standard.set(encoded, forKey: "Address")
            }
        }
    }
    
    init() {
        if let savedAddress = UserDefaults.standard.data(forKey: "Address") {
            if let decodedAddress = try? JSONDecoder().decode(Address.self, from: savedAddress){
                address = decodedAddress
                return
            }
        }
        address = Address()
    }
    
}
