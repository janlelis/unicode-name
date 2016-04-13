require_relative "../name"

class String
  # Optional string extension for your convenience
  def unicode_name
    Unicode::Name.of(self)
  end
end
