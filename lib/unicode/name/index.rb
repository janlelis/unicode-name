require 'rubygems/util'
require_relative 'constants'

module Unicode
  module Name
    INDEX = Marshal.load(Gem::Util.gunzip(File.binread(INDEX_FILENAME)))
  end
end
