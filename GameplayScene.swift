//
//  GameplayScene.swift
//  flapping bird
//
//  Created by Rus Razvan on 02/05/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var bird  = Bird()
    
    var pipesHolder = SKNode();
    
    var scoreLaber = SKLabelNode(fontNamed: "04b_19")
    var score = 0
    
    var gameStarted = false
    var isAlive = false
    
    var press = SKSpriteNode()

    override func didMove(to view: SKView) {
        initialize()
    }
    
    func createBird(){
        bird = Bird(imageNamed: "Blue 1")
        bird.initialize()
        bird.position = CGPoint(x: -50, y: 0)
        self.addChild(bird)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isAlive {
            moveBackgroundAndGrounds()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameStarted {
            press.removeFromParent()
            isAlive = true
            gameStarted = true
            spawnObstacles()
            bird.physicsBody?.affectedByGravity = true
            bird.flap()
        }
        if isAlive {
            bird.flap()
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Retry" {
                self.removeAllActions()
                self.removeAllChildren()
                gameStarted = false
                isAlive = false
                score = 0
                initialize()
            }
            if atPoint(location).name == "Quit" {
                // go back to main menu
            }
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secoundBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Bird" {
            firstBody = contact.bodyA
            secoundBody = contact.bodyB
        } else if contact.bodyB.node?.name == "Bird" {
            firstBody = contact.bodyB
            secoundBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Bird" && secoundBody.node?.name == "Score" {
            incrementScore()
        } else if firstBody.node?.name == "Bird" && secoundBody.node?.name == "Pipe" {
            // kill the bird
            if isAlive {
                birdDied()
            }
        } else if firstBody.node?.name == "Bird" && secoundBody.node?.name == "Ground" {
            // kill the bird
            if isAlive {
                birdDied()
            }
        }
        
    }
    
    
    func initialize() {

        
        physicsWorld.contactDelegate = self
        
        createInstructions()
        createBird()
        createBackgrounds()
        createGrounds()
        createLabel()
    }
    
    func createInstructions() {
        press = SKSpriteNode(imageNamed: "Press")
        press.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        press.position = CGPoint(x: 0, y: 0)
        press.setScale(1.8)
        press.zPosition = 10
        self.addChild(press)
    }
    
    
    
    func createBackgrounds() {
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "BG Day");
            bg.name = "BG"
            bg.zPosition=0
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0)
            self.addChild(bg)
        }
    }
    
    func createGrounds() {
        for i in 0...2 {
            let ground = SKSpriteNode(imageNamed: "Ground")
            ground.name = "Ground"
            ground.zPosition = 5
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -(self.frame.size.height/2))
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.categoryBitMask = ColliderType.Ground
            ground.physicsBody?.affectedByGravity = false
            ground.physicsBody?.isDynamic = false
            self.addChild(ground)
        }
    }
    
    func moveBackgroundAndGrounds() {
        
        enumerateChildNodes(withName: "BG", using: ({
            (node, error) in
            
            node.position.x -= 0.5
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
            
        }))
        
        enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            node.position.x -= 3.9
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
            
        }))
        
    }
    
    func createPipes() {
        
        pipesHolder = SKNode()
        pipesHolder.name = "Holder"
        
        let pipeUp = SKSpriteNode(imageNamed: "Pipe 1")
        let pipeDown = SKSpriteNode(imageNamed: "Pipe 1")
        
        let scoreNode = SKSpriteNode()
        
        scoreNode.name = "Score"
        scoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scoreNode.position = CGPoint(x: 35, y: 0)
        scoreNode.size = CGSize(width: 5, height: 300)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.categoryBitMask = ColliderType.Score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic =  false
        
        
        pipeUp.name = "Pipe"
        pipeUp.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pipeUp.position = CGPoint(x: 0, y: 400)
        pipeUp.zRotation = CGFloat(Double.pi)
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeUp.physicsBody?.categoryBitMask = ColliderType.Pipes
        pipeUp.physicsBody?.affectedByGravity = false
        pipeUp.physicsBody?.isDynamic = false
        
        pipeDown.name = "Pipe"
        pipeDown.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pipeDown.position = CGPoint(x: 0, y: -450)
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeDown.physicsBody?.categoryBitMask = ColliderType.Pipes
        pipeDown.physicsBody?.affectedByGravity = false
        pipeDown.physicsBody?.isDynamic = false
        
        pipesHolder.zPosition = 4
        pipesHolder.position.x = self.frame.width + 100
        pipesHolder.position.y = CGFloat.randomBetweenNumbers(firstNum: -50, secoundNum: 200)
        pipesHolder.addChild(pipeUp)
        pipesHolder.addChild(pipeDown)
        pipesHolder.addChild(scoreNode)
        
        self.addChild(pipesHolder)
        
        let destination = self.frame.width * 2
        let move = SKAction.moveTo(x: -destination, duration: TimeInterval(10))
        let remove = SKAction.removeFromParent()
        
        pipesHolder.run(SKAction.sequence([move, remove]), withKey: "Move")
        
        
    }
    
    func spawnObstacles() {
        let spawn = SKAction.run({ () -> Void in
            self.createPipes()
        })
        
        let delay = SKAction.wait(forDuration: TimeInterval(2))
        let sequence = SKAction.sequence([spawn, delay])
        
        self.run(SKAction.repeatForever(sequence), withKey: "Spawn")
        
    }
    
    func createLabel() {
        scoreLaber.zPosition = 6
        scoreLaber.position = CGPoint(x: 0, y: 450)
        scoreLaber.fontSize = 120
        scoreLaber.text = String(score)
        self.addChild(scoreLaber)
    
    }
    
    func incrementScore() {
        score+=1
        scoreLaber.text = String(score)
    }
    
    func birdDied() {
        
        self.removeAction(forKey: "Spawn")
        
        for child in children {
            if child.name == "Holder" {
                child.removeAction(forKey: "Move")
            }
        }
        
        isAlive = false
        
        let retry = SKSpriteNode(imageNamed: "Retry")
        let quit = SKSpriteNode(imageNamed: "Quit")
        
        retry.name = "Retry"
        retry.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        retry.position = CGPoint(x: -150, y: -150)
        retry.zPosition = 7
        retry.setScale(0)
        
        quit.name = "Quit"
        quit.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quit.position = CGPoint(x: 150, y: -150)
        quit.zPosition = 7
        quit.setScale(0)
        
        let scaleUp = SKAction.scale(to: 1, duration: TimeInterval(0.5))
        
        retry.run(scaleUp)
        quit.run(scaleUp)
        
        self.addChild(retry)
        self.addChild(quit)
        
        
    }
    
}












