//
//  ContentView.swift
//  Practice3
//
//  Created by Sajib Ghosh on 10/12/23.
//

import SwiftUI

struct Question{
    let id: Int
    let firstNumber: Int
    let secondNumber: Int
    let question: String
    let answer: Int
}

struct ContentView: View {
    @State private var table = 2
    let noOfQuestions = [5,10,20]
    @State private var noOfQuestion = 0
    @State private var arrayOfQuestions = [Question]()
    @State private var answer = ""
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var currentQues = 0
    @State private var isQuestionsReady = false
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        }

    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ],center: .top,startRadius: 200,endRadius: 400).ignoresSafeArea()
                if noOfQuestion == 0 {
                    VStack(alignment: .center, spacing: 10){
                        Text("Which multiplication table you want to practice?").foregroundColor(.white).font(.title)
                        Stepper("\(table) table", value: $table,in: 2...12, step: 1).padding(20).foregroundColor(.white).font(.title)
                        Text("How many questions you want to be asked?").foregroundColor(.white).font(.title)
                        HStack{
                            ForEach(0..<noOfQuestions.count,id: \.self){ num in
                                Button("\(noOfQuestions[num])") {
                                    noOfQuestionsTapped(num: num)
                                }.padding(20)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .font(.largeTitle.weight(.bold)).foregroundColor(.white).background(.green).clipShape(Capsule())
                            }
                        }
                    }
                }else{
                    if isQuestionsReady {
                        VStack{
                            if currentQues < arrayOfQuestions.count {
                                let question = arrayOfQuestions[currentQues]
                                let ques = "Q\(question.id + 1). " + question.question
                                Text(ques).foregroundColor(.white).font(.title)
                                TextField("Enter your Answer", text: $answer).foregroundColor(.white).keyboardType(.numberPad).onSubmit {
                                    let correctAnswer = question.answer
                                    answerSubmitted(correctAnswer: correctAnswer, answerEntered: Int(answer) ?? 0)
                                }
                            }else{
                                Text((currentQues == arrayOfQuestions.count) ? "Score: \(totalScore)" : "")
                                    .foregroundColor(.white)
                                    .font(.title.bold())
                            }
                            
                        }
                    }
                }
            }.navigationTitle("Multiplication").toolbar(content: {
                Button((noOfQuestion != 0) ? "Restart" : "", action: restartGame)
            }).tint(.white).font(.title)
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                }message: {
                    Text("Your score is: \(totalScore)")
                }
        }
        
    }
    
    func restartGame() {
        withAnimation {
            noOfQuestion = 0
        }
        currentQues = 0
        totalScore = 0
        arrayOfQuestions.removeAll()
    }
    
    func noOfQuestionsTapped(num: Int){
        withAnimation {
            noOfQuestion = noOfQuestions[num]
        }
        print("noOfQuestion:\(noOfQuestion)")
        generateQuestions()
    }
    
    func generateQuestions() {
        for count in 0..<noOfQuestion{
            let id = count
            let firstNumber = table
            var secondNumber = Int.random(in: 2...12)
            var ifExists = false
            
            while ifExists {
                secondNumber = Int.random(in: 2...12)
                if let _ = arrayOfQuestions.filter{$0.secondNumber == secondNumber}.first {
                    ifExists = true
                }
            }
            let question = "What is the value of \(firstNumber) X \(secondNumber)?"
            let answer = firstNumber * secondNumber
            let ques = Question(id: id, firstNumber: firstNumber, secondNumber: secondNumber, question: question, answer: answer)
            arrayOfQuestions.append(ques)
        }
        isQuestionsReady = true
    }
    
    func answerSubmitted(correctAnswer: Int, answerEntered: Int){
        if correctAnswer == answerEntered {
            totalScore += 1
            scoreTitle = "Right"
        }else{
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion() {
        answer = ""
        if currentQues < arrayOfQuestions.count {
            currentQues += 1
        }else{
            showingScore = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
