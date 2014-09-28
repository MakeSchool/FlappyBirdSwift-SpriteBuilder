Making the Character Move
=============

So far we have only made the character move vertically. Now we want to make him
move to the right, so he can progress through the level. You may have already realized
how to do that: we just need to add velocity!

To do that, change the lines

	if (character.physicsBody.velocity.y < -800)
	{
		character.physicsBody.velocity = ccp(0, -800);
	}
	else if (character.physicsBody.velocity.y > 200)
	{
		character.physicsBody.velocity = ccp(0, 200);
	}
	else
	{
		character.physicsBody.velocity = ccp(0, character.physicsBody.velocity.y);
	}

to

	if (character.physicsBody.velocity.y < -800)
	{
		character.physicsBody.velocity = ccp(80, -800);
	}
	else if (character.physicsBody.velocity.y > 200)
	{
		character.physicsBody.velocity = ccp(80, 200);
	}
	else
	{
		character.physicsBody.velocity = ccp(80, character.physicsBody.velocity.y);
	}

Now run the game again. You should see the character moving now!
