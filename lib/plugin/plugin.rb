# Base plugin class. Any classes that extend Plugin are automatically
# loaded.
class Plugin
  class << self
    attr_reader :list
  end
  @list = []

  def self.inherited(klass)
    @list << klass.new
  end
end
