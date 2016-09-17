require 'gosu'

class MyWindow < Gosu::Window
  attr_accessor :height
  attr_accessor :width

  def initialize
    super(1280, 800)
    self.caption = 'Volley-Pong!'
    @ball = Ball.new( 100, 500, { :x => 8, :y => 8 })
    @player1 = Player.new( 50, 750, { :y => 0 }, Gosu::Color::YELLOW)
    @player2 = Player.new( 1050, 750, { :y => 0 }, Gosu::Color::GREEN)
    @net = Net.new(600, 700, 80, 80)
    @height = 800
    @width = 1280
    @player_speed = 8
  end

  def update


    @player1.update
    @player2.update

    if Gosu::button_down? Gosu::KbA or Gosu::button_down? Gosu::GpLeft then
      @player1.x += -@player_speed
    end
    if Gosu::button_down? Gosu::KbD or Gosu::button_down? Gosu::GpRight then
      @player1.x += @player_speed
    end
    if Gosu::button_down? Gosu::KbW or Gosu::button_down? Gosu::GpRight then
      @player1.y += -@player_speed
    end
    if Gosu::button_down? Gosu::KbS or Gosu::button_down? Gosu::GpRight then
      @player1.y += @player_speed
    end
    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
      @player2.x += -@player_speed
    end
    if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
      @player2.x += @player_speed
    end
    if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
      @player2.y += -@player_speed
    end
    if Gosu::button_down? Gosu::KbDown or Gosu::button_down? Gosu::GpButton0 then
      @player2.y += @player_speed
    end


    @ball.update

    if @ball.x <= 0

      @ball.v[:x] = 8

    elsif @ball.right >= self.width
      @ball.v[:x] = -8
    end

    if @ball.collide?(@player1)
      if @ball.center_x  < (@player1.center_x)
        #"Player 1 left X"
        if @ball.v[:x] > 0
          #going right
          @ball.reflect_horizontal(@player1)
        elsif @ball.v[:x] < 0
          #going left
          #nothing
        end

      elsif @ball.center_x > (@player1.center_x)
        #"Player 1 right X"
        if @ball.v[:x] > 0
          #going right
          #nothing
        elsif @ball.v[:x] < 0
          #going left
          @ball.reflect_horizontal(@player1)
          #nothing
        end
      end

      if @ball.center_y  > (@player1.center_y)
        #"Player 1 bottom Y"
        if @ball.v[:y] > 0
          #going down
          #nothing
        elsif @ball.v[:y] < 0
          #going up
          @ball.reflect_vertical(@player1)
        end

      elsif @ball.center_y  < (@player1.center_y)
        #"Player 1 top Y"
        if @ball.v[:y] > 0
          #going down
          puts "reflect"
          @ball.reflect_vertical(@player1)
        elsif @ball.v[:y] < 0
          #going up
          puts "bounce"
          @ball.bounce(@player1)
        end
      end
    end

    if @ball.collide?(@player2)
      if @ball.center_x  < (@player2.center_x)
        #"Player 2 left X"
        if @ball.v[:x] > 0
          @ball.reflect_horizontal(@player2)
          #nothing
        elsif @ball.v[:x] < 0
          #nothing
        end
      elsif @ball.center_x > (@player2.center_x)
        #"Player 2 right X"
        if @ball.v[:x] > 0
          #nothing
        elsif @ball.v[:x] < 0
          @ball.reflect_horizontal(@player2)
          #nothing
        end
      end

      if @ball.center_y  > (@player2.center_y)
        #"Player 1 bottom Y"
        if @ball.v[:y] > 0
          #going down
          #nothing
        elsif @ball.v[:y] < 0
          #going up
          @ball.reflect_vertical(@player2)
        end

      elsif @ball.center_y  < (@player2.center_y)
        #"Player 1 top Y"
        if @ball.v[:y] > 0
          #going down
          puts "reflect"
          @ball.reflect_vertical(@player2)
        elsif @ball.v[:y] < 0
          #going up
          puts "bounce"
          @ball.bounce(@player2)
        end
      end
    end
    @ball.reflect_vertical(nil) if @ball.y < 0 || @ball.bottom > self.height
  end

  def draw
    @ball.draw
    @player1.draw
    @player2.draw
    @net.draw
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

  #source = https://github.com/subdigital/pong
  def collide?(other)

    x_overlap = [0, [right, other.right].min - [left, other.left].max].max
    y_overlap = [0, [bottom, other.bottom].min - [top, other.top].max].max

    x_overlap * y_overlap != 0
  end
end

class Ball < GameObject
  WIDTH = 25
  HEIGHT = 25
  attr_accessor :v

  def initialize(x, y, v)
    super(x, y, WIDTH, HEIGHT)
    @v = v
  end

  def reflect_horizontal(other)
    if other != nil
      v[:x] = -(v[:x] + 2)
    else
      v[:x] = -v[:x]
    end
  end

  def reflect_vertical(other)

    if other != nil
      v[:y] = -(v[:y] + 2)
    else
      v[:y] = -v[:y]
    end
  end

  def bounce(other)

    if other != nil
      v[:y] = (v[:y] + 4)
    else
      v[:y] = v[:y]
    end
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

class Player < GameObject
  WIDTH = 75
  HEIGHT = 50
  attr_accessor :v

  def initialize(x, y, v, color)
    super(x, y, WIDTH, HEIGHT)
    @v = v
    @color = color
  end

  def update
    if self.y >= 750
      self.y = 750
    elsif self.y < 750
      self.y += v[:y]
    end

    @gravity.act_on(self)
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

class Net <GameObject
  attr_accessor :x
  attr_accessor :y
  WIDTH = 80
  HEIGHT = 100

  def initialize(x,y,w,h)

    super(x, y, WIDTH, HEIGHT)
  end

  def update
  end

  def draw
    Gosu.draw_rect x, y, WIDTH, HEIGHT, Gosu::Color::WHITE
  end
end
window = MyWindow.new
window.show
