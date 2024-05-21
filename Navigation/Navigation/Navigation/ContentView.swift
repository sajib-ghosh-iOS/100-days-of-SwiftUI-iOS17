//
//  ContentView.swift
//  Navigation
//
//  Created by Sajib Ghosh on 27/12/23.
//

import SwiftUI

@Observable
class PathStore{
    var path : NavigationPath {
        didSet{
            save()
        }
    }
    
    let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath){
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data){
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        do{
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        }catch{
            print("Failed to save navigation data")
        }
    }
}

struct Student: Hashable {
    let id = UUID()
    let name: String
}

struct DetailView: View {
    var number: Int
    @Binding var path: NavigationPath
    var body: some View {
        NavigationLink("Go to Random Number",value: Int.random(in: 0...1000)).navigationTitle("Number: \(number)")
            .toolbar{
                Button("Home"){
                    //path.removeAll()
                    path = NavigationPath()
                }
            }
    }
}

struct ContentView: View {
    @State private var title = "SwiftUI"
    //@State private var path = [Int]()
    @State private var pathStore = PathStore()
    var body: some View {
        /*
        NavigationStack{
            List(0..<100){ i in
                NavigationLink("Select \(i)",value: i)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected: \(selection)")
                    .navigationDestination(for: Student.self) { student in
                        Text("You selected: \(student.name)")
                    }
            }
        }
         */
        /*
        NavigationStack(path: $path){
            VStack{
                Button("Show 32"){
                    path = [32]
                }
                Button("Show 64"){
                    path.append(64)
                }
                Button("Show 32 then 64"){
                    path = [32,64]
                }
            }.navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
        */
        /*
        NavigationStack(path: $path){
            List{
                ForEach(0..<5){ i in
                    NavigationLink("Select number: \(i)",value: i)
                }
                ForEach(0..<5){ i in
                    NavigationLink("Select String: \(i)",value: String(i))
                }
                }.toolbar{
                    Button("Push 556"){
                        path.append(556)
                    }
                    Button("Push hello"){
                        path.append("hello")
                    }
            }.navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }.navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
        }
        */
        /*
        NavigationStack(path: $pathStore.path){
            DetailView(number: 0, path: $pathStore.path).navigationDestination(for: Int.self) { i in
                DetailView(number: i, path: $pathStore.path)
            }
        }
         */
        
        NavigationStack{
            List(0..<100){ i in
                Text("Row: \(i)")
            }.toolbar{
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Tap me"){
                        
                    }
                    Button("Or Tap me"){
                        
                    }
                }
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Or Tap me"){
//                        
//                    }
//                }
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue, for: .navigationBar)
            .toolbarColorScheme(.dark)
            //.toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
