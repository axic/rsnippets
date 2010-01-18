# Extend File class with a safe_join function
#
# (C) 2009 Alex Beregszaszi
#
# $MIT License$

def File.safe_join(*args)
  out = ''
  # merge all sub arrays, this way we can accept multi level arrays as input
  args.flatten!
  args.each_with_index do |item, index|
    raise Exception.new("Only Strings are accepted") if not item.kind_of?(String)
  	out = '/' if index == 0 and item[0] == 47 #'/'
  	out += item.gsub(/(\/+)/, '')
  	# if not last or last entry has / as latest character
  	out += '/' if (index < args.length-1) or item[item.length-1] == 47 #'/'
  end
  out
end

#puts File.safe_join("//one//", "two", "/three/", "four", "//five//")
#puts File.safe_join(["/one//", "///two////", ["three//"]], "four", "five/")
