//
//  ViewController.swift
//  cardGarme
//
//  Created by Sammy Alvarado on 7/7/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        cardController.draw(numberOfCards: 2) { (cards) in
        }
    }

    let cardController = CardController()

}

