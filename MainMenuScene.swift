//
//  MainMenuScene.swift
//  flapping bird
//
//  Created by Rus Razvan on 03/05/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var birdButton = SKSpriteNode()
    var highscoreLaber = SKLabelNode()

    
    override func didMove(to view: SKView) {
        initialize()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Play" {
                let gameplay = GameplayScene(fileNamed: "GameplayScene")
                gameplay?.scaleMode = .aspectFill
                self.view?.presentScene(gameplay!, transition: SKTransition.crossFade(withDuration: TimeInterval(0.5)))
            }
            
            if atPoint(location).name == "Highscore" {
                highscoreLaber.removeFromParent()
                createHighscoreLabel()
            }
            
            if atPoint(location).name == "Bird" {
                GameManager.instance.incrementIndex()
                birdButton.removeFromParent()
                createBirdButton()
            }
        }
    }
    
    func initialize() {
        createBackground()
        createButtons()
        createBirdButton()
    }
    
    func createBackground() {
        let bg = SKSpriteNode(imageNamed: "BG Day")
        bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bg.position = CGPoint(x: 0, y: 0)
        bg.zPosition = 0
        self.addChild(bg)
    }
    
    func createButtons() {
        let play = SKSpriteNode(imageNamed: "Play")
        let highscore = SKSpriteNode(imageNamed: "Highscore")
        
        play.name = "Play"
        play.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        play.position = CGPoint(x: -180, y: -50)
        play.zPosition = 1
        play.setScale(0.7)
        
        highscore.name = "Highscore"
        highscore.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        highscore.position = CGPoint(x: 180, y: -50)
        highscore.zPosition = 1
        highscore.setScale(0.7)
        
        self.addChild(play)
        self.addChild(highscore)
    }
    
    func createBirdButton() {
        birdButton = SKSpriteNode()
        birdButton.name = "Bird"
        birdButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        birdButton.position = CGPoint(x: 0, y: 200)
        birdButton.setScale(1.3)
        birdButton.zPosition = 3
        
        var birdAnim = [SKTexture]()
        
        for i in 1..<4 {
            let name = "\(GameManager.instance.getBird()) \(i)"
            birdAnim.append(SKTexture(imageNamed: name))
        }
        
        let animateBird = SKAction.animate(with: birdAnim, timePerFrame: 0.1, resize: true, restore: true)
        
        birdButton.run(SKAction.repeatForever(animateBird))
        
        self.addChild(birdButton)
    }
    
    func createHighscoreLabel() {
        highscoreLaber = SKLabelNode(fontNamed: "04b_19")
        highscoreLaber.zPosition = 6
        highscoreLaber.position = CGPoint(x: 0, y: -400)
        highscoreLaber.fontSize = 120
        highscoreLaber.text = String(GameManager.instance.getHighscore())
        self.addChild(highscoreLaber)
    }
}




























