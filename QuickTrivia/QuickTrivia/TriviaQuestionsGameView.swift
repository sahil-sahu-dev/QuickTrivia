//
//  ContentView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import SwiftUI



struct TriviaQuestionsGameView: View {
    
    @EnvironmentObject var triviaDocument: TriviaQuestionsGame
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var questionIndex: Int = 0
    @State var hasTappedOption = false
    @State var tappedAnswer: String = ""
    @State var wrongAnswer: Int = 0
    @State var currentScore: Int = 0
    
    var pinkColor:Color = Color(red: 255/255.0,green: 156/255.0, blue: 156/255.0)
    var yellowColor:Color = Color(red: 255/255.0,green: 235/255.0, blue: 161/255.0)
    var greenColor: Color = Color(red: 149/255.0, green: 218/255.0, blue: 193/255.0)
    var blackColor: Color = Color(red: 54/255.0, green: 54/255.0, blue: 54/255.0)
    var successEmojis = ["😎", "🥳", "👏", "🎉"]
    var failureEmojis = ["😓","😵‍💫","🤕","👿"]
    
    var body: some View {
        
        ZStack{
            yellowColor
                
            VStack{
                
                questionView
                    .padding()
                scoreView
                answersView
                    .padding()
                
                answerEmojiView
                    .opacity(hasTappedOption ? 1 : 0)
                    .font(.subheadline)
                    
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: home.padding(), trailing: toggleQuestion.padding())
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        
        
    }
    
    
    var answerEmojiView: some View {
        
        if questionIndex < triviaDocument.trivias.count && tappedAnswer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) {
            return Text("Correct Answer! \(successEmojis[ Int.random(in: 0..<3)])").foregroundColor(.init(red: 0, green: 156/255, blue: 23/255))
        }
        
        return Text("Wrong answer \(failureEmojis[ Int.random(in: 0..<3)])").foregroundColor(.red)
        
    }
    
    var scoreView: some View {
        Text("Score: \(currentScore)")
            .font(.subheadline)
    }
    
    var home : some View {
        Button(action: {
            self.mode.wrappedValue.dismiss()
        }) {
            Image(systemName: "house").foregroundColor(blackColor)
        }
        
    }
    
    
    var questionView: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: 320, maxHeight: 100)
                .foregroundColor(yellowColor)

            question
                .foregroundColor(blackColor)
                .frame(maxWidth: 320)
                .font(.title2)
            
        }
    }
    
    var question: some View {
        
        if(triviaDocument.trivias.count > questionIndex){
            return Text(triviaDocument.trivias[questionIndex].question)
                
        }
        
        return Text("")
    }
    
    
    var toggleQuestion: some View {
       
        Button("Next") {
            questionIndex += 1
            hasTappedOption = false
            tappedAnswer = ""
            wrongAnswer = 0
        }
        .opacity(questionIndex < triviaDocument.trivias.count ? 1 : 0)
        .foregroundColor(blackColor)
    }
    
    var blackLine: some View {
        Rectangle()
            .stroke(lineWidth: 5)
            .frame(width:500, height: 1)
            .foregroundColor(.black)

    }
    
    var answersView: some View {
        
        LazyVGrid(columns: [GridItem(.fixed(400))],spacing: 10){
            if(triviaDocument.trivias.count > questionIndex){
                ForEach(triviaDocument.trivias[questionIndex].answerOptions, id: \.self){answer in
                    ZStack{
                        
                        option
                            .onTapGesture {
                                //haptic feedback and changing state variable for the tapped options
                                tappedAnswer = hasTappedOption ? tappedAnswer : answer
                                hasTappedOption = true
                                withAnimation(.default) {
                                    wrongAnswer = !answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer)
                                        && answer.elementsEqual(tappedAnswer) ? wrongAnswer+1 : wrongAnswer
                                    
                                }
                                
                                
                                answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? HapticsManager.instance.notification(of: .success) : HapticsManager.instance.notification(of: .error)
                                currentScore = answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? currentScore
                                    + 1 : currentScore > 1 ? currentScore - 1 : currentScore
                            }
                            
                        
                        
                        .foregroundColor(!hasTappedOption ?
                                            blackColor : answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ?
                                            greenColor :  tappedAnswer.elementsEqual(answer)
                                            ? pinkColor : blackColor)
                            .animation(.easeIn(duration: 0.1))
                        
                        
                       // .modifier(tappedAnswer.elementsEqual(answer) && !tappedAnswer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer)
                                   // ? Shake(animatableData: CGFloat(wrongAnswer)) : Shake(animatableData: 0))
                        
                        
                        Text(answer)
                            .foregroundColor(!hasTappedOption ? .white : answer
                                                .elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? .black : answer.elementsEqual(tappedAnswer) ? .black : .white)
                            .padding()
                            .frame(maxWidth: 280)
                        
                        checkMark
                            .padding()
                            .opacity(hasTappedOption && answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? 1 : 0)
                            .offset(x: 120)
                        
                        xMark
                            .padding()
                            .opacity(hasTappedOption && !answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? 1 : 0)
                            .offset(x: 120)
                        
                    }
                    .foregroundColor(blackColor)
                }
            }
            
        }
    }
    
    
    var option: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(minWidth: 120, maxWidth: 300, minHeight: 70)
    }
    
    var checkMark: some View {
        Image(systemName: "checkmark.circle.fill")
    }
    
    var xMark: some View {
        Image(systemName: "xmark.circle.fill")
    }
    

    
}


struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}


