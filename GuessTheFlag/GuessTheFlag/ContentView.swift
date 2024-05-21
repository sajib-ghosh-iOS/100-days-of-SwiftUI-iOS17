//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sajib Ghosh on 14/08/23.
//

import SwiftUI

struct Title: ViewModifier{
    func body(content: Content) -> some View {
        content.font(.largeTitle.weight(.bold)).foregroundColor(.blue)
    }
}

extension View{
    func titleStyle() -> some View {
        modifier(Title())
    }
}
struct FlagImage: View {
    var country: String
    var body: some View{
        Image(country).renderingMode(.original).clipShape(Capsule()).shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]

    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var animationAmount = 0.0
    @State private var flagTapped: Int? = nil
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],center: .top,startRadius: 200,endRadius: 700).ignoresSafeArea()
            VStack {
//                Text("Guess the Flag")
//                    .font(.largeTitle.weight(.bold))
//                    .foregroundColor(.white)
                Text("Guess the Flag")
                    .titleStyle()

                VStack(spacing:15){
                    VStack{
                        Text("Tap the flag of").foregroundColor(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).foregroundColor(.white).font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }label: {
                            //Image(countries[number]).renderingMode(.original).clipShape(Capsule()).shadow(radius: 5)
                            FlagImage(country: countries[number])
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        .rotation3DEffect((flagTapped == number) ? .degrees(animationAmount) : .degrees(0), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .opacity(flagTapped != nil && flagTapped != number ? 0.25 : 1.0)
                            .scaleEffect(flagTapped != nil && flagTapped != number ? 0.5 : 1)
                        
                        
                    }
                    
                    
                }.alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                }message: {
                    Text("Your score is: \(totalScore)")
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(totalScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            
        }
    }
    
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            totalScore+=1;
        }else{
            scoreTitle = "Wrong"
        }
        showingScore = true
        flagTapped = number
        withAnimation {
            animationAmount = 360
        }
    }
    
    func askQuestion(){
        flagTapped = nil
        animationAmount = 0.0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
