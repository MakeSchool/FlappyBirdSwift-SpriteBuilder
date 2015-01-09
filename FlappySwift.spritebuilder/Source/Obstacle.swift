//
//  Obstacle.swift
//  FlappySwift
//
//  Created by Benjamin Reynolds on 9/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

import Foundation

class Obstacle: CCNode {
    
    var _topPipe:CCNode!
    var _bottomPipe:CCNode!
    
    let minimumYPosition:CGFloat = 200.0
    let maximumYPosition:CGFloat = 380.0
    
    let ARC4RANDOM_MAX = 0x100000000
    
    func didLoadFromCCB() {
        
        _topPipe.physicsBody.collisionType = "level"
      
        _bottomPipe.physicsBody.collisionType = "level"
    }
    
    func setupRandomPosition() {
        let random:CGFloat = (CGFloat(rand()) / CGFloat(RAND_MAX))
        let range:CGFloat = maximumYPosition - minimumYPosition
        self.position = CGPoint(x:self.position.x, y:minimumYPosition + (random * range))
    }

}