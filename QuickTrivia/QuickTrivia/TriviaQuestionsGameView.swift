//
//  ContentView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import SwiftUI



struct TriviaQuestionsGameView: View {
    
    @EnvironmentObject var triviaDocument: TriviaQuestionsGame
    
    @State var questionIndex: Int = 0
    @State var hasTappedOption = false
    @State var tappedAnswer: String = ""
    @State var currentScore: Int = 0
    @State var timeRemaining = 30
    @State var showingAlert = false
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
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
            else if questionIndex<triviaDocument.trivias.count && timeRemaining > 0 {
                VStack{
                    triviaView
                    Text("Time remaining \(Int(timeRemaining))")
                        .bold()
                        .padding()
                        
                }
                
            }
            
            else if questionIndex>=triviaDocument.trivias.count{
                finalScoreView
            }
                
        }
        
        .alert(isPresented: $showingAlert) {
            
                Alert(
                    title: Text("Time Over!"),
                    message: Text("You must select an option within 30 seconds"),
                    dismissButton : .default(Text("Next Question")) {
                        nextQuestion()
                    }
                )
            
            }
        
        .onReceive(timer) {time in
            if(!hasTappedOption && timeRemaining > 0) {
                timeRemaining -= 1
            }
            else{
                showingAlert = true
            }
            
        }
        
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                scoreView
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                toggleQuestion.padding()
            }
            
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        
        
    }
    
    func nextQuestion() {
        timeRemaining = 30
        questionIndex += 1
        hasTappedOption = false
        showingAlert = false
        tappedAnswer = ""
    }
    
    
    var finalScoreView: some View {
        Text("Final score is: \(currentScore)/\(triviaDocument.trivias.count)")
        
    }
    
    var triviaView: some View {
        VStack{
            
            questionView
                .padding()
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
        
       
        return "Wrong Answer"
        
    }
    
    var scoreView: some View {
        Text("Score: \(currentScore)")
            .font(.subheadline)
            .bold()
    }
    
    
    var questionView: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: 300, maxHeight: 90)
                .foregroundColor(yellowColor)

            question
                .foregroundColor(blackColor)
                .frame(maxWidth: 300)
                .font(.title3)
                .offset(y: 20)
                
            
        }
    }
    
    var question: some View {
        
        if(triviaDocument.trivias.count > questionIndex){
            return Text("\(questionIndex+1). \(triviaDocument.trivias[questionIndex].question)")
                
        }
        
        return Text("")
    }
    
    
    var toggleQuestion: some View {
       
        Button("Next") {
            timeRemaining = 30
            questionIndex += 1
            hasTappedOption = false
            showingAlert = false
            tappedAnswer = ""
        }
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
                            .offset(x: 130)
                        
                        xMark
                            .padding()
                            .opacity(hasTappedOption && !answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? 1 : 0)
                            .offset(x: 130)
                        
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



