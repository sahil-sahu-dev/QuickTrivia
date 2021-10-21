//
//  Trivia.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import Foundation

struct Trivia: Identifiable, Codable {
    
    var id: Int
    var category: String
    var question: String
    var answer: String
    var difficulty: String
    
}

struct TriviaGame {
    
    var trivias = [Trivia]()
    
    init(numberOfQuestions: Int, triviaFactory: (Int) -> Trivia ) {
        
        for index in 0..<numberOfQuestions {
            trivias.append(triviaFactory(index))
        }
    }
    
}



