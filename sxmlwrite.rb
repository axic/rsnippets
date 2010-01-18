# SXMLWrite - Simple XML writer for Ruby
#
# (C) 2009 Alex Beregszaszi
#
# $MIT License$

module SXMLWrite
  class XML
    def initialize
      @content = []
    end

    def <<(item)
      @content << item if item != nil
    end

    def to_s
      out = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"

      @content.each do |e|
        out += e.to_s(0)
      end

      out
    end
  end

  class Node
    attr_accessor :name
    attr_accessor :attribtues
    attr_accessor :content

    def initialize(name, attributes = nil, content = nil)
      @name = name
      @attributes = attributes
      @content = content
      @children = []
    end

    def <<(child)
      @children << child if child != nil
    end

    def to_s(level = 0)
      if (@content == nil || @content.length == 0) && @children.length == 0
        return tidy(level, "<#{@name} />")
      end
      
      out = tidy(level, "<#{header}>")
      
      if @content != nil and @content.length > 0
        if @content.instance_of?(Hash)
          out += "\n#{dump_hash(level+1, @content)}"
        else
          out += @content.to_s
        end
      end

      out += "\n" if @children.length > 0
      @children.each do |e|
        if e.instance_of?(Hash)
          out += dump_hash(level+1, e)
        else
          out += "#{e.to_s(level+1)}\n"
        end
      end
      
      out += tidy(level, "</#{@name}>")
    end

    private
    def header()
      out = "#{@name}"

      if @attributes != nil and @attributes.length > 0
        out += " "

        @attributes.each do |k, v|
          out += "#{k}=\"#{v}\""
        end
      end

      out
    end

    def tidy(level, text)
      out = ""
      level.times { out += "  " }
      out += "#{text}"
    end

    def dump_hash(level, hash)
      out = ""
      hash.each do |k, v|
        if v == nil
          out += tidy(level, "<#{k} />\n")
        else
          out += tidy(level, "<#{k}>#{v}</#{k}>\n")
        end
      end
      out
    end
  end
end
