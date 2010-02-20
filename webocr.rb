# Interface to http://asv.aso.ecei.tohoku.ac.jp/tesseract/
#
# Terms and conditions: http://asv.aso.ecei.tohoku.ac.jp/tesseract/terms.html
#
# (C) 2010 Alex Beregszaszi
#
# $MIT License$

require 'rubygems'
require 'rest_client'

module WebOCR
  def self.process(image)
    # For proper multipart post, the image object must respond to read and path, like the File class does
    raise Exception.new("Image object must respond to read and path") if not (image.respond_to?(:read) and image.respond_to?(:path))

    result = RestClient.post 'http://asv.aso.ecei.tohoku.ac.jp/cgi-bin/weocr/submit_tesseract.cgi',
      { :userfile => image,
        :outputencoding => 'utf-8',
        :outputformat => 'html',
        :multipart => true},
      { 'User-Agent' => 'Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 6.0; Ruby WebOCR)',
        'Referer' => 'http://asv.aso.ecei.tohoku.ac.jp/tesseract/' }
    
    code = result.scan(/Recognition result:.+<pre>(.*)<\/pre>/m).flatten[0]
    code.strip! if code
    nil if not code.length
  end
end