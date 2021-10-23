//
//  ContentView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import SwiftUI



struct TriviaQuestionsGameView: View {
    
    @ObservedObject var triviaDocument: TriviaQuestionsGame
    var questionIndex: Int = 0
    
    var body: some View {
                
                ZStack{
                    
                    VStack{
                     Text("Question")
                        withAnimation{
                            question
                                .padding()
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        
                        Text("Answer")
                        if(triviaDocument.trivias.count > questionIndex){
                            answers
                                .padding()
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                    
                    
                }
        
    }
    
    var question: some View {
        
            if(triviaDocument.trivias.count > questionIndex){
                return Text(triviaDocument.trivias[questionIndex].question)
                
            }
        
        
        return Text("")
    }
    
//    var blueRectangle: some View {
//
//
//    }
    
    var answers: some View {
        
        
        return VStack{
            Text(triviaDocument.trivias[questionIndex].answerOptions[0])
            Text(triviaDocument.trivias[questionIndex].answerOptions[1])
                    
            if(triviaDocument.trivias[questionIndex].answerOptions.count == 4){
                Text(triviaDocument.trivias[questionIndex].answerOptions[2])
                Text(triviaDocument.trivias[questionIndex].answerOptions[3])
            }
        }
        
    }
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuestionsGameView(triviaDocument: TriviaQuestionsGame())
            
    }
}
