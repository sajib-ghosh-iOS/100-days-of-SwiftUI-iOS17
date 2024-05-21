//
//  RectangleDividerView.swift
//  MoonShot
//
//  Created by Sajib Ghosh on 25/12/23.
//

import SwiftUI

struct RectangleDividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    RectangleDividerView()
}
