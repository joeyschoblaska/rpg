require "./lib/rpg"

class GameWindow < Gosu::Window

  def initialize
    super(16 * 64, 16 * 36, false)
    self.caption = "Editor"
    @rpg = RPG.new
  end

  def cursor
    TILES[:misc][92]
  end

  def draw
    @rpg.draw(self)
    cursor.draw(mouse_x, mouse_y, 100, 1, 1, 0xffffff00)
  end

  def update
    @rpg.update(self)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @rpg.world.set_block(mouse_tile_x, mouse_tile_y, :water) if id == Gosu::KbW
    @rpg.world.set_block(mouse_tile_x, mouse_tile_y, :grass) if id == Gosu::KbG
    @rpg.world.set_block(mouse_tile_x, mouse_tile_y, :mud) if id == Gosu::KbM
  end

  def mouse_tile_x
    ((left * 16 + mouse_x) / 16).to_i
  end

  def mouse_tile_y
    ((top * 16 + mouse_y) / 16).to_i
  end

  def top
    min_top = 0
    max_top = RPG::World::ROWS - height / 16

    (@rpg.player.y - height / 16 / 2).restrict(min_top, max_top)
  end

  def bottom
    min_bottom = height / 16
    max_bottom = RPG::World::ROWS - 1

    (@rpg.player.y + height / 16 / 2).restrict(min_bottom, max_bottom)
  end

  def left
    min_left = 0
    max_left = RPG::World::COLS - width / 16

    (@rpg.player.x - width / 16 / 2).restrict(min_left, max_left)
  end

  def right
    min_right = width / 16
    max_right = RPG::World::COLS - 1

    (@rpg.player.x + width / 16 / 2).restrict(min_right, max_right)
  end
end

window = GameWindow.new

TILES = {
  :misc => Gosu::Image.load_tiles(window, "assets/misc.png", 16, 16, true),
  :materials => Gosu::Image.load_tiles(window, "assets/materials.png", 16, 16, true)
}

window.show
