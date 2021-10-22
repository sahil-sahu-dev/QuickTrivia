//
//  ContentView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import SwiftUI



struct TriviaQuestionsGameView: View {
    
    
    @ObservedObject var triviaDocument: TriviaQuestionsGame
    
    
    var body: some View {
        
        NavigationView{
        
            List(triviaDocument.trivias){ item in
            
                VStack{
                    Text("Question: " + item.question)
                    Spacer()
                    Text("Category: " + item.category)
                    showAnswerOptions(for: item)
                    Spacer()
                    Text("Answer: " + item.correct_answer)
               
            }
        }
                
        .navigationBarTitle("QuickTrivia")
        
    }
        
}
    
    @ViewBuilder
    func showAnswerOptions(for item: Trivia) -> some View{

        ForEach(item.answerOptions, id: \.self) { question in
            Text(question)
        }
    }
  
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuestionsGameView(triviaDocument: TriviaQuestionsGame())
    }
}
