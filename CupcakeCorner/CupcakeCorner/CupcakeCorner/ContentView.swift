//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Sajib Ghosh on 08/01/24.
//

import SwiftUI
import CoreHaptics

struct Response: Codable{
    var results: [Result]
}
struct Result: Codable{
    var trackId: Int
    var trackName: String
    var collectionName: String
}
@Observable
class User: Codable{
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    var name = "Sajib"
}

struct ContentView: View {
//    @State private var results = [Result]()
//    
//    @State private var email: String = ""
//    @State private var password: String = ""
//    
//    var formDisabled : Bool {
//        return email.count < 5 || password.count < 5
//    }
//    
//    @State private var counter = 0
//    @State private var engine: CHHapticEngine?
    
    @State private var order = Order()
    
    var body: some View {
        
        NavigationStack{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)

                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                NavigationLink("Delivery"){
                    AddressView(order: order)
                }
            }
        }.navigationTitle("Cupcake Corner")
        
        
        //Button("Encode user",action: encodeUser)
        /*
        Button("Tap count:\(counter)"){
           counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
        
        Button("Play haptic"){
            complexSuccess()
        }.onAppear(perform: prepareHaptics)
         */
        /*
        Form{
            Section{
                TextField("Email", text: $email)
                TextField("Password", text: $password)
            }
            Section{
                Button("Create Account"){
                    
                }
            }.disabled(formDisabled)
        }
         */
        
        /*
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ phase in
            if let image = phase.image{
                image.resizable().scaledToFit()
            }else if phase.error != nil {
                Text("There was an error loading the image")
            }else{
                ProgressView()
            }
        }
        .frame(width:200,height: 200)
        
        List(results, id: \.trackId){ item in
            VStack{
                Text(item.trackName).font(.headline)
                Text(item.collectionName)
            }
        }.task {
            await loadData()
        }
         */
    }
    
    func encodeUser(){
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
    /*
    func prepareHaptics(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do{
            engine = try CHHapticEngine()
            try engine?.start()
        }catch{
            print("There was an error creating haptic engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else{
            print("Invalid URL")
            return
        }
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                results = decodedResponse.results
            }
        }catch{
            print("INalid data")
        }
    }
    
    func loadImage() async {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ phase in
            if let image = phase.image{
                image.resizable().scaledToFit()
            }else if phase.error != nil {
                Text("There was an error loading the image")
            }else{
                ProgressView()
            }
        }
        .frame(width:200,height: 200)
        
    }
     */
}

#Preview {
    ContentView()
}
