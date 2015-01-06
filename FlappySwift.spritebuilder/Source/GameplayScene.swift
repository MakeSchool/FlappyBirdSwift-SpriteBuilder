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
        
        self.addToScene(character)
        
        self.showScore()
        
        // put your initialization code above this line
    }
    
    // put new methods below this line
    
    override func tap()
    {
        character.flap()
    }
    
    override func update(delta: CCTime)
    {
        character.move()
        
        timeSinceObstacle += delta;
        
        if timeSinceObstacle > 2
        {
            
            self.addObstacle()
            timeSinceObstacle = 0
        }
    }
    
    override func collisionWithObstacle()
    {
        self.gameOver()
    }
    
    override func passedObstacle()
    {
        self.increaseScore()
    }
    
    
    // put new methods above this line
}
