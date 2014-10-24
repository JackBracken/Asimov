Dir[File.dirname(__FILE__) + '/plugin/*.rb'].each { |file| require_relative file }

# PluginLoader loads all .rb from plugin dir when instantiated.
class PluginLoader
  def initialize
    Plugin.list.each do |i|
      i.class.new
    end
  end
end

PluginLoader.new
