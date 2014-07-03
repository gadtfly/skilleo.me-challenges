# gets = '#bro Woow awesome #pic dude #lmao #omg ###keyword #2Words!? some#word .?!#word'

puts gets.scan(/(?:^|\s|#)#([a-zA-Z0-9]+)/).join(',')
