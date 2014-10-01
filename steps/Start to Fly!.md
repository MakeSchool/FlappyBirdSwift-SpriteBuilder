Basic Syntax
============

Swift syntax for declaring and calling methods follows a pattern similar to many languages such as Java or Python, although the specifics are a little bit different.

To call a method: ```ObjectName.methodNameToCall()```
For example: ```character.jump()```
To call a method and pass a parameter: ```ObjectName.methodName(parameter)```
For example: ```self.addChild(character)```


Make the Bird Flap!
=======================
For your game to respond to input, we have to write a new method to be run whenever the player taps the screen. Add the following after the closing bracket of the init method but before the final closing bracket of the program:

	func tap()
	{
        // this will get called every time the player
    	// taps the screen.
    }

Now that we have code that is run every time the player taps the screen, we want to make the bird flap. Inside your ```tap``` method, add the following code:

    character.flap()

Now run the game again. This time, try to tap on the screen to see the bird flap!

Method Syntax
=============

As we've seen in the ```tap``` method, you can creating methods in Swift using the ```func```. ("func" stands for "function", which is another name for a method.)

	func nameOfMethod()
	{
        // ... put as many lines of code here as you want
	}

The above method does not accept any parameters, and doesn't return any values. Methods that take in parameters and return a value use the following syntax:

	func nameOfMethod(firstParameter : typeOfFirstParameter, secondParameter : typeOfSecondParameter) -> returnType
	{
		// ... any code needed to compute myReturnValue
		return myReturnValue
	}

Here's one more example method. This one returns an Int and accepts a String:

    func doSomethingWithAString(myString : String) -> Int
    {
        // returns the length of the string times ten
        return myString.utf16Count * 10
    }
