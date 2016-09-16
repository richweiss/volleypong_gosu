require 'gosu'

class MyWindow < Gosu::Window
  def initialize
    super(1280, 800)
    self.caption = 'Hello World!'
  end
end

window = MyWindow.new
window.show
