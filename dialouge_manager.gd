extends Node


func dia(index, Bubble = get_tree().current_scene.Bubble):
	print(index)
	# intro
	if (index == 0):
		Bubble.say("You've lived a bad life, and now you're in the afterlife. You want a second chance, so you made a deal with the devil. You need to get 10 million dollars. You can get it by working for hundreds of years, or you could gamble it all for a chance to win BIG. Luckily, you have $5.32 from your wallet when you died. That's more than enough to gamble! And besides, most gamblers quit before they win big, so naturally, you won't quit, right? But be careful when you're gambling! If you lose too much, you'll be the devil's indentured servant...", 
		load("res://counterspellVoEdit/Counterspell Intro .wav"), index)
	elif (index == 0.1):
		Bubble.say("Well, I guess I better make some cash.", 
		load("res://counterspellVoEdit/Better make some cash.wav"), index)
	
	
	# Only x?
	elif (index == 2):
		Bubble.say("What is this? Only?",
		load("res://counterspellVoEdit/Only $x-.wav"), index)
	
	
	# one zero
	elif (index == 3):
		Bubble.say("You ran out of money, game's over buddy...",
		load("res://counterspellVoEdit/Game over buddy.wav"), index)
	elif (index == 3.1):
		Bubble.say("N-no, please give me another chance. I... I'll give you a fourth of my soul, just please, give me another chance!",
		load("res://counterspellVoEdit/Another chance.wav"), index)
	elif (index == 3.2):
		Bubble.say("Alright, fine, but when your soul becomes mine, you become mine. Hahahaha...",
		load("res://counterspellVoEdit/You become mine .wav"), index)
	
	
	# two zero
	elif (index == 4):
		Bubble.say("Back again? You really wanna be my servant, don't you?",
		load("res://counterspellVoEdit/Back again.wav"), index)
	elif (index == 4.1):
		Bubble.say("I've really got to start being more careful with this...",
		load("res://counterspellVoEdit/Gotta be more careful .wav"), index)
	
	
	# three zero
	elif (index == 5):
		Bubble.say("Hahahaha! You've only got one shot left, after this, you'll be mine forever.",
		load("res://counterspellVoEdit/Only have 1 shot left.wav"), index)
	elif (index == 5.1):
		Bubble.say("N-no... I've really got to be more careful. I need to get back to my family",
		load("res://counterspellVoEdit/No, gotta be more careful .wav"), index)
	
	
	# win
	elif (index == 6):
		Bubble.say("Grr... You've won.. I'm a man of my word, you are free...",
		load("res://counterspellVoEdit/Grr you've won.wav"), index)
	elif (index == 6.1):
		Bubble.say("Yes, YES! I'm free. I'm so sorry for lying and cheating, I'll live life as a better man! I will no longer be my own worst enemy!",
		load("res://counterspellVoEdit/Yes i am free.wav"), index)
	elif (index == 6.2):
		Bubble.say("After the man was let free, he lived life to the best of his ability. He became a loving husband and a caring father. He volunteered at his local soup kitchen, and was a good person overall. He had stopped lying and cheating his way through life. He was no longer, his own worst enemy. ",
		load("res://counterspellVoEdit/Narrator win scenario .wav"), index)
	
	
	# lose
	elif (index == 7):
		Bubble.say("After the man was imprisoned, his body laid lifeless. He hadn't learned his lesson about being his own worst enemy. He served the devil for the rest of eternity. ",
		load("res://counterspellVoEdit/Narrator lose scenario .wav"), index)
	elif (index == 7.1):
		get_tree().quit()
	
	
	# when he wins a day, has max souls, earnings are above 2x exclusive
	elif (index == 8):
		Bubble.say("I guess it's something",
		load("res://counterspellVoEdit/I guess it's something .wav"))
	
	# after he loses 3 times in a row, he has max souls
	elif (index == 9):
		Bubble.say("This game is rigged!",
		load("res://counterspellVoEdit/This game is rigged .wav"))
	
	# When he loses and no other conditions are met
	elif (index == 10):
		Bubble.say("%*$@!",
		load("res://counterspellVoEdit/-curse-.wav"))
	
	# after he wins and no other conditions are met
	elif (index == 11):
		Bubble.say("I won!",
		load("res://counterspellVoEdit/I won.wav"))
	
	
	
	else:
		print("exiting on " + str(index))
		Bubble.exit()
