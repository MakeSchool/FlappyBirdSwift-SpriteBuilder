//
//  MainScene.swift
//  FlappySwift
//
//  Created by Benjamin Reynolds on 9/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

import Foundation

class MainScene: GameplayScene {
    
    var _ground1: CCNode? = nil
    var _ground2: CCNode? = nil
    var _grounds: [CCNode] = []
    
    var _sinceTouch: NSTimeInterval = 0
    var _obstacles: [Obstacle] = []
    var powerups: [CCNode] = []
    
    var _restartButton: CCButton? = nil
    
    var _gameOver:Bool = false
    var _scoreLabel: CCLabelTTF? = nil;
    var _nameLabel: CCLabelTTF? = nil;
    
    override init() {}
    
     deinit {
        println("deinit")
        userInteractionEnabled = false
    }
    
    // is called when CCB file has completed loading
    override func didLoadFromCCB() {
        
        userInteractionEnabled = true
        
        if let cGround1 = _ground1 {
            if let cGround2 = _ground2 {
                _grounds = [cGround1, cGround2]
            }
        }
        
        for ground in _grounds {
            // set collision type
            ground.physicsBody.collisionType = "level"
            ground.zOrder = DrawingOrder.Ground.toRaw()
        }
        
        if let cPhysicsNode = physicsNode {
            //set this class as delegate
            cPhysicsNode.collisionDelegate = self
        }
        
        _obstacles = []
        powerups = []
        points = 0
        
        trail = CCBReader.load("Trail") as CCParticleSystem?
        if let c_trail = trail {
            c_trail.particlePositionType = CCParticleSystemPositionType.Relative
            if let cPhysicsNode = physicsNode {
                cPhysicsNode.addChild(trail)
            }
            c_trail.visible = false
        }

        super.initialize()
    }
    
    override func addToScene(node: CCNode?) {
        if let cPhysicsNode = physicsNode {
            if let cNode = node {
                cPhysicsNode.addChild(node)
            }
        }
    }
    
    override func showScore() {
        if let cScoreLabel = _scoreLabel {
            cScoreLabel.visible = true
        }
    }
    
    override func updateScore() {
        if let cScoreLabel = _scoreLabel {
            cScoreLabel.string = "\(points)"
        }
    }
    
    override func touchBegan(touch: UITouch, withEvent event: UIEvent) {
        
        if !_gameOver {
            if let cCharacter = character {
                cCharacter.physicsBody.applyAngularImpulse(10000.0)
            }
            _sinceTouch = 0.0
            
            super.touchBegan(touch, withEvent:event)
        }
    }

    override func gameOver() {
        if !_gameOver {
            _gameOver = true
            if let cRestartButton = _restartButton {
                cRestartButton.visible = true
            }
            
            if let cCharacter = character {
                cCharacter.physicsBody.velocity = CGPoint(x:0.0, y:character!.physicsBody.velocity.y)
                cCharacter.rotation = 90.0
                cCharacter.physicsBody.allowsRotation = false
                cCharacter.stopAllActions()
            }
            
            let moveBy:CCActionMoveBy = CCActionMoveBy(duration: 0.2, position:CGPoint(x:-2.0,y:2.0))
            let reverseMovement:CCActionInterval = moveBy.reverse()
            let shakeSequence:CCActionSequence = CCActionSequence(one: moveBy, two: reverseMovement)
            let bounce:CCActionEaseBounce = CCActionEaseBounce(action: shakeSequence)
            
            self.runAction(bounce)
        }
    }

    override func restart() {
        println("RESTART");
        
//        let scene = CCBReader.loadAsScene("TestScene")
        
//        if let scene:CCScene = CCBReader.loadAsScene("MainScene") {
//         //   CCDirector.sharedDirector().replaceScene(scene)
//            println(scene)
//        }
        
        CCDirector.sharedDirector().replaceScene(CCBReader.loadAsScene("TestScene"))
    }

    override func addObstacle() {
        let obstacle:Obstacle = CCBReader.load("Obstacle") as Obstacle
        let screenPosition = self.convertToWorldSpace(CGPoint(x:380,y:0))
        if let cPhysicsNode = physicsNode {
            let worldPosition = cPhysicsNode.convertToNodeSpace(screenPosition)
            obstacle.position = worldPosition
        }
        obstacle.setupRandomPosition()
        obstacle.zOrder = DrawingOrder.Pipes.toRaw()
        if let cPhysicsNode = physicsNode {
            cPhysicsNode.addChild(obstacle)
        }
        _obstacles.append(obstacle)
    }

    override func addPowerup() {
        let powerup:CCSprite = CCBReader.load("Powerup") as CCSprite
        
        let first:Obstacle = _obstacles[0]
        let second:Obstacle = _obstacles[1]
        if let cLast:Obstacle = _obstacles.last {
            if let cCharacter = character {
                powerup.position = CGPoint(x:cLast.position.x + (second.position.x-first.position.x)/4.0 + cCharacter.contentSize.width, y:CGFloat(arc4random()%488)+200)
            }
        }
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair, character nodeA: CCNode, wildcard /*level*/ nodeB: CCNode) {
        self.collisionWithObstacle()
    }
    
    override func increaseScore() {
        points++
        self.updateScore()
    }

    override func update(delta: CCTime) {
        _sinceTouch += delta
        
        if let cCharacter = character {
            cCharacter.rotation = clampf(cCharacter.rotation, -30.0, 90.0)
            if let cTrail = trail {
                cTrail.position = cCharacter.position
            }
        }

        let r = arc4random() % 255
        let g = arc4random() % 255
        let b = arc4random() % 255
        
//        if let cTrail = trail {
//            cTrail.startColor = CCColor(red:r, green:g, blue:b)
//        }
//         set trail color to CCColor(ccColor3b: ccc3(arc4random() % 255, arc4random() % 255, arc4random() % 255))
        
        if let cCharacter = character {
            if cCharacter.physicsBody.allowsRotation {
                let angularVelocity = clampf(Float(cCharacter.physicsBody.angularVelocity), -2.0, 1.0)
                cCharacter.physicsBody.angularVelocity = CGFloat(angularVelocity)
            }
            
            if _sinceTouch > 0.5 {
                cCharacter.physicsBody.applyAngularImpulse(CGFloat(-40000.0 * delta))
            }
        }

        if let cPhysicsNode = physicsNode {
            if let cCharacter = character {
                cPhysicsNode.position = CGPoint(x:cPhysicsNode.position.x - (cCharacter.physicsBody.velocity.x * CGFloat(delta)),y:cPhysicsNode.position.y)
            }
            
            for ground in _grounds {
                let groundWorldPosition = cPhysicsNode.convertToWorldSpace(ground.position)
                let groundScreenPosition = self.convertToNodeSpace(groundWorldPosition)
                
                if groundScreenPosition.x <= (-1 * ground.contentSize.width) {
                    ground.position = CGPoint(x:ground.position.x + 2 * ground.contentSize.width, y:ground.position.y)
                }
            }
            
            var offScreenObstacles:[Obstacle] = []
            
            for obstacle in _obstacles {
                let obstacleWorldPosition = physicsNode!.convertToWorldSpace(obstacle.position)
                let obstacleScreenPosition = self.convertToNodeSpace(obstacleWorldPosition)
                
                if obstacleScreenPosition.x < -obstacle.contentSize.width {
                    offScreenObstacles.append(obstacle)
                }
            }
            
        }

        if !_gameOver {
            if let cCharacter = character {
                cCharacter.physicsBody.velocity = CGPoint(x:cCharacter.physicsBody.velocity.x, y: min(cCharacter.physicsBody.velocity.y, 200.0))
            }
            
            super.update(delta)
        }
    
    }
    
}
