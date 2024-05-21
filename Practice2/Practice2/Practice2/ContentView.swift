//
//  ContentView.swift
//  Practice2
//
//  Created by Sajib Ghosh on 01/12/23.
//

import SwiftUI

struct FontModifier: ViewModifier{
    func body(content: Content) -> some View {
        content.font(.system(size: 50))
    }
}
extension View{
    func font() -> some View {
        modifier(FontModifier())
    }
}
struct ContentView: View {
    @State private var moves = ["Rock","Paper","Scissors"]
    @State private var currentMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var count = 0
    @State private var score = 0
    @State private var isGameOver = false
    var body: some View {
        ZStack{
            RadialGradient(colors: [.purple,.accentColor], center: .center, startRadius: 200, endRadius: 700).ignoresSafeArea()
            VStack(spacing:20){
                Spacer()
                Text(moves[currentMove]).foregroundColor(.red).font()
                Text(shouldWin ? "Win" : "Lose").foregroundColor(.red).font()
                Spacer()
                ForEach(0..<3){ number in
                    Button {
                        count = count + 1
                        calculateScore(number: number)
                        if count < 10 {
                            askQuestion()
                        }else{
                            isGameOver = true
                        }
                    } label: {
                        Text(moves[number]).padding().foregroundColor(.white).font().background(.blue)
                    }.clipShape(Capsule()).shadow(radius: 5)
                    
                }.alert("Game Over!", isPresented: $isGameOver) {
                    Button("OK", action: resetGame)
                }message: {
                    Text("Your score is: \(score)")
                }
                
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font()
                Spacer()
            }

        }
    }
    
    func calculateScore(number: Int){
        if (shouldWin) {
            if (currentMove == 0 && number == 1) || (currentMove == 1 && number == 2) || (currentMove == 2 && number == 0) {
                score = score + 1
            }
        }else {
            if (currentMove == 0 && number == 2) || (currentMove == 1 && number == 0) || (currentMove == 2 && number == 1) {
                score = score + 1
            }
        }
    }
    
    func askQuestion() {
        currentMove = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func resetGame() {
        currentMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        count = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
