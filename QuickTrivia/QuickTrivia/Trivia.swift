//
//  Trivia.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import Foundation


struct Result: Codable, Hashable {
    
    var category: String
    var question: String
    var correct_answer: String
    var difficulty: String
    
}

struct Response: Codable {
    
    var results: [Result]
}



struct TriviaGame {
    
    var trivias = [Result]()
    
    
    
}



