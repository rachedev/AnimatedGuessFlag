//
//  ContentView.swift
//  AnimatedGuessFlag
//
//  Created by RachelleLee on 8/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var wrong = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)

                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        if number == correctAnswer {
                            withAnimation() {
                                self.animationAmount += 360
                                self.enabled = true
                                self.flagTapped(number)
                            }
                            
                        } else {
                            withAnimation() {
                                self.animationAmount += 0
                                self.enabled = false
                                self.flagTapped(number)
                                self.wrong = true
                                }
                            }
                    }) {
                        if number == correctAnswer {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                        } else {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                                .opacity(enabled ? 0.25 : 1)
                        }
                    }
                }
                Spacer()
            }
        }
//        .alert(isPresented: $showingScore) {
//            Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Continue")) {
//                self.askQuestion()
//            })
//        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
