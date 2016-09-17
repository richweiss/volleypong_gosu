require 'gosu'

class MyWindow < Gosu::Window
  def initialize
    super(1280, 800)
    self.caption = 'Volley-Pong!'
    @ball = Ball.new( 100, 500, { :x => 8, :y => 8 })
    @player1 = Player.new( 50, 750, { :y => 0 }, Gosu::Color::YELLOW)
    @player2 = Player.new( 1050, 750, { :y => 0 }, Gosu::Color::GREEN)

  end

  def update
    @ball.update

    if @ball.x <= 0

      @ball.v[:x] = 4

    elsif @ball.right >= self.width
      @ball.v[:x] = -4
    end
    @ball.reflect_vertical if @ball.y < 0 || @ball.bottom > self.height
  end

  def draw
    @ball.draw
    @player1.draw
    @player2.draw
  end

end

class GameObject
  attr_accessor :x
  attr_accessor :y
  attr_accessor :w
  attr_accessor :h

  def initialize(x, y, w, h)
    @x = x
    @y = y
    @w = w
    @h = h
    @gravity = Gravity.new
  end

  def left
    x
  end

  def right
    x + w
  end

  def right=(r)
    self.x = r - w
  end

  def top
    y
  end

  def top=(t)
    self.y = t
  end

  def bottom
    y + h
  end

  def center_y
    y + h/2
  end

  def center_x
    x + x/2
  end

  def bottom=(b)
    self.y = b - h
  end

  def collide?(other)
    x_overlap = [0, [right, other.right].min - [left, other.left].max].max
    y_overlap = [0, [bottom, other.bottom].min - [top, other.top].max].max
    x_overlap * y_overlap != 0
  end
end

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

  def gravity



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

class Gravity

  def initialize
    @grav_constant = 4;
  end

  def act_on(thing)

    if thing.v[:y] < @grav_constant
      thing.v[:y] += (0.0167 * 4) #1 second to increase by 1

    elsif thing.v[:y] > @grav_constant
      thing.v[:y] = @grav_constant

    end

  end
end

window = MyWindow.new
window.show
