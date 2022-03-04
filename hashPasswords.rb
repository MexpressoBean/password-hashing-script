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
    lines = File.foreach(list).first(line_count)
end

def create_hash_bcrypt(input)
    hash = BCrypt::Password.create(input)
end

def create_hash_scrypt(input)
    hash = SCrypt::Password.create(input)
end

def create_hash_sha256(input)
    hash = OpenSSL::Digest::SHA256.hexdigest input
end

def create_hash_sha512(input)
    hash = OpenSSL::Digest::SHA512.hexdigest input
end

def create_hash_md5(input)
    hash = OpenSSL::Digest::MD5.hexdigest input
end


# MAIN ******************************************************
text = "kevin"

array = read_in_txt_from_wordlist("john.txt", 10)

puts array

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
