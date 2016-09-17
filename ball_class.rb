class Ball < GameObject
  WIDTH = 25
  HEIGHT = 25

  attr_reader :v
  def initialize(x, y, v)
    @image = Gosu::Image.new("img/pangolin_0.png")
    super(x, y, WIDTH, HEIGHT)
    @v = v
  end



  def reflect_horizontal
    v[:x] = -v[:x]
  end

  def reflect_vertical
    v[:y] = -4
  end


  def update
    self.x += v[:x]
    self.y += v[:y]
    @gravity.act_on(self)
  end

  def draw
    @image.draw(100, 150, 1000, factor_x = 0.25, factor_y = 0.25, color = 0xffffffff, mode = :default)
  end

end
