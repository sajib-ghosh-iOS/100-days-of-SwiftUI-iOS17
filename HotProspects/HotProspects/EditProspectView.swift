//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Sajib Ghosh on 13/05/24.
//

import SwiftUI
import SwiftData

struct EditProspectView: View {
    @Bindable var prospect: Prospect
    var body: some View {
        Form{
            TextField("Name", text: $prospect.name)
            TextField("Email", text: $prospect.emailAddress)
            DatePicker("Join Date", selection: $prospect.joinDate)
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditProspectView(prospect: Prospect(name: "", emailAddress: "", isContacted: true, joinDate: .now))
}
