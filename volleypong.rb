require 'gosu'

class MyWindow < Gosu::Window
  attr_accessor :height
  attr_accessor :width

  def initialize
    super(1280, 800)
    @background_image_1 = Gosu::Image.new("img/pv_bckgrnd_1.jpg", :tileable => true)
    @background_image_2 = Gosu::Image.new("img/pv_bckgrnd_2.jpg", :tileable => true)
    @background_image_3 = Gosu::Image.new("img/pv_bckgrnd_3.jpg", :tileable => true)
    @background_image_4 = Gosu::Image.new("img/pv_bckgrnd_4.jpg", :tileable => true)
    @background_image_5 = Gosu::Image.new("img/pv_bckgrnd_5.jpg", :tileable => true)
    @background_image_array = [@background_image_1,
                              @background_image_2,
                              @background_image_3,
                              @background_image_4,
                              @background_image_5]
    @chosen_background_img = @background_image_array.sample
    self.caption = 'Volley-Pong!'
    @ball = Ball.new( 100, 500, { :x => 10, :y => 8 })
    @player1 = Player.new( 50, 750, { :y => 0 }, Gosu::Color::YELLOW)
    @player2 = Player.new( 1050, 750, { :y => 0 }, Gosu::Color::GREEN)
    @net = Net.new(620, 700, 80, 80)
    @height = 800
    @width = 1280
    @player_speed_X = 8
    @player_speed_Y = 12
  end

  def update

    @player1.update
    @player2.update


    if Gosu::button_down? Gosu::KbA then
      @player1.x += -@player_speed_X
    end
    if Gosu::button_down? Gosu::KbD then
      @player1.x += @player_speed_X
    end

    if Gosu::button_down? Gosu::KbW then
      if @player1.player_landed && @player1.bottom >= 800
        @player1.player_landed = false
      end
    end

    if Gosu::button_down? Gosu::KbS then
      @player1.y += @player_speed_Y
    end
    if Gosu::button_down? Gosu::KbLeft then
      @player2.x += -@player_speed_X
    end
    if Gosu::button_down? Gosu::KbRight then
      @player2.x += @player_speed_X
    end

    if Gosu::button_down? Gosu::KbUp
      if @player2.player_landed && @player2.bottom >= 800
        @player2.player_landed = false
      end
    end

    if Gosu::button_down? Gosu::KbDown then
      @player2.y += @player_speed_Y
    end

    if @player1.player_landed == false
      @player1.y += -@player_speed_Y
      if @player1.y <= 600

        @player1.player_landed = true
      end
    end

    if @player2.player_landed == false
      @player2.y += -@player_speed_Y
      if @player2.y <= 600

        @player2.player_landed = true
      end
    end


    @ball.update

    if @ball.x <= 0

      @ball.v[:x] = 8

    elsif @ball.right >= self.width
      @ball.v[:x] = -8
    end

    #player 1 collision

    if @ball.collide?(@player1)


      if @ball.center_x  < (@player1.center_x)

        #if ball hits left of player 1
        if @ball.v[:x] > 0
          #while going right
          @ball.reflect_horizontal(@player1)
        elsif @ball.v[:x] < 0
          #while going left
          @ball.bounce_horizontal(@player1)
        end

      elsif @ball.center_x > (@player1.center_x)
        #"Player 1 right X"
        if @ball.v[:x] > 0
          #going right
          @ball.bounce_horizontal(@player1)
        elsif @ball.v[:x] < 0
          #going left
          @ball.reflect_horizontal(@player1)
        end
      end

      if @ball.center_y  > (@player1.center_y)
        #"Player 1 bottom Y"
        if @ball.v[:y] > 0
          #going down
          @ball.bounce_vertical(@player1)
        elsif @ball.v[:y] < 0
          #going up
          @ball.reflect_vertical(@player1)
        end

      elsif @ball.center_y  < (@player1.center_y)
        #"Player 1 top Y"
        if @ball.v[:y] > 0
          #going down
          @ball.reflect_vertical(@player1)
        elsif @ball.v[:y] < 0
          #going up
          @ball.bounce_vertical(@player1)
        end
      end
    end # end player 1


    #Player 2 collision

    if @ball.collide?(@player2)
      if @ball.center_x  < (@player2.center_x)
        #"Player 2 left X"
        if @ball.v[:x] > 0
          #if ball is going right
          @ball.reflect_horizontal(@player2)

        elsif @ball.v[:x] < 0
          #if ball is going left
          @ball.bounce_horizontal(@player2)
        end
      elsif @ball.center_x > (@player2.center_x)
        #"Player 2 right X"
        if @ball.v[:x] > 0
          #if ball is going right
          @ball.bounce_horizontal(@player2)
        elsif @ball.v[:x] < 0
          #if ball is going left
          @ball.reflect_horizontal(@player2)

        end
      end

      if @ball.center_y  > (@player2.center_y)
        #"Player 1 bottom Y"
        if @ball.v[:y] > 0
          #going down
          @ball.bounce_vertical(@player2)
        elsif @ball.v[:y] < 0
          #going up
          @ball.reflect_vertical(@player2)
        end

      elsif @ball.center_y  < (@player2.center_y)
        #"Player 1 top Y"
        if @ball.v[:y] > 0
          #going down

          @ball.reflect_vertical(@player2)
        elsif @ball.v[:y] < 0
          #going up

          @ball.bounce_vertical(@player2)
        end
      end
    end

    #if collide with the net

    if @ball.collide?(@net)
      #if ball hits left of net
      if @ball.center_x < @net.center_x
        @ball.reflect_horizontal(nil)
      #if ball hits right of net
      elsif @ball.center_x > @net.center_x
        @ball.reflect_horizontal(nil)
      end

      #if ball hits top of net
      if @ball.center_y < @net.center_y
        @ball.reflect_vertical(nil)
      end

    end

    #keep players on each side of net

    if @player1.right > @net.left
      @player1.x = @net.left - @player1.w
    end

    if @player2.left < @net.right
      @player2.x = @net.right
    end

    #keep players going off the edge of the screen

    @player1.x = 0 if @player1.x <= 0
    @player2.x = self.width - @player2.w if @player2.right >= self.width

    #if collide with the top wall
    @ball.reflect_vertical(nil) if @ball.y < 0 || @ball.bottom > self.height




  end

  def draw
    @ball.draw
    @player1.draw
    @player2.draw
    @net.draw
    @chosen_background_img.draw(0, 0, -10)
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
    @image = Gosu::Image.new("img/pangolin_0.png")
    super(x, y, WIDTH, HEIGHT)
    @v = v
    @angle = 0
  end

  def reflect_horizontal(other)
    if other != nil
      v[:x] = -(v[:x] + 1)
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

  def bounce_vertical(other)

    if (other != nil && v[:y] > 0)
      v[:y] = (v[:y] + 2)
    elsif (other != nil && v[:y] < 0)
      v[:y] = (v[:y] - 2)
    else
      v[:y] = v[:y]
    end
  end

  def bounce_horizontal(other)

   if (other != nil && v[:x] >= 0)
      v[:x] = (v[:x] + 2)
    elsif (other != nil && v[:x] < 0)
      v[:x] = (v[:x] - 2)
    else
      v[:x] = v[:x]
    end
  end


  def update
    self.x += v[:x]
    self.y += v[:y]
    @gravity.act_on(self)
  end

  def draw
    @angle +=1
    @image.draw_rot(self.x, self.y, 1000, @angle, center_x = 0.5, center_y = 0.5, scale_x = 0.25, scale_y = 0.25, color = 0xffffffff, mode = :default)
  end

end

class Player < GameObject
  WIDTH = 75
  HEIGHT = 50

  attr_accessor :v
  attr_accessor :player_landed

  def initialize(x, y, v, color)
    super(x, y, WIDTH, HEIGHT)
    @v = v
    @color = color
    @player_landed = true
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

  def player_landed?
    if self.bottom < 800
      return false
    elsif self.bottom >= 800
      return true
    end
  end

end

class Gravity

  def initialize
    @grav_constant = 5;
  end

  def act_on(thing)

    #if thing is not falling
    if thing.v[:y] < @grav_constant
      thing.v[:y] += (0.0167 * 12) #1 second to increase by 1

    #if thing is falling
    elsif thing.v[:y] > @grav_constant
      thing.v[:y] = @grav_constant
    end
  end
end

class Net <GameObject
  attr_accessor :x
  attr_accessor :y
  WIDTH = 40
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
