extends Node

var Bubble

var dialogue_queue = []
var previous_dialogue = -1


func _process(delta):
	if (dialogue_queue.size() != 0 && !Bubble.Dialogue.playing):
		next_dia()


func set_man(animation):
	var Man = get_parent().Man
	if (animation == "hide"):
		Man.get_parent().visible = false
	else:
		Man.get_parent().visible = true
		Man.animation = animation


func set_volume(db):
	Bubble.Dialogue.volume_db = db


func set_music_volume(db):
	Bubble.Music.volume_db = db


# Test dialogue, starting at specific line
# Only for debugging purposes
var test_index = 0
func test(index = 0):
	if (index > test_index):
		test_index = index
	
	dia(test_index)
	
	test_index += 1


func set_bubble(b):
	Bubble = b


# This only QUEUES the index, it doesn't actually run it
func dia(index):
	dialogue_queue.append(index)
	
	if (!Bubble.Dialogue.playing):
		next_dia()

# Shift queue, overriding 1st element
func shift_dia():
	for i in range(1, dialogue_queue.size()):
		dialogue_queue[i - 1] = dialogue_queue[i]
	dialogue_queue.remove_at(dialogue_queue.size() - 1)


# This calls the 1st element, clears it, and shifts all elements
func next_dia():
	if (dialogue_queue.size() == 0):
		Bubble.exit()
		return
	do_dia(dialogue_queue[0])
	
	shift_dia()


# This is the one that runs it
func do_dia(index):
	set_volume(0)
	set_music_volume(0)
	
	# Prevents Sequential Dialogue 
	if (index == previous_dialogue):
		Bubble.exit()
		set_man("think")
		return
	
	# intro
	elif (index == 0):
		Bubble.say("You've lived a bad life, and now you're in the afterlife. You want a second chance, so you made a deal with the devil. You need to get 10 million dollars. You can get it by working for hundreds of years, or you could gamble it all for a chance to win BIG. Luckily, you have $5.32 from your wallet when you died. That's more than enough to gamble! And besides, most gamblers quit before they win big, so naturally, you won't quit, right? But be careful when you're gambling! If you lose too much, you'll be the devil's indentured servant...", 
		load("res://counterspellVoEdit/Counterspell Intro .wav"), 
		index,
		load("res://music/Loser of a single match.mp3"))
		set_man("hide")
	elif (index == 0.1):
		Bubble.say("Well, I guess I better make some cash.", 
		load("res://counterspellVoEdit/Better make some cash.wav"), 
		index,
		null)
		set_man("talking")
		
		get_parent().is_intro = false
	
	# Only x?
	elif (index == 2):
		Bubble.say("What is this? Only?",
		load("res://counterspellVoEdit/Only $x-.wav"), 
		index,
		)
		set_man("sad")
	
	# one zero
	elif (index == 3):
		Bubble.say("You ran out of money, game's over buddy...",
		load("res://counterspellVoEdit/Game over buddy.wav"), 
		index,
		load("res://music/Dnd is satanic.mp3"))
		set_man("devil_talk")
	elif (index == 3.1):
		Bubble.say("N-no, please give me another chance. I... I'll give you a fourth of my soul, just please, give me another chance!",
		load("res://counterspellVoEdit/Another chance.wav"), 
		index,
		)
		set_man("miserable")
	elif (index == 3.2):
		Bubble.say("Alright, fine, but when your soul becomes mine, you become mine. Hahahaha...",
		load("res://counterspellVoEdit/You become mine .wav"), 
		index,
		)
		set_man("devil_talk")
	elif (index == 3.2 + 0.1):
		set_man("devil_normal")
		set_music_volume(13)
		await get_parent().remove_soul(true)
	elif (index == 3.2 + 0.1 + 0.1):
		Bubble.say("At least I'm not back where I started...",
		load("res://counterspellVoEdit/Back to start.wav"),
		index,
		null)
		set_man("talking")
	
	# two zero
	elif (index == 4):
		Bubble.say("Back again? You really wanna be my servant, don't you?",
		load("res://counterspellVoEdit/Back again.wav"), 
		index,
		load("res://music/Dnd is satanic.mp3"))
		set_man("devil_talk")
	elif (index == 4.1):
		set_man("devil_normal")
		set_music_volume(13)
		await get_parent().remove_soul()
	elif (index == 4.2):
		Bubble.say("I've really got to start being more careful with this...",
		load("res://counterspellVoEdit/Gotta be more careful .wav"), 
		index,
		null)
		set_man("miserable")
	
	# three zero
	elif (index == 5):
		Bubble.say("Hahahaha! You've only got one shot left, after this, you'll be mine forever.",
		load("res://counterspellVoEdit/Only have 1 shot left.wav"), 
		index,
		load("res://music/Dnd is satanic.mp3"))
		set_man("devil_talk")
	elif (index == 5.1):
		set_man("devil_normal")
		set_music_volume(13)
		await get_parent().remove_soul()
	elif (index == 5.1 + 0.1):
		Bubble.say("N-no... I've really got to be more careful. I need to get back to my family",
		load("res://counterspellVoEdit/No, gotta be more careful .wav"), 
		index,
		null)
		set_man("miserable")
		set_volume(20)
	
	# win
	elif (index == 6):
		Bubble.say("Grr... You've won.. I'm a man of my word, you are free...",
		load("res://counterspellVoEdit/Grr you've won.wav"), 
		index,
		null)
		set_man("devil_talk")
		set_volume(24)
	elif (index == 6.1):
		Bubble.say("Yes, YES! I'm free. I'm so sorry for lying and cheating, I'll live life as a better man! I will no longer be my own worst enemy!",
		load("res://counterspellVoEdit/Yes i am free.wav"), 
		index,
		load("res://music/celebrating when you win a match.mp3"))
		set_man("happy")
	elif (index == 6.1 + 0.1):
		Bubble.say("After the man was let free, he lived life to the best of his ability. He became a loving husband and a caring father. He volunteered at his local soup kitchen, and was a good person overall. He had stopped lying and cheating his way through life. He was no longer, his own worst enemy. ",
		load("res://counterspellVoEdit/Narrator win scenario .wav"), 
		index,
		)
		set_man("hide")
		set_volume(24)
	elif (index == 6.1 + 0.1 + 0.1):
		get_tree().change_scene_to_file("res://win.tscn")
	
	# lose
	elif (index == 7):
		Bubble.say("After the man was imprisoned, his body laid lifeless. He hadn't learned his lesson about being his own worst enemy. He served the devil for the rest of eternity. ",
		load("res://counterspellVoEdit/Narrator lose scenario .wav"), 
		index,
		load("res://music/Soulless.mp3"))
		set_man("hide")
	elif (index == 7.1):
		set_man("devil_normal")
		set_music_volume(13)
		await get_parent().remove_soul(true)
	# fades out as he becomes the devil's servant, game over screen
	elif (index == 7.1 + 0.1):
		Bubble.say("No... No. NOOOOO!!!",
		load("res://counterspellVoEdit/No!!!.wav"),
		index,
		)
		set_man("dead")
	elif (index == 7.1 + 0.1 + 0.1):
		get_tree().change_scene_to_file("res://lose.tscn")
	
	# when he wins a day, has max souls, earnings are above 2x exclusive
	elif (index == 8):
		Bubble.say("I guess it's something",
		load("res://counterspellVoEdit/I guess it's something .wav"),
		index)
		set_man("talking")
		set_volume(20)
	
	# after he loses 3 times in a row, he has max souls
	elif (index == 9):
		Bubble.say("This game is rigged!",
		load("res://counterspellVoEdit/This game is rigged .wav"),
		index)
		set_man("sad")
	
	# When he loses and no other conditions are met
	elif (index == 10):
		var rand = randi_range(0, 1)
		if (rand == 0):
			Bubble.say("%*$@!",
			load("res://counterspellVoEdit/-curse-.wav"),
			index)
			set_volume(15)
		elif (rand == 1):
			Bubble.say("How am I supposed to get 10 MILLION DOLLARS?",
			load("res://counterspellVoEdit/10M.wav"),
			index)
		set_man("sad")
	
	
	# after he wins and no other conditions are met
	elif (index == 11):
		var rand = randi_range(0, 1)
		if (rand == 0):
			Bubble.say("I won!",
			load("res://counterspellVoEdit/I won.wav"),
			index)
		elif (rand == 1):
			Bubble.say("Finally!",
			load("res://counterspellVoEdit/Finally.wav"),
			index)
		set_man("happy")
	
	# When day 7 starts
	elif (index == 14):
		Bubble.say("C'mon lucky 7!",
		load("res://counterspellVoEdit/Lucky 7.wav"),
		index)
		set_man("happy")
	
	# After he loses a day after losing 2 souls
	elif (index == 15):
		var rand = randi_range(0, 1)
		if (rand == 0):
			Bubble.say("I miss my family...",
			load("res://counterspellVoEdit/Miss family .wav"),
			index)
		elif (rand == 1):
			Bubble.say("It's okay, I can get it back... ",
			load("res://counterspellVoEdit/I can get it back....wav"),
			index)
		set_man("sad")
	
	# After he wins a day after losing 2 souls
	elif (index == 16):
		var rand = randi_range(0, 1)
		if (rand == 0):
			Bubble.say("Oh! Oh yes! There is hope!",
			load("res://counterspellVoEdit/Oh yes hope.wav"),
			index)
			set_volume(24)
		elif (rand == 1):
			Bubble.say("D-do I have a chance? ",
			load("res://counterspellVoEdit/D-do I have a chance.wav"),
			index)
		set_man("happy")
	
	# when he loses a day after he lost 3 souls
	elif (index == 17):
		var rand = randi_range(0, 1)
		if (rand == 0):
			Bubble.say("I'm so sorry for being a liar, this is why I'm here...",
			load("res://counterspellVoEdit/Im sorry liar .wav"),
			index)
			set_volume(24)
		elif (rand == 1):
			Bubble.say("Cheating at life landed me here... ",
			load("res://counterspellVoEdit/Cheating .wav"),
			index)
		set_man("sad")
	
	# when he wins and is above 9M
	elif (index == 18):
		Bubble.say("I'm so close!",
		load("res://counterspellVoEdit/So close .wav"),
		index)
		set_man("talking")
	
	# when he loses and goes below 9M
	elif (index == 19):
		Bubble.say("I was so close!",
		load("res://counterspellVoEdit/I was so close! .wav"),
		index)
		set_man("sad")
	
	# when he wins a day after losing 3 souls
	elif (index == 20):
		Bubble.say("YES, YES! I HAVE A CHANCE",
		load("res://counterspellVoEdit/I have a chance .wav"),
		index)
		set_man("happy")
		set_volume(24)
	
	else:
		Bubble.exit()
		set_man("think")
		return
	
	dialogue_queue.append(float(index) + 0.1)
	previous_dialogue = index
