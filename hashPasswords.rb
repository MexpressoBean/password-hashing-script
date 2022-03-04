# 1. get text from file
# 2. hash the text with different hash algos
# 3. create objects with all neccessary info (Q, ans, wordlist, encryption)
# 4. add rows and use objects to fill in columns

# Hashing methods used:
# bcrypt, scrypt, sha-256, sha-512, md5

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'axlsx', '~> 2.0', '>= 2.0.1'
  gem 'bcrypt', '~> 3.1', '>= 3.1.12'
  gem 'scrypt', '~> 2.0', '>= 2.0.2'
end

require 'axlsx'
require 'openssl'
require 'bcrypt'
require 'scrypt'

# methods
def read_in_txt_from_wordlist(list, line_count)
    lines = File.foreach(list).first(line_count) # return array of strings
end

def create_password_objects(list, line_count)
    password_strings = read_in_txt_from_wordlist(list, line_count)
    pass_objects = {}

    password_strings.each_with_index do | element, index |
        hashed_str = create_hash_md5(element.chomp)

        puts "Hash: csukram#{index}:#{hashed_str[:hash]}, Answer: #{element.chomp}, List: #{list}, Encryption: #{hashed_str[:alg]}"
    end
end

def create_hash_bcrypt(input)
    output = BCrypt::Password.create(input)
    {hash: output, alg: "bcrypt"}
end

def create_hash_scrypt(input)
    output = SCrypt::Password.create(input)
end

def create_hash_sha256(input)
    output = OpenSSL::Digest::SHA256.hexdigest input
end

def create_hash_sha512(input)
    output = OpenSSL::Digest::SHA512.hexdigest input
end

def create_hash_md5(input)
    output = OpenSSL::Digest::MD5.hexdigest input
    {hash: output, alg: "md5"}
end


# MAIN ******************************************************

create_password_objects("john.txt", 10)

# END MAIN **************************************************

# # Excel 
# p = Axlsx::Package.new

# # Required for use with numbers
# p.use_shared_strings = true

# p.workbook do |wb|
#     # define your regular styles
#     styles = wb.styles
#     title = styles.add_style :sz => 15, :b => true, :u => true
#     default = styles.add_style :border => Axlsx::STYLE_THIN_BORDER
#     pascal_colors = { :bg_color => '567DCC', :fg_color => 'FFFF00' }
#     pascal = styles.add_style pascal_colors.merge({ :border => Axlsx::STYLE_THIN_BORDER, :b => true })
#     header = styles.add_style :bg_color => '00', :fg_color => 'FF', :b => true


#     wb.add_worksheet(:name => 'CTC399 Password Hashes') do  |ws|
#         ws.add_row ['CTC399 Password Hashes Questions - Kevin Ramirez (Student ID# 211141309)'], :style => title
#         ws.add_row
#         ws.add_row ['Questions', 'Answers', 'Wordlist', 'Encryption'], :style => header

#         for a in 0..3 do 
#             ws.add_row ['password hash', 'password', 'wordlist', 'sha-256']
#         end
        
#         ws.column_widths 96, 26, 31, 25 
#     end
# end
# p.serialize 'test.xlsx'
