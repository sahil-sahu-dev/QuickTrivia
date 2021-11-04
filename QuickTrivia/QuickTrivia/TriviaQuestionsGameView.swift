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
            if(triviaDocument.isLoading()) {
                ProgressView().foregroundColor(.black)
            }
            else{
                triviaView
            }
                
        }
        .navigationBarItems(trailing: toggleQuestion.padding())
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        
        
    }
    
    var triviaView: some View {
        VStack{
            
            questionView
                .padding()
            scoreView
            answersView
                .padding()
            
            Text("\(answerEmojiView) \(answerEmojiView.elementsEqual("Correct Answer!") ? successEmojis[ Int.random(in: 0..<3)] : failureEmojis[ Int.random(in: 0..<3)])")
                .opacity(hasTappedOption ? 1 : 0)
                .font(.subheadline)
                .foregroundColor(answerEmojiView.elementsEqual("Correct Answer!") ? .init(red: 0, green: 156/255, blue: 23/255) : .red)
                
        }
    }
    
    
    var answerEmojiView: String {
        
        if questionIndex < triviaDocument.trivias.count && tappedAnswer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) {
            
            return "Correct Answer!"
        }
        
       
        return "Wrong Answer \(failureEmojis[ Int.random(in: 0..<3)])"
        
    }
    
    var scoreView: some View {
        Text("Score: \(currentScore)")
            .font(.subheadline)
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
                        
                        RoundedRectangle(cornerRadius: 15)
                            .frame(minWidth: 120, maxWidth: 300, minHeight: 70)
                            //.aspectRatio(1/5, contentMode: .fit)
                        
                        .foregroundColor(!hasTappedOption ?
                                            blackColor : answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ?
                                            greenColor :  tappedAnswer.elementsEqual(answer)
                                            ? pinkColor : blackColor)
                        
                        
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
                    .onTapGesture {
                        //haptic feedback and changing state variable for the tapped options
                        
                        tappedAnswer = hasTappedOption ? tappedAnswer : answer
                        
                        currentScore = answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) && !hasTappedOption ? currentScore
                            + 1 : currentScore
                        
                        hasTappedOption = true
                      
                        answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? HapticsManager.instance.notification(of: .success) : HapticsManager.instance.notification(of: .error)
                        
                    }
                    .foregroundColor(blackColor)
                }
            }
            
        }
    }
    
    var checkMark: some View {
        Image(systemName: "checkmark.circle.fill")
    }
    
    var xMark: some View {
        Image(systemName: "xmark.circle.fill")
    }
    

    
}



