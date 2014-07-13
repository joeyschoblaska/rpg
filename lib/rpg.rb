require "bundler/setup"

Bundler.require

class RPG
  attr_accessor :window, :tiles, :world

  def initialize(window)
    @window = window
    @tiles = Gosu::Image.load_tiles(window, "assets/tiles.png", 16, 16, true)
    @world = RPG::World.new(self)
  end
end

require "./lib/world"