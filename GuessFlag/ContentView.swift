//
//  ContentView.swift
//  GuessFlag
//
//  Created by Vladislav Sosiuk on 26.10.2019.
//  Copyright © 2019 vlados. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = Countries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var questionsAsked = 0
    @State private var score = 0
    
    @State private var hideIncorrectFlags = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer].name)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                ForEach(0..<3) { number in
                    FlagButton(imageName: self.countries[number].name,
                               animation: number == self.correctAnswer ? .spin : .shake,
                               willAnimate: {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    self.hideIncorrectFlags = true
                                }
                    }) {
                        self.flagTapped(number)
                    }
                    .opacity(number != self.correctAnswer && self.hideIncorrectFlags ? 0.25 : 1.0)
                }
                Spacer()
            }
        }
        .alert(isPresented: self.$showingAlert) {
            Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
    
    private func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            alertTitle = "Correct"
            score += 1
        }
        else {
            alertTitle = "Wrong"
            score -= 1
        }
        alertMessage = "Your score is \(score)"
        
        if questionsAsked % 10 == 0 {
            alertTitle = score > 0 ? "Win" : "Loose"
            score = 0
        }
        
        showingAlert = true
    }
    
    private func askQuestion() {
        withAnimation(nil) {
            hideIncorrectFlags = false
        }
        countries = Countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        questionsAsked += 1
    }
    
    private func reset() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
