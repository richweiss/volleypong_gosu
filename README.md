# volleypong_gosu

<!-- Each group needs to create a getting started tutorial on their topic. It should be:

Written in markdown and on a Github Repo
You should include screen shots, gifs, diagrams, or other tools that will help make the guide as useful as possible (but don't waste time on styling, this project is about content, not style).
You should look to the offical docs/start guides for inspiration, but make yours more approachable for WDI students. Think about what assumed knowledge is in the offical docs, and unassume it. Fill in the missing pieces.
Make sure to note dependencies, and similarities/differences to other types of tech we've studied.
Any code files that are needed should be included in this repo. This includes Gemfiles or package.json! -->

![](http://blog.uberpong.com/wp-content/uploads/2012/10/Forrest-Gump-ping-pong-funny.gif)

Gosu is a 2D game development library for the Ruby and C++ programming languages: Mac OS X, Windows, and Linux compatible. iPad, iPhone, and iPod Touch versions for C++ versions.

Ruby Project: VolleyPong  - similar to classic pong but players have more range of motion.

[Game Wireframe](http://i.imgur.com/S3dsYY2.jpg)

**Resources:**

    1)[Primary Site] - Development Library(https://www.libgosu.org/)

    2)[Github Wiki] (https://github.com/gosu/gosu/wiki)

    3)[Ruby Tutorial] (https://github.com/gosu/gosu/wiki/Ruby-Tutorial)

**Other Tools & References:**   
    1) [Customizing image using Draw Method](http://www.rubydoc.info/github/jlnr/gosu/Gosu/Image#draw_rot-instance_method)

**Our Tutorial:** 

Initial Set-Up

1) brew install sdl2
    - Gosu is built on top of the SDL 2 library.
    -   SimpleDirectMedia Layer: A cross-platform multimedia library designed to provide fast access to the graphics framebuffer and audio device.


2) gem install gosu

3) All Gosu projects have a class that is derived from Gosu::Window.
        Add this script to ruby file for a basic window. 
```rb
                    require 'gosu'

                    class MyWindow < Gosu::Window
                      def initialize
                        super(640, 480)
                        self.caption = 'We are Pangolins!'
                      end

                      def update
                      end

                      def draw
                      end
                    end

                    window = MyWindow.new
                    window.show
```

4) Note that Gosu has two primary methods: update() & draw()
        
- Update method: game(physics) logic, collisions, player input, etc. This method is called 60 times(frames) per second by default. 

- Draw method: handles width, height, pixelation of your game objects. Also called 60FPS

**Upload Images**

If you are setting an image use Gosu::Image under initialize, for example we will set a background image: 

```rb
        @background_image = Gosu::Image.new("folder path to image you want to use", :tileable => true)
```
    2) Note: tileable => true is stretching your image without compromising pixalation. 

**Player Movement**

Player movement was handled by Gosu's built in input class. When placed in the update function, the game will listen for the programmed button press every moment of the game.

```rb
    #if the A button is pressed...
    Gosu::button_down? Gosu::KbA then
        #do stuff
    end
```

**Audio**
https://www.libgosu.org/rdoc/Gosu/Sample.html

Gosu's audio engine divides sample behavior among two different methods
-   the sample method
-   the song method

The sample method provides basic one-shot audio triggering functionality and this is the only method type we used for the game.


```rb
    # first assign a new instance of Gosu Sample to a variable.
    @roarPlayer1 = Gosu::Sample.new("media/volleypong_sounds/chrisRoar.m4a")

    #then play it 
    @roarPlayer1.play
```

**Physics**
https://github.com/gosu/gosu/wiki/Ruby-Chipmunk-Integration
    
Gosu has a physics plugin called Chipmunk that implements non-framerate based physics into your game (that is, simulated mass, velocity, etc). Due to time constraints, we did not implement Chipmunk into the game and simply built our own version of framerate dependent "gravity" into the game. Needless to say, it is inferior to Chipmunk's physics but it suits our needs. 


(Optional)Last steps: Share your game with fellow Mac users!

**Deploying the game**
We had issues deploying the game to an executable due to outdated documentation.
    
Option #1 - releasy - https://github.com/Spooner/releasy/
    The most recent file of releasy is supported on Ruby 1.9.3 and doesn't work with more recent versions of Rake.
    
Option #2 -
    Main docs - https://github.com/gosu/gosu/wiki/Ruby-Packaging-on-OS-X
    The docs point us to a download page for Mac wrappers (https://github.com/gosu/ruby-app/releases) however, the most recent download is for Ruby 2.3.1

