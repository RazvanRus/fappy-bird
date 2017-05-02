//
//  GameplayScene.swift
//  flapping bird
//
//  Created by Rus Razvan on 02/05/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var bird  = Bird()
    
    var pipesHolder = SKNode();

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
        moveBackgroundAndGrounds()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.flap()
        
    }
    
    func initialize() {
        createBird()
        createBackgrounds()
        createGrounds()
        createPipes()
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
            
            node.position.x -= 3
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
        
        pipeUp.name = "Pipe"
        pipeUp.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pipeUp.position = CGPoint(x: 0, y: 500)
        pipeUp.zRotation = CGFloat(Double.pi)
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeUp.physicsBody?.categoryBitMask = ColliderType.Pipes
        pipeUp.physicsBody?.affectedByGravity = false
        pipeUp.physicsBody?.isDynamic = false
        
        pipeDown.name = "Pipe"
        pipeDown.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pipeDown.position = CGPoint(x: 0, y: -500)
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeDown.physicsBody?.categoryBitMask = ColliderType.Pipes
        pipeDown.physicsBody?.affectedByGravity = false
        pipeDown.physicsBody?.isDynamic = false
        
        pipesHolder.zPosition = 4
        pipesHolder.position = CGPoint(x: 0, y: 0)
        pipesHolder.addChild(pipeUp)
        pipesHolder.addChild(pipeDown)
        
        self.addChild(pipesHolder)
        
    }
    
    
    
    
}












