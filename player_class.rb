class Player < GameObject
  WIDTH = 75
  HEIGHT = 50

  def initialize(x, y, v, color)
    super(x, y, WIDTH, HEIGHT)
    @v = v
    @color = color
  end

  def update
    @gravity.self
  end

  def draw
    Gosu.draw_rect x, y, WIDTH, HEIGHT, @color
  end

end
