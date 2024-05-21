//
//  ContentView.swift
//  MoonShot
//
//  Created by Sajib Ghosh on 17/12/23.
//

import SwiftUI

struct CustomText: View{
    let text: String
    var body: some View{
        Text(text)
    }
    init(text: String) {
        print("Creating custom text :\(text)")
        self.text = text
    }
}

struct User: Codable{
    let name: String
    let address: Address
}
struct Address: Codable{
    let street: String
    let city: String
}
struct ContentView: View {
    
    let layout = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    let layout1 = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions : [Mission] = Bundle.main.decode("missions.json")
    
    
    @State private var isList = false

    var body: some View {

//        Image(.armstrong)
//            .resizable().scaledToFit()
//            .containerRelativeFrame(.horizontal){size,axis in
//                size*0.5
//            }
        /*
        ScrollView{
            LazyVStack(spacing: 10){
                ForEach(0..<100){
                    CustomText(text: "item: \($0)").font(.title)
                }
            }.frame(maxWidth: .infinity)
        }
         */
        /*
        NavigationStack{
//            NavigationLink{
//                Text("Detail View")
//            }label: {
//                VStack{
//                    Text("New Text")
//                    Text("New Text1")
//                    Image(systemName: "face.smiling")
//                }
//                
//            }
            /*
            List(0..<100){ row in
                NavigationLink("Row \(row)"){
                    Text("Detail row: \(row)")
                }
            }
                .navigationTitle("SwiftUI")
             */
            /*
            Button("Decode JSON"){
                let input = """
                            {
                            "name": "Sajib Ghosh",
                            "address": {
                                "street": "Rabindrapally",
                                "city": "Kestopur"
                            }
                            }
                            """
                
                let data = Data(input.utf8)
                if let user = try? JSONDecoder().decode(User.self, from: data) {
                    print(user.name)
                    print(user.address.street)
                }
            }
            */
            /*
            ScrollView{
                LazyVGrid(columns: layout1, content: {
                    ForEach(0..<100){
                        Text("\($0)")
                    }
                })
            }
             */
            ScrollView(.horizontal){
                LazyHGrid(rows: layout1, content: {
                    ForEach(0..<100){
                        Text("\($0)")
                    }
                })
            }
        }
         */
        
        NavigationStack{
            Group{
                if isList {
                    ListLayout(astronauts: astronauts, missions: missions)
                }else{
                    GridLayout(astronauts: astronauts, missions: missions)
                }
            }.navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar{
                    Button(isList ? "Show Grid" : "Show List"){
                        isList.toggle()
                    }.foregroundStyle(.white)
                }
        }
    }
}

#Preview {
    ContentView()
}
