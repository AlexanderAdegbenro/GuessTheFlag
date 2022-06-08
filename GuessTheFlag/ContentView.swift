//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alexander Adgebenro on 6/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var questionCounter = 1
    @State private var showingScore = false
    @State private var showingResults = false
    @State private var ScoreTitle = ""
    @State private var scoreCounter = 0
    
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    static let allCountries = ["Estonia", "France" , "Germany" , "ireland" , "Italy" , "Nigeria" , "Poland" , "Russia" , "Spain" , "UK" , "USA"]
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            //            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom )
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                // or thinMaterial
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreCounter) ")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(ScoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreCounter) ")
        }
        
        .alert("Game over", isPresented: $showingResults){
            Button("Start Again", action: newGame)
        } message: {
            Text("Your `final score was \(scoreCounter) ")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            ScoreTitle = "Correct"
            scoreCounter += 1
        } else {
            
            let needsThe = ["UK, US"]
            let theirAnswer = countries[number]
            
            if needsThe.contains(theirAnswer) {
                ScoreTitle = "Wrong That was the flag of  \(theirAnswer)."
            } else {
                ScoreTitle = "Wrong! thats the flag of \(theirAnswer)"
            }
            
            if scoreCounter > 0 {
                scoreCounter -= 1
            }
            
        }
        
        if questionCounter == 8 {
            showingResults = true
        } else {
            showingScore = true
        }
    }
    
    
    func askQuestion() {
        countries.remove(at: correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func newGame() {
        questionCounter = 0
        scoreCounter = 0
        countries = Self.allCountries
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
