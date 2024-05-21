//
//  ContentView.swift
//  Flashzilla
//
//  Created by Sajib Ghosh on 13/05/24.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}
struct ContentView: View {
    /*
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    // whether it is currently being dragged or not
    @State private var isDragging = false
    */
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @State private var cards = [Card]()
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    var body: some View {
        /*
         Text("Hello world")
         .onLongPressGesture(minimumDuration: 2) {
         print("Long pressed!")
         } onPressingChanged: { progress in
         print("Progress: \(progress)")
         }
         
         Text("Hello, World!")
         .scaleEffect(finalAmount + currentAmount)
         .gesture(
         MagnifyGesture()
         .onChanged { value in
         currentAmount = value.magnification - 1
         }
         .onEnded { value in
         finalAmount += currentAmount
         currentAmount = 0
         }
         )
         
         let dragGesture = DragGesture()
         .onChanged { value in offset = value.translation }
         .onEnded { _ in
         withAnimation {
         offset = .zero
         isDragging = false
         }
         }
         
         // a long press gesture that enables isDragging
         let pressGesture = LongPressGesture()
         .onEnded { value in
         withAnimation {
         isDragging = true
         }
         }
         
         // a combined gesture that forces the user to long press then drag
         let combined = pressGesture.sequenced(before: dragGesture)
         
         // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
         Circle()
         .fill(.red)
         .frame(width: 64, height: 64)
         .scaleEffect(isDragging ? 1.5 : 1)
         .offset(offset)
         .gesture(combined)
         
         ZStack {
         Rectangle()
         .fill(.blue)
         .frame(width: 300, height: 300)
         .onTapGesture {
         print("Rectangle tapped!")
         }
         
         Circle()
         .fill(.red)
         .frame(width: 300, height: 300)
         .onTapGesture {
         print("Circle tapped!")
         }
         //.allowsHitTesting(false)
         }
         
         VStack {
         Text("Hello")
         Spacer().frame(height: 100)
         Text("World")
         }
         //.contentShape(.rect)
         .onTapGesture {
         print("VStack tapped!")
         }
         */
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                print("removeCard...:\(index)")
                                removeCard(at: index)
                            }
                        } pushCard: {
                            withAnimation {
                                print("pushcard...:\(index)")
                                pushCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                }
                .foregroundStyle(.white)
                .font(.largeTitle)
                .padding()
                
            }
        }
        .onReceive(timer){ time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        .onAppear(perform: resetCards)

    }
    
    func removeCard(at index: Int) {
        print("removeCard///")
        guard index >= 0 else { return }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func pushCard(at index: Int) {
        let lastCard = cards.last
        cards.remove(at: index)
        cards.insert(lastCard!, at: 0)
        print("Total cards: \(cards.count)")
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}

#Preview {
    ContentView()
}
