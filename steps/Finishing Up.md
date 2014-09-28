Ending the Game
==================

Now that we have obstacles, we need a game over. For that, we need to check for a collision
between the character and an obstacle. Like touches, we need another method for that.

Add the following below the closing bracket of your ```update``` method,
but before the ```@end```:

	-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair character:(CCSprite *)character level:(CCNode *)level
	{
		[self gameOver];
		return TRUE;
	}

Keeping Score
=============

The last thing that we need to do is keep score. To do that, we first need to show
the current score. At the end of your ```initialize``` method, add:

	[self showScore];

If you run the game now, you will see a 0 displayed, even after you go through the
obstacles. That's because we need to add the logic to increment the score! To do that,
we need to check for another collision, this time with with an invisible area between
the pipes.

Add the following below the closing bracket of your ```ccPhysicsCollisionBegin``` method,
but before the ```@end```:

	-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair character:(CCSprite *)character goal:(CCNode *)goal
	{
		[goal removeFromParent];
		points++;
		[self updateScore];
		return TRUE;
	}

Run the game again and you should see your finished Flappy Bird game! Congratulations - you've
built your first iPhone game!

Want to make your own iPhone game? Enroll in our
[Online Academy](https://www.makegameswith.us/online-academy/)!
