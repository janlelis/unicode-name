# frozen_string_literal: true

module Unicode
  module Name
    VERSION = "1.14.0"
    UNICODE_VERSION = "17.0.0"
    DATA_DIRECTORY = File.expand_path(File.dirname(__FILE__) + "/../../../data/").freeze
    INDEX_FILENAME = (DATA_DIRECTORY + "/name.marshal.gz").freeze
  end
end
