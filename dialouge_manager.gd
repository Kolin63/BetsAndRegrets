extends Node

func dia(index, Bubble):
	if (index == 0):
		return
		Bubble.say("You've lived a bad life, and now you're in the afterlife. You want a second chance, so you made a deal with the devil. You need to get 10 million dollars. You can get it by working for hundreds of years, or you could gamble it all for a chance to win BIG. Luckily, you have $5.32 from your wallet when you died. That's more than enough to gamble! And besides, most gamblers quit before they win big, so naturally, you won't quit, right? But be careful when you're gambling! If you lose too much, you'll be the devil's indentured servant...", 
		load("res://counterspellVoEdit/Counterspell Intro .wav"))
	elif (index == 1):
		Bubble.say("Well, I guess I better make some cash.", 
		load("res://counterspellVoEdit/Better make some cash.wav"))
	elif (index == 2):
		Bubble.say("What is this? Only?",
		load("res://counterspellVoEdit/Only $x-.wav"))
	# one zero
	elif (index == 3):
		Bubble.say("You ran out of money, game's over buddy...",
		load("res://counterspellVoEdit/Game over buddy.wav"))
		Bubble.say("N-no, please give me another chance. I... I'll give you a fourth of my soul, just please, give me another chance!",
		load("res://counterspellVoEdit/Another chance.wav"))
		Bubble.say("Alright, fine, but when your soul becomes mine, you become mine. Hahahaha...",
		load("res://counterspellVoEdit/You become mine .wav"))
	# two zero
	elif (index == 4):
		Bubble.say("Back again? You really wanna be my servant, don't you?",
		load("res://counterspellVoEdit/Back again.wav"))
		Bubble.say("I've really got to start being more careful with this...",
		load("res://counterspellVoEdit/Gotta be more careful .wav"))
	# three zero
	elif (index == 5):
		Bubble.say("Hahahaha! You've only got one shot left, after this, you'll be mine forever. snap",
		load("res://counterspellVoEdit/Only have 1 shot left.wav"))
		Bubble.say("N-no... I've really got to be more careful. I need to get back to my family",
		load("res://counterspellVoEdit/No, gotta be more careful .wav"))
	# win
	elif (index == 6):
		Bubble.say("Grr... You've won.. I'm a man of my word, you are free...",
		load("res://counterspellVoEdit/Grr you've won.wav"))
		Bubble.say("Yes, YES! I'm free. I'm so sorry for lying and cheating, I'll live life as a better man! I will no longer be my own worst enemy!",
		load("res://counterspellVoEdit/Yes i am free.wav"))
		Bubble.say("After the man was let free, he lived life to the best of his ability. He became a loving husband and a caring father. He volunteered at his local soup kitchen, and was a good person overall. He had stopped lying and cheating his way through life. He was no longer, his own worst enemy. ",
		load("res://counterspellVoEdit/Narrator win scenario .wav"))
	# lose
	elif (index == 7):
		Bubble.say("After the man was imprisoned, his body laid lifeless. He hadn't learned his lesson about being his own worst enemy. He served the devil for the rest of eternity. ",
		load("res://counterspellVoEdit/Narrator lose scenario .wav"))
