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
    var incorrect_answers: [String]
    
}

struct Response: Codable {
    var results: [Result]
}

struct Trivia: Identifiable {
    var id: Int
    var category: String
    var difficulty: String
    var question: String
    var answerOptions: [String]
    var correct_answer: String
    
}


struct TriviaGame {
    
    static var trivias = [Trivia]()
    static var triviaData = [Result]()
    var isLoading: Bool = false
    
    static func updateTriviaData(newTriviaData: [Result]) {
        
        self.triviaData = newTriviaData
        trivias.removeAll()
        
        var answers = [String]()
        for i in 0..<triviaData.count {
            
            self.triviaData[i].question = triviaData[i].question.replacingOccurrences(of: "&quot;", with: "'")
            self.triviaData[i].question = triviaData[i].question.replacingOccurrences(of: "&ldquo;;", with: "'")

            self.triviaData[i].question = triviaData[i].question.replacingOccurrences(of: "&#039;", with: "'");
            self.triviaData[i].question = triviaData[i].question.replacingOccurrences(of: "&tilde;", with: "ã")
            
            for j in 0..<triviaData[i].incorrect_answers.count {
                self.triviaData[i].incorrect_answers[j] = triviaData[i].incorrect_answers[j].replacingOccurrences(of: "&quot;", with: "'")
                self.triviaData[i].incorrect_answers[j] = triviaData[i].incorrect_answers[j].replacingOccurrences(of: "&#039;", with: "'")
                self.triviaData[i].incorrect_answers[j] = triviaData[i].incorrect_answers[j].replacingOccurrences(of: "&ldquo;;", with: "'")
                self.triviaData[i].incorrect_answers[j] = triviaData[i].incorrect_answers[j].replacingOccurrences(of: "&tilde;", with: "ã")

            }
            
            self.triviaData[i].correct_answer = triviaData[i].correct_answer.replacingOccurrences(of: "&quot;", with: "'")
            self.triviaData[i].correct_answer = triviaData[i].correct_answer.replacingOccurrences(of: "&#039;", with: "'")
            self.triviaData[i].correct_answer = triviaData[i].correct_answer.replacingOccurrences(of: "&ldquo;;", with: "'")
            self.triviaData[i].correct_answer = triviaData[i].correct_answer.replacingOccurrences(of: "&tilde;", with: "ã")

            
            
            answers = triviaData[i].incorrect_answers
            answers.append(triviaData[i].correct_answer)
            answers = answers.shuffled()
            
            trivias.append(Trivia(id: i, category: triviaData[i].category, difficulty: triviaData[i].difficulty, question: triviaData[i].question, answerOptions: answers, correct_answer: triviaData[i].correct_answer))
        }
        
    }
    
    mutating func updateLoadingStatus() {
        isLoading.toggle()
    }
    
}



