//
//  GameManager.swift
//  flapping bird
//
//  Created by Rus Razvan on 03/05/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import Foundation

class GameManager {
    
    static let instance = GameManager()
    private init() {}
    
    var birdindex = Int(0)
    var birds = ["Blue", "Green", "Red"]
    
    func getBird() -> String {
        return birds[birdindex]
    }
    
    func incrementIndex() {
        if birdindex == birds.count-1 {
            birdindex = Int(0)
        } else {
            birdindex += 1
        }
    }
    
    func setHighscore(highscore: Int) {
        UserDefaults.standard.set(highscore, forKey: "Highscore")
    }
    
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: "Highscore")
    }
}



























