require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'swearjar'
end

require "swearjar"

# ****************************************************
def read_in_txt_from_wordlist(list, line_count)
    sj = Swearjar.default
    lines = File.foreach(list).first(line_count) # return array of strings

    lines.select{|l| sj.profane?(l) == true}
end


badwords = read_in_txt_from_wordlist("john.txt", 2390)

badwords.each do |w|
    puts w
end
# ****************************************************