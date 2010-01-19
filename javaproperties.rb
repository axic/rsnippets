# Downloaded from http://devender.wordpress.com/2006/05/01/reading-and-writing-java-property-files-with-ruby/

class JavaProperties
  attr_accessor :file, :properties

  def initialize(file)
    @file = file
    @properties = {}

    begin
      IO.foreach(file) do |line|
        @properties[$1.strip] = $2 if line = ~ /([^=]*)=(.*)\/\/(.*)/ || line =~ /([^=]*)=(.*)/
      end
    rescue
    end
  end

  def to_s
    output = "File name #{@file}\n"
    @properties.each { |key, value| output += " #{key} = #{value}\n" }
    output
  end

  def add(key, value)
    return unless key.length > 0 and value.length > 0
    @properties[key] = value
  end

  def save
    file = File.new(@file, "w+")
    @properties.each { |key, value| file.puts "#{key}=#{value}\n" }
    file.close
  end
end
