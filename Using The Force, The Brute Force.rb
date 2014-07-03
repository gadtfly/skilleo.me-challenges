require 'digest'

# Stupid Ruby 1.9.3
class Object
  def replicate(n)
    [self].cycle(n)
  end
end

module Enumerable
  def sequence
    inject([[]]) do |yss, xs|
      yss.flat_map do |ys|
        xs.flat_map do |x|
          [ys+[x]]
        end
      end
    end
  end

  def replicateM(n)
    replicate(n).sequence
  end

  alias cartesian_product    sequence
  alias cartesian_power      replicateM
  alias repeated_permutation replicateM
end


# Challenge code
ALPHABET   = 'abc0123'
MAX_LENGTH = 4

# gets = '81b5dd04bf5cbc172eeb34bb8062fde1'

dictionary = (1..MAX_LENGTH).flat_map{ |l| ALPHABET.chars.repeated_permutation(l).map(&:join)}
target = gets
puts dictionary.find{ |s| Digest::MD5.hexdigest(s) == target }
