//
//  ContentView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import SwiftUI



struct TriviaQuestionsGameView: View {
    
    
    @ObservedObject var trivia: TriviaQuestionsGame
    
    var body: some View {
        
        List(trivia.trivias){ item in
            VStack{
                Text("Question: " + item.question)
                lineSpacing(1)
                Text("Answer: " + item.answer)
                lineSpacing(1)
                Text("Category: " + item.category)
               
            }
        }
        .onAppear(perform: trivia.loadData)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuestionsGameView(trivia: TriviaQuestionsGame())
    }
}
