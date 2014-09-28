Now that you've finished the basic game, see if you can extend it. We have provided
a basic structure for power-ups. Start by adding ```[self addPowerup];``` right after
your ```[self addObstacle];``` in your ```update``` method. Then when you play the game
you will see power-ups appear between obstacles.

Next, you'll need to add a method for when you collide with the power-up, which looks
like this:

	-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair character:(CCSprite *)character powerup:(CCSprite *)powerup
	{
		return TRUE;
	}

We've also added a special particle effect to Flappy that you can show
by writing:

	trail.visible = TRUE;

Conversely, you can hide the effect by using ```FALSE``` instead of ```TRUE```.

See if you can use what you've already learned to create a cool power-up. One
possible power-up would make Flappy invincible for a few seconds. Of course, during
that time you probably don't want add any more power-ups.

_HINT_: You will probably need to declare a new variable to track whether your
power-up is enabled. Create a new variable with ```BOOL``` instead of ```float```.

Want to make your own iPhone game? Enroll in our
[Online Academy](https://www.makegameswith.us/online-academy/)!
