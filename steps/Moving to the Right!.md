Creating an Update Loop
=============

You probably noticed that your bird only goes up and down, not to the right like it should.

For this sort of logic, games typically use an "update loop." What happens is that some code is run really fast - up to 60 times per second! That code usually checks things like player health, whether enemies have died, and allows you to program actions that repeat constantly, like moving our bird to the right!

In order to create an update loop, you need to add a new method. Below the closing bracket of your tap method (but above the closing bracket at the end of the program), add the following:

    override func update(delta: CCTime)
    {
        // This will be run every frame
        // delta is the time that has elapsed since the last time it was run.
    }

Don't worry about that special ```override``` keyword at the beginning of the function. It just needs to be there to let the game replace the default update loop with the one we're using. But you'll learn more about that later! For now, add the following line inside the update method:

Making the Character Move
In your update method, add the following:

    character.move()

Now run the game again. You should see the character moving now!