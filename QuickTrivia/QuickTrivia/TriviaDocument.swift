//
//  TriviaDocument.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import Foundation

class TriviaQuestionsGame: ObservableObject {
    
    @Published var triviaGame: TriviaGame
    
    var trivias: Array<Trivia> {
        triviaGame.trivias
    }
    
    func loadData() {
        TriviaData.loadData()
    }
    
    init() {
        
        triviaGame = TriviaQuestionsGame.createTriviaGame()
    }
    
    
    private static func createTriviaGame() -> TriviaGame {
        

        let trivia = extractData(fromData: TriviaData.getData())
        
        return TriviaGame(numberOfQuestions: trivia.count) { index in
            return trivia[index]
        }
    }
    
    private static func extractData(fromData triviaData: [Result]) -> [Trivia] {
        
        var extractedData = [Trivia]()
        
        for index in 0..<triviaData.count {
            
            extractedData.append(
                Trivia(id: index,
                       category: triviaData[index].category,
                       question: triviaData[index].question,
                       answer: triviaData[index].correct_answer,
                       difficulty: triviaData[index].difficulty))
        }
        
        return extractedData
    }
    

}


