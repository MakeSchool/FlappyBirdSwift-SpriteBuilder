import Foundation

class GameplayScene: TutorialScene
{
    
    // put variables below this line
    
    var timeSinceObstacle:CCTime = 0
    
    // put variables above this line
    
    func initialize()
    {
        // put your initialization code below this line
        
        character = Character.createFlappy()  
        physicsNode.addChild(character)
        
        self.showScore()
        
        // put your initialization code above this line
    }
    
    // put new methods below this line
    
    override func tap()
    {
        var impulse:CGFloat = 200 - 2 * character.physicsBody.velocity.y
        character.physicsBody.applyImpulse(CGPoint(x:0, y:impulse))
    }
    
    override func update(delta: CCTime)
    {
        character.physicsBody.velocity = CGPoint(x:80.0, y:character.physicsBody.velocity.y)
        
        timeSinceObstacle += delta;
        
        if timeSinceObstacle > 2
        {
            self.addObstacle()
            timeSinceObstacle = 0
        }
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair, character: CCNode, level: CCNode) -> ObjCBool
    {
        self.gameOver()
        return true
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair, character: CCNode, goal: CCNode) -> ObjCBool
    {
        self.increaseScore()
        return false
    }
    
    // put new methods above this line
}
