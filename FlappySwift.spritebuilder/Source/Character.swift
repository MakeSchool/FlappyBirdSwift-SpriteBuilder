//
//  Character.swift
//  FlappySwift
//
//  Created by Benjamin Reynolds on 9/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

import Foundation

class Character: CCSprite {
    
    func didLoadFromCCB() {
        self.position = CGPoint(x:115, y:250)
        self.zOrder = DrawingOrder.Hero.rawValue
        self.physicsBody.collisionType = "character"
    }
    
    func flap() {
        self.physicsBody.applyImpulse(CGPoint(x:0.0, y:400.0))
    }
    
    func move() {
        self.physicsBody.velocity = CGPoint(x:80.0, y:self.physicsBody.velocity.y)
    }
    
    class func createFlappy() -> Character! {
        return CCBReader.load("Character") as Character!
    }
}