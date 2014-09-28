Creating the Character
===================

We've created a Character class for you to use and imported it at the top of the file.
To create the character, add the following line to the ```initialize``` method where it says
```// put your initialization code below this line```:

    // initialize the character
    character = Character.createFlappy()

In order to have the character appear, you'll have to add it to the scene. On a new line
under where you initialized your character, write:

    // add the character to the scene
    self.addToScene(character)

Now hit the run button and take a look at what you have built! You should see your
character fall to the bottom. That's because we haven't given him any velocity yet!