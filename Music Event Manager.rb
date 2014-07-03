require 'json'
require 'ostruct'
require 'date'

class Date
  def self.parse_yearless(s)
    self.parse(s << '-2014')
  end
end

class Band < OpenStruct
  def availability
    Range.new(*self.date_range.split('/').map(&Date.method(:parse_yearless)))
  end
end

class Show < OpenStruct
  def show_date # so-named because ostruct sucks in Ruby 1.9
    Date.parse_yearless(date)
  end

  def available?(band)
    style == band.style && band.availability.cover?(show_date)
  end

  def count_available(bands)
    bands.count(&method(:available?))
  end

  def output_for(bands)
    "#{id}-#{count_available(bands)}"
  end
end

# gets = '{"bands" : [{"id" : "1", "style" : "Rock", "date_range" : "01-05/15-05"}, {"id" : "2", "style" : "Hip Hop", "date_range" : "05-05/08-05"}], "shows" : [{"id" : "1", "style" : "Rock", "date" : "05-05"}, {"id" : "2", "style" : "Hip Hop", "date" : "01-05"}, {"id" : "3", "style" : "Classic", "date" : "18-05"}]}'

json = JSON.parse(gets, symbolize_names: true)
bands = json[:bands].map(&Band.method(:new))
shows = json[:shows].map(&Show.method(:new))
puts shows.map{|show| show.output_for(bands)}.join(',')
