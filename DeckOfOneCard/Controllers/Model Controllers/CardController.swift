//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Rishi Kolappa on 5/4/21.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        
        guard let baseURL = baseURL else { return(completion(.failure(.invalidURL)))}
        
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("CARD STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                
                guard let card = topLevelObject.cards.first else {return}
                
                completion(.success(card))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        
        guard let url = card.image else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("IMAGE STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            
            completion(.success(image))
            
        }.resume()
        
    }
    
    
    
    
    
} //End of class

