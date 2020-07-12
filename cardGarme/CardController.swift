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


        let newDeckURL = baseURL.appendingPathComponent("new")
        let drawURL = newDeckURL.appendingPathComponent("draw")

        var urlComponents = URLComponents(url: drawURL, resolvingAgainstBaseURL: true)

        let countQueryitem = URLQueryItem(name: "count", value: "\(numberOfCards)")

        urlComponents?.queryItems = [countQueryitem]

        guard let requestURL = urlComponents?.url else { return }

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
                let cards = try jsonDecoder.decode([Card].self, from: data)
            } catch {
                NSLog("Unable to decode data into type [Card]: \(error)")
            }
        } .resume() // Starts the data task. without this, the data task would never go to the API.

    }
}
