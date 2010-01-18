# tagreplacer - simple file based templating
#
# (C) 2009 Alex Beregszaszi
#
# $MIT License$

module Tagreplacer
  def Tagreplacer.Conv(file, tags, joker = '@@@@')
    raise Exception.new("Joker character must be at least one character long") if joker.length < 1
    raise Exception.new("Tags not a Hash table") if not tags.kind_of?(Hash)
    contents = File.read(file)
    raise Exception.new("File not found or empty") if contents == nil

    tags.each do |k, v|
      contents.gsub!("#{joker}#{k}#{joker}", v)
    end

    return contents
  end
end

#puts Tagreplacer::Conv("test.txt", { "hello" => "goodbye", "day" => "night"})
