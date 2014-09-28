//
//  Goal.swift
//  FlappySwift
//
//  Created by Benjamin Reynolds on 9/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

import Foundation

class Goal: CCNode {

    func didLoadFromCCB() {
        self.physicsBody.collisionType = "goal"
        self.physicsBody.sensor = true
    }
    
}


