//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Sajib Ghosh on 08/01/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    @State private var address = Address()
    @State private var isTapped = false
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $address.name)
                TextField("Street Address", text: $address.streetAddress)
                TextField("City", text: $address.city)
                TextField("Zip", text: $address.zip)
            }
            Section{
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
            }.onAppear(perform: {
                getAddress()
            })
            .disabled(address.isValidAddress == false)
        }.navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func getAddress() {
        if let addrss = order.address{
            address = addrss
        }else{
            if let savedAddress = UserDefaults.standard.data(forKey: "Address") {
                if let decodedAddress = try? JSONDecoder().decode(Address.self, from: savedAddress){
                    address = decodedAddress
                    return
                }
            }
            address = Address()
        }
    }
}

#Preview {
    AddressView(order: Order())
}
