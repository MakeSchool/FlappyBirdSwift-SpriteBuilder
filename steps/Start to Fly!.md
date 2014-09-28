Method Syntax
=============

To declare a method in Objective-C, follow the following format:

	-(type I return) nameOfMethod:
	(type of first parameter) firstParameter
	continuationOfMethodName:
	(type of second parameter) secondParameter

For example, to declare a method that does not return anything and does not accept any parameters:

	-(void) doSomething
	{
		NSLog(@"Hello World!");
	}

Or, to declare a method that returns an int and accepts a string:

	-(int) doSomethingWithAString: (NSString *) myString
	{
		//returns the length of the string times ten
		return [myString length] * 10;
	}

Or, to declare a method that returns an array and accepts multiple strings:


	-(NSArray *) addThisStringToAnArray: (NSString *) firstString
						andThisString: (NSString *) secondString
						andAlsoThisString: (NSString *) thirdString
	{
		return [NSArray arrayWithObjects: firstString,
			secondString,
			thirdString, nil];
	}

Adding a jump!
=======================

For your game to respond to input, we have to write a new method to be run whenever
the player touches the screen. Add the following after the closing bracket of the init method
but before the ```@end```:

	- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
	{
		// this will get called every time the player
		// touches the screen.
	}

Now that we have code that is run every time the player touches the screen, we want to make
the character jump. To do that, we need to add a physics impulse. Inside your ```touchBegan```
method, add the following code:

	float impulse = 200-2*character.physicsBody.velocity.y;
	[character.physicsBody applyImpulse:ccp(0, impulse)];

Here the impulse is a vector pointing straight up. You can modify how far up the character
goes by modifying the ```200```.

Now run the game again. This time, try to click on the screen to see the fly jump up!
