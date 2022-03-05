require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'swearjar'
end

require "swearjar"

# ****************************************************
def filter_out_profanity(list, line_count)
    sj = Swearjar.default
    lines = File.foreach(list).first(line_count) # return array of strings

    lines.select{|l| sj.profane?(l) == true}
end


badwords = filter_out_profanity("john.txt", 1500)

badwords.each do |w|
    puts w
end
# ****************************************************