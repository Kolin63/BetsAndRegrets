extends Control
var dialogue1
var dialogue2
var dialogue3
var dialogue4
var dialogue5
var dialogue6
var dialogue7
var dialogue8
var dialogue9
var dialogue10
var dialogue11
var dialogue12
var dialogue13
var dialogue14
var dialogue15
var dialogue16
var dialogue17
var dialouge= {
	dialogue1:"Well, I better get some cash", #(at the start)
	dialogue2:"What is this? Only $x? ",#(when he wins a day, he has max souls, the earnings are between 1x and 2x)
	dialogue3:"I guess it's something ",#(when he wins a day, has max souls, earnings are above 2x exclusive)
	dialogue4:"This game is rigged!",# (after he loses 3 times in a row, he has max souls)
	dialogue5:"%*$@! ",#(When he loses and no other conditions are met, max souls)
	dialogue6:"How am I supposed to get 10 MILLION DOLLARS?",
	dialogue7:"No... No. NOOOOO!!!",#(fades out as he becomes the devil's servant, game over screen)
	dialogue8:"Devil: You ran out of money, game's over buddy...",#. (When you lose the soul for the 1st time)
	dialogue9:"N-no, please give me another chance. I... I'll give you a fourth of my soul, just please, give me another chance!",# (When you lose your first soul)
	dialogue10:"Devil: Alright, fine, but when your soul becomes mine, you become mine. Hahahaha... ",#(After you offer your soul)
	dialogue11:"At least I'm not back where I started...",# (after he loses his first soul)
	dialogue12:"Back again? You really wanna be my servant, don't you?",#(When he loses his seconds soul, he snaps, screen flashes white and fades back to game as transition for all soul losses)
	dialogue13:"I've really got to start being more careful with this...",#(After he loses his second soul)
	dialogue14:"I miss my family... ",#(After he loses a day after losing 2 souls)
	dialogue15:"Hahahaha! You've only got one shot left, after this, you'll be mine forever. snap",#(After he loses his third soul)
	dialogue16:"shakey voice N-no... I've really got to be more careful. I need to get back to my family",#(after he loses his third soul)
	dialogue17:"gasp YES, YES! I HAVE A CHANCE",# (when he wins a day after losing 3 souls)
	
}
