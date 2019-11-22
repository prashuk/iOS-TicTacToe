//
//  TTTImageView.swift
//  TicTacToe
//
//  Created by Prashuk Ajmera on 10/31/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import UIKit

class TTTImageView: UIImageView {

    var player: String?
    var activated: Bool = false
    
    func setPlayer(player: String) {
        self.player = player
        
        if activated == false {
            if player == "cross" {
                self.image = UIImage(named: "cross")
            } else {
                self.image = UIImage(named: "zero")
            }
            activated = true
        }
    }

}
