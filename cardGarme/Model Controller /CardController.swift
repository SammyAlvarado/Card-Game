//
//  CardController.swift
//  cardGarme
//
//  Created by Sammy Alvarado on 7/7/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation

class CardController {

    let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/")!

    func draw(numberOfCards: Int, completion: @escaping ([Card]?) -> Void) {

        // Set Up the URL
        let newDeckURL = baseURL.appendingPathComponent("new")
        let drawURL = newDeckURL.appendingPathComponent("draw")

        var urlComponents = URLComponents(url: drawURL, resolvingAgainstBaseURL: true)

        let countQueryitem = URLQueryItem(name: "count", value: "\(numberOfCards)")

        urlComponents?.queryItems = [countQueryitem]

        guard let requestURL = urlComponents?.url else { return }

        // Create the data task 
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in

            // Get the data and truen it into an array of Cards.
            if let error = error {
                NSLog("Error with data task: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                NSLog("No data was retruned from the dta task")
                completion(nil)
                return
            }

            // The data constant is JSON.
            let jsonDecoder = JSONDecoder()

            do {
                let deck = try jsonDecoder.decode(Deck.self, from: data)
                completion(deck.cards)
                NSLog("Successfully \(deck.cards.count)")
            } catch {
                NSLog("Unable to decode data into type [Card]: \(error)")
                completion(nil)
                return
            }
        } .resume() // Starts the data task. without this, the data task would never go to the API.

    }
}
