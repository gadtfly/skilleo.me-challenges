# Ruby 1.9.3 -> Ruby 2.0.0 polyfill/hack
module Enumerable
  def lazy_select
    Enumerator.new do |y|
      each do |x|
        y << x if yield(x)
      end
    end
  end

  def lazy_map(&block)
    Enumerator.new do |y|
      each do |x|
        y << yield(x)
      end
    end
  end

  def memoized
    xs = []

    Enumerator.new do |y|
      xs.each do |x|
        y << x
      end

      loop do
        x = self.next
        xs << x
        y << x
      end
    end
  end
end




# Challenge code
class Array
  def monotonic?
    each_cons(2).all?{|x,y| x <= y}
  end

  def product
    inject(&:*)
  end
end



class Integer
  INFINITY = Float::INFINITY

  PRIMES = Enumerator.new do |y|
    e = (3..INFINITY).step(2).lazy_map(&:to_i).lazy_select(&:prime?)
    y << 2
    loop { y << e.next }
  end.memoized

  def divisible?(n)
    modulo(n).zero?
  end

  def prime_factors
    return [self] unless x = PRIMES.take_while{ |prime| prime <= Math.sqrt(self) }.find(&method(:divisible?))
    (self/x).prime_factors << x
  end

  def prime?
    prime_factors == [self]
  end

  def digits
    to_s.chars.map(&:to_i)
  end

  def greatest_prime_tailored_number
    (digits.monotonic? ? digits.product : self).prime_factors.max
  end
end

# gets = '1332'

puts gets.to_i.greatest_prime_tailored_number
