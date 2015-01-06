//
//  TutorialScene.swift
//  FlappySwift
//
//  Created by Gerald Monaco on 10/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

import Foundation

enum DrawingOrder: Int {
    case Pipes
    case Ground
    case Hero
}

class TutorialScene: CCNode, CCPhysicsCollisionDelegate {
    var character: Character!
    var physicsNode: CCPhysicsNode!
    
    func tap() {}
    
    func addObstacle() {}
    
    func showScore() {}
    
    func increaseScore() {}
    
    func updateScore() {}
    
    func gameOver() {}
    
    func addPowerup() {}
    
    func restart() {}
    
    override func update(delta: CCTime) {}
}