//
//  TriviaDB.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import Foundation


struct TriviaData{
    
    public static var triviaData = [Result]()
    
    public static func loadData() {

        guard let url = URL(string: "https://opentdb.com/api.php?amount=1") else{
            print("Error creating url object")
            return
        }
        

        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        
                          triviaData = decodedResponse.results
                        print(triviaData)
                        
                    }
                    
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
        
    }
    
    
    public static func getData() -> [Result] {
        print("Before \(triviaData)")
        print("after \(triviaData)")
        return triviaData
    }

}



struct Result: Codable {
    
    var category: String
    var question: String
    var correct_answer: String
    var difficulty: String
    
}

struct Response: Codable {
    
    var results: [Result]
}

