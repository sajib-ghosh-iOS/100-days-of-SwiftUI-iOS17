//
//  ContentView.swift
//  Animation
//
//  Created by Sajib Ghosh on 07/12/23.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier{
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0,anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    let letters = Array("SAJIB GHOSH")
    
    
    var body: some View {
        Button("Tap me") {
            animationAmount += 1
        }.padding(50.0)
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(50)
            .scaleEffect(animationAmount)
            .blur(radius: (animationAmount - 1) * 3)
            //.animation(.easeInOut(duration: 1).repeatForever(), value: animationAmount)
            //.animation(.easeIn.repeatForever(), value: animationAmount)
        /*
         Button("Tap me") {
         animationAmount += 1
         }.padding(50.0)
         .background(.red)
         .foregroundColor(.white)
         .cornerRadius(50)
         //                .scaleEffect(animationAmount)
         //                .blur(radius: (animationAmount - 1) * 3)
         //                .animation(.easeInOut(duration: 1).repeatForever(), value: animationAmount)
         .overlay(
         Circle()
         .stroke(.red)
         .scaleEffect(animationAmount)
         .opacity(2 - animationAmount)
         .animation(
         .easeOut(duration: 1)
         .repeatForever(autoreverses: false),
         value: animationAmount
         )
         ).onAppear {
         animationAmount = 2
         }
         */
        
        /*
         Stepper("Scale amount", value: $animationAmount.animation(
         .easeInOut(duration: 1)
         .repeatCount(3, autoreverses: true)
         ), in: 1...10)
         Spacer()
         Button("Tap me") {
         //animationAmount += 1
         }.padding(40)
         .background(.red)
         .foregroundColor(.white)
         .cornerRadius(40)
         .scaleEffect(animationAmount)
         */
        /*
         Button("Tap me") {
         withAnimation(.spring(response: 1.0, dampingFraction: 0.5, blendDuration: 0.5)) {
         animationAmount += 360
         }
         }.padding(40)
         .background(.red)
         .foregroundColor(.white)
         .cornerRadius(160)
         .rotation3DEffect(.degrees(animationAmount), axis: (x: 0.0, y: 1.0, z: 0.0))
         */
        /*
         Button("Tap me") {
         enabled.toggle()
         }.frame(width: 200, height: 200, alignment: .center)
         .background(enabled ? .red : .blue)
         .foregroundColor(.white)
         .animation(.default, value: enabled)
         */
        /*
         LinearGradient(colors: [.yellow,.red], startPoint: .topLeading, endPoint: .bottom)
         .frame(width: 300, height: 300, alignment: .center)
         .cornerRadius(10)
         .offset(dragAmount)
         .gesture(
         DragGesture()
         .onChanged({ value in
         dragAmount = value.translation
         })
         .onEnded({ _ in
         dragAmount = .zero
         })
         )
         .animation(.spring(), value: dragAmount)
         */
        /*
         HStack{
         ForEach(0..<letters.count, id: \.self) { num in
         Text(String(letters[num]))
         .padding(5)
         .font(.caption)
         .background(enabled ? .red : .blue)
         .foregroundColor(.white)
         .offset(dragAmount)
         .animation(.linear.delay(Double(num)/20), value: dragAmount)
         }
         }.gesture(
         DragGesture()
         .onChanged({ value in
         dragAmount = value.translation
         })
         .onEnded({ _ in
         dragAmount = .zero
         enabled.toggle()
         })
         )
         */
        /*
         VStack{
         Button("Tap me"){
         withAnimation {
         enabled.toggle()
         }
         }
         if enabled {
         Rectangle()
         .fill(.red)
         .frame(width: 200, height: 200, alignment: .center)
         //.transition(.scale)
         .transition(.asymmetric(insertion: .scale, removal: .opacity))
         
         }
         }
         */
        
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200, alignment: .center)
            if enabled {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200, alignment: .center)
                    .transition(.pivot)
            }
        }.onTapGesture {
            withAnimation {
                enabled.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
