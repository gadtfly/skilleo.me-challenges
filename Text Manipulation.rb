# gets = 'Java is a server-side scripting language. Java code can be simply mixed with HTML code. After the Java code is interpreted and executed, the web server sends resulting output to its client.'

puts gets.gsub(/java/i, 'PHP').split(' ').map(&:capitalize).join(' ').split('.').map(&:strip).sort.join('.<br/>') << '.'
