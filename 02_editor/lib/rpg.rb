require "bundler/setup"

Bundler.require

class RPG
  attr_accessor :window, :tiles, :world, :player

  def initialize(window)
    @window = window

    @tiles = {
      :misc => Gosu::Image.load_tiles(window, "assets/misc.png", 16, 16, true),
      :materials => Gosu::Image.load_tiles(window, "assets/materials.png", 16, 16, true)
    }

    @world = RPG::World.new(self)
    @player = RPG::PC.new(self)
  end

  def draw
    world.draw
    player.draw
  end

  def update
    player.update
  end
end

require "./lib/core_ext/numeric"

require "./lib/pc"
require "./lib/world"
require "./lib/world_block"
