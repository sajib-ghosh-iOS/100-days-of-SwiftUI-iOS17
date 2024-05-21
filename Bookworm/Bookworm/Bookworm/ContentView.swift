//
//  ContentView.swift
//  Bookworm
//
//  Created by Sajib Ghosh on 10/01/24.
//
import SwiftData
import SwiftUI

struct PushButton: View{
    var title: String
    @Binding var isOn: Bool
    var onColors = [Color.red, Color.green]
    var offColors = [Color(white:0.3), Color(white:0.9)]
    
    var body : some View {
        Button(title){
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
    
}
struct ContentView: View {
    @State private var rememberMe = false
    @AppStorage("notes") private var notes = ""
    @Query var students : [Student]
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.rating,order: .reverse),
        SortDescriptor(\Book.title)
    ]) var books: [Book]
    @State private var showingAdScreen = false
    var body: some View {
        
        NavigationStack{
            List{
                ForEach(books) { book in
                    NavigationLink(value: book){
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                        }
                        VStack(alignment: .leading){
                            Text(book.title)
                                .font(.headline)
                                .foregroundStyle((book.rating == 1) ? .red : .black)
                            Text(book.author)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
                .navigationDestination(for: Book.self, destination: { book in
                    DetailView(book: book)
                })
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAdScreen.toggle()
                        }
                    }
                }.sheet(isPresented: $showingAdScreen, content: {
                    AddBookView()
                })
        }
        /*
        NavigationStack{
            List(students){ student in
                Text(student.name)
            }
            .navigationTitle("Students")
            .toolbar {
                Button("Add"){
                    let firstNames = ["Sajib","Laboni","Tojo","Ghonto"]
                    let lastNames = ["Ghosh","Bagchi","Pal","Debnath"]
                    let randomFirstName = firstNames.randomElement()!
                    let randomLastName = lastNames.randomElement()!
                    let student = Student(id: UUID(), name: "\(randomFirstName) \(randomLastName)")
                    modelContext.insert(student)
                }
            }
        }
         */
        /*
        VStack {
            PushButton(title: "Remember me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
        .padding()
         */
        /*
        NavigationStack{
//            Form{
//                TextEditor(text: $notes)
//                
//            }
            TextField("Enter your text", text: $notes,axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
        }
         */
        
    }
    
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
