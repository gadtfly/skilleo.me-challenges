# Ruby 1.9.3 -> Ruby 2.0.0 polyfill/hack
module Enumerable
  def lazy_select(&block)
    Enumerator.new do |y|
      each do |x|
        y << x if block.call(x)
      end
    end
  end

  def lazy_map(&block)
    Enumerator.new do |y|
      each do |x|
        y << block.call(x)
      end
    end
  end

  def memoized
    results = []

    Enumerator.new do |y|
      results.each do |x|
        y << x
      end

      loop do
        x = self.next
        results << x
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

  PRIMES = (2..INFINITY).lazy_map(&:to_i).lazy_select(&:prime?).memoized

  def divisible?(n)
    modulo(n).zero?
  end

  def prime_divisors
    result = PRIMES.take_while{ |prime| prime <= self/2 }.select(&method(:divisible?))
    result << self if result.to_a.empty?
    result
  end

  def prime?
    return true if self == 2
    prime_divisors.first == self
  end

  def digits
    to_s.chars.map(&:to_i)
  end

  def greatest_prime_tailored_number
    (digits.monotonic? ? digits.product : self).prime_divisors.max
  end
end


# puts gets.to_i.greatest_prime_tailored_number
puts 133258.greatest_prime_tailored_number