# Simple class for working with Captchas.net
#
# (C) 2009 Alex Beregszaszi
#
# $MIT License$

require 'digest/md5'

class Captchasnet
  def initialize(username, secret)
    raise Exception.new("Username and Secret are mandatory") if username == nil or secret == nil

    @username = username
    @secret = secret
  end

  # Originally written by Richard L. Apodaca
  # http://depth-first.com/articles/2007/09/03/fighting-spam-on-the-cheap-with-captcha-a-simple-ruby-library-for-captchas-net
  def get_text(random, alphabet = 'abcdefghijklmnopqrstuvwxyz', character_count = 6)
    if character_count < 1 || character_count > 16
      raise "Character count of #{character_count} is outside the range of 1-16"
    end

    input = "#{@secret}#{random}"

    if alphabet != 'abcdefghijklmnopqrstuvwxyz' || character_count != 6
      input <<  ":#{alphabet}:#{character_count}"
    end

    bytes = Digest::MD5.hexdigest(input).slice(0..(2*character_count - 1)).scan(/../)
    text = ''

    bytes.each { |byte| text << alphabet[byte.hex % alphabet.size].chr }

    text
  end

  def get_url(random)
    "http://image.captchas.net/?client=#{@username}&random=#{random}"
  end

  def generate_password(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    password = ""
    len.times { password << chars[rand(chars.size-1)] }
    password
  end

  def giveme(random = nil)
    random = generate_password(10) if random == nil
    {:text => get_text(random), :url => get_url(random)}
  end
end
