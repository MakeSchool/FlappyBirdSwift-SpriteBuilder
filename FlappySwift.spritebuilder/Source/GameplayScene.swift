//
//  GameplayScene.swift
//  FlappySwift
//
//  Created by Benjamin Reynolds on 9/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

import Foundation

enum DrawingOrder: Int {
    case Pipes
    case Ground
    case Hero
}

class GameplayScene: CCNode, CCPhysicsCollisionDelegate {
    
    var character: Character? = nil
    var physicsNode: CCPhysicsNode? = nil
    var trail: CCParticleSystem? = nil
    var points: Int = 0
    
    // put variables below this line
    var timeSinceObstacle:CCTime = 0
    // put variables above this line
    
    
    func initialize() {
        // put your initialization code below this line
        character = Character.createFlappy()
        self.addToScene(character)
        
        // put your initialization code above this line
        self.addObstacle()
        timeSinceObstacle = 0
        
        self.showScore()
    }
    
    // put new methods below this line
    
    func tap() {
        if let cCharacter = character {
            cCharacter.flap()
        }
    }
    
    override func update(delta: CCTime) {
        //this will be run every frame
        //delta is the time that has elapsed since the last time it was run.
        
        if let cCharacter = character {
            cCharacter.move()
        }
        
        timeSinceObstacle += delta
        
        if timeSinceObstacle > 2 {
            self.addObstacle()
            
            timeSinceObstacle = 0
        }
        
    }
    
    //this gets called when the bird collides with an obstacle
    func collisionWithObstacle() {
        self.gameOver()
    }
    
    func passedObstacle() {
        //update the score
        self.increaseScore()
    }
    
    // put new methods above this line
    
    
    
    ///////////////////////////////////////////////////////
    //                  HIDE FROM USERS                  //
    ///////////////////////////////////////////////////////
    
    override func touchBegan(touch: UITouch, withEvent event: UIEvent) {
        self.tap()
    }
    
    override init() { }
    // is called when CCB file has completed loading
    func didLoadFromCCB() {
    }
    
    deinit {
        
    }

    func addToScene(node: CCNode?) {}
    
    func addObstacle() {}
    
    func showScore() {}
    
    func increaseScore() {}
    
    func updateScore() {}
    
    func gameOver() {}
    
    func addPowerup() {}
    
    func restart() {}
    
}
