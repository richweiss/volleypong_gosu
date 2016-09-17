class Ball < GameObject
  WIDTH = 25
  HEIGHT = 25

  attr_reader :v
  def initialize(x, y, v)
    super(x, y, WIDTH, HEIGHT)
    @v = v
  end



  def reflect_horizontal
    v[:x] = -v[:x]
  end

  def reflect_vertical
    v[:y] = -4
  end

  def gravity



  end

  def update
    self.x += v[:x]
    self.y += v[:y]
    @gravity.act_on(self)
  end

  def draw
    Gosu.draw_rect x, y, WIDTH, HEIGHT, Gosu::Color::RED
  end

end
