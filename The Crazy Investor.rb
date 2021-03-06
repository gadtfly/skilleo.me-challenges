WORD = "SKILLEO"

class SoupLetter
  def initialize(s, w=6, h=6)
    @s = s
    @w, @h = w, h
  end

  def find(c)
    n = @s.index(c)
    r = n / @h + 1
    c = n % @w + 1
    "#{r}#{c}"
  end
end

# gets = 'NO70JE3A4Z28X1GBQKFYLPDVWCSHUTM65R9I'

puts WORD.chars.map(&SoupLetter.new(gets).method(:find)).join
