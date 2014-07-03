require 'digest'

# Stupid Ruby 1.9.3
class Object
  def replicate(n)
    [self].cycle(n)
  end
end

module Enumerable
  def sequence
    inject([[]]) do |m, m_p|
      m.flat_map do |x|
        m_p.flat_map do |xs|
          [x+[xs]]
        end
      end
    end
  end

  def replicateM(n)
    replicate(n).sequence
  end

  alias repeated_permutation replicateM
end


# Challenge code
ALPHABET   = 'abc0123'
MAX_LENGTH = 4

# gets = '81b5dd04bf5cbc172eeb34bb8062fde1'

dictionary = (1..MAX_LENGTH).flat_map{ |l| ALPHABET.chars.repeated_permutation(l).map(&:join)}
target = gets
puts dictionary.find{ |s| Digest::MD5.hexdigest(s) == target }
