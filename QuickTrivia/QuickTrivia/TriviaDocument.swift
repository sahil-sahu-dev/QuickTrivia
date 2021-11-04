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
    
    
        
    
    public func loadData() {

        guard let url = URL(string: "https://opentdb.com/api.php?amount=30") else{
            print("Error creating url object")
            return
        }
            

        let request = URLRequest(url: url)
            
        URLSession.shared.dataTask(with: request) { data, response, error in
                
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async { [self] in
                            
                        triviaGame.triviaData = decodedResponse.results
                        print(triviaGame.trivias)

                    }
                        
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                
        }.resume()
            
    }
    
    public func loadNewCategory(for category: String) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=30" + "&category=" + category) else{
            print("Error creating url object")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data!) {
                
                DispatchQueue.main.async {[self] in
                    
                    triviaGame.triviaData = decodedResponse.results
                    print(triviaGame.trivias)
                    
                }
            }
            
        }
        
    }
    
    
    init() {
        
        triviaGame = TriviaGame()
        loadData()
    }
    
    
   
    

}


