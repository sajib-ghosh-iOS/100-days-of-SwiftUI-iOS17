//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Sajib Ghosh on 20/08/23.
//

import SwiftUI


//struct CapsuleText: View{
//    var body: some View{
//        .foregroundStyle(.white)
//        .background(.blue)
//        .clipShape(.capsule)
//    }
//}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
                .background(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State var useRedText = false
    @ViewBuilder var spells: some View{
        Text("c").modifier(Title())
        Text("d").titleStyle()
    }
    var body: some View {
        let a = Text("a")
        let b = Text("b")
        VStack{
            a
            b
            spells
        }.font(.title)
            .padding().blur(radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
