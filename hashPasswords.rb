require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'axlsx', '~> 2.0', '>= 2.0.1'
  gem 'bcrypt', '~> 3.1', '>= 3.1.12'
  gem 'scrypt', '~> 2.0', '>= 2.0.2'
end

require 'axlsx'   # For spreadsheet creation
require 'openssl' # For sha256, sha512, & md5 hashing methods
require 'bcrypt'  # For bcrypt hashing method
require 'scrypt'  # For scrypt hashing method

# methods
def read_in_txt_from_wordlist(list, line_count)
    lines = File.foreach(list).first(line_count) # return array of strings
end

def create_password_objects(list, line_count)
    password_strings = read_in_txt_from_wordlist(list, line_count)
    pass_objects =[]

    password_strings.each_with_index do | element, index |
        case index
        when 0..300
          hashed_str = create_hash_md5(element.chomp)
          pass_objects << {question: "csukram#{index}:#{hashed_str[:hash]}", answer: "#{element.chomp}", list: "#{list}", encryption: "#{hashed_str[:alg]}"}
        when 301..600
          hashed_str = create_hash_sha256(element.chomp)
          pass_objects << {question: "csukram#{index}:#{hashed_str[:hash]}", answer: "#{element.chomp}", list: "#{list}", encryption: "#{hashed_str[:alg]}"}
        when 601..900
          hashed_str = create_hash_sha512(element.chomp)
          pass_objects << {question: "csukram#{index}:#{hashed_str[:hash]}", answer: "#{element.chomp}", list: "#{list}", encryption: "#{hashed_str[:alg]}"}
        when 901..1200
          hashed_str = create_hash_bcrypt(element.chomp)
          pass_objects << {question: "csukram#{index}:#{hashed_str[:hash]}", answer: "#{element.chomp}", list: "#{list}", encryption: "#{hashed_str[:alg]}"}
        when 1201..1500
          hashed_str = create_hash_scrypt(element.chomp)
          pass_objects << {question: "csukram#{index}:#{hashed_str[:hash]}", answer: "#{element.chomp}", list: "#{list}", encryption: "#{hashed_str[:alg]}"}
        else
          puts 'err'
        end

        puts "hashing: #{index}"
    end

    puts "Hashing complete!"

    pass_objects
end

# Hashing methods used:
# bcrypt, scrypt, sha-256, sha-512, md5
def create_hash_bcrypt(input)
    output = BCrypt::Password.create(input)
    {hash: output, alg: "bcrypt"}
end

def create_hash_scrypt(input)
    output = SCrypt::Password.create(input)
    {hash: output, alg: "scrypt"}
end

def create_hash_sha256(input)
    output = OpenSSL::Digest::SHA256.hexdigest input
    {hash: output, alg: "sha256"}
end

def create_hash_sha512(input)
    output = OpenSSL::Digest::SHA512.hexdigest input
    {hash: output, alg: "sha512"}
end

def create_hash_md5(input)
    output = OpenSSL::Digest::MD5.hexdigest input
    {hash: output, alg: "md5"}
end


# MAIN ******************************************************

row_data = create_password_objects("john.txt", 1500)

# row_data objects includes:
# question
# answer
# list
# encryption
# 
# END MAIN **************************************************

# Excel 
p = Axlsx::Package.new

# Required for use with numbers
p.use_shared_strings = true

p.workbook do |wb|
    # define your regular styles
    styles = wb.styles
    title = styles.add_style :sz => 15, :b => true, :u => true
    default = styles.add_style :border => Axlsx::STYLE_THIN_BORDER
    pascal_colors = { :bg_color => '567DCC', :fg_color => 'FFFF00' }
    pascal = styles.add_style pascal_colors.merge({ :border => Axlsx::STYLE_THIN_BORDER, :b => true })
    header = styles.add_style :bg_color => '00', :fg_color => 'FF', :b => true


    wb.add_worksheet(:name => 'CTC399 Password Hashes') do  |ws|
        ws.add_row ['CTC399 Password Hashes Questions - Kevin Ramirez (Student ID# 211141309)'], :style => title
        ws.add_row
        ws.add_row ['Questions', 'Answers', 'Wordlist', 'Encryption'], :style => header

        row_data.each do |p|
            ws.add_row [p[:question], p[:answer], p[:list], p[:encryption]]
        end
        
        ws.column_widths 96, 26, 15, 25 
    end
end
p.serialize 'test.xlsx'
