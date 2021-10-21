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
        
        NavigationView{
        
        List(trivia.trivias, id: \.self){ item in
            VStack{
                Text("Question: " + item.question)
                Spacer()
                Text("Answer: " + item.correct_answer)
                Spacer()
                Text("Category: " + item.category)
               
            }
        }
            
        .navigationBarTitle("QuickTrivia")
        
    }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuestionsGameView(trivia: TriviaQuestionsGame())
    }
}
