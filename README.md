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

Resources:

    1)[Primary Site] - Development Library(https://www.libgosu.org/)

    2)[Github Wiki] (https://github.com/gosu/gosu/wiki)

    3)[Ruby Tutorial] (https://github.com/gosu/gosu/wiki/Ruby-Tutorial)

Other Tools & References:
    
    1) [Customizing image using Draw Method](http://www.rubydoc.info/github/jlnr/gosu/Gosu/Image#draw_rot-instance_method)

Our Tutorial: 

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
        
            *Update method: game(physics) logic, collisions, player input, etc. This method is called 60 times(frames) per second by default. 

            *Draw method: handles width, height, pixelation of your game objects.

    Upload Images

    1) IF you setting a background image, under initialize  

    ```rb
        @background_image = Gosu::Image.new("folder path to image you want to use", :tileable => true)
    ```
    2) Note: tileable => true is stretching your image without compromising pixalation. 

    3) 

    (Optional)Last steps: Share your game with fellow Mac users!

    1)Download most recent Mac app wrapper (https://github.com/gosu/ruby-app/releases)
    2)Show the app’s package contents via the right-click menu in Finder
    3)Edit the Info.plist file, and change the bundle identifier to match your game (org.libgosu.UntitledGame by default)
    4)Copy your game files into the Contents/Resources subfolder
    5)Rename your game’s main source file to Main.rb

    And you’re done! You should now have a fully functional .app bundle.
    The .app is a self-contained Ruby installation with most of the standard library, plus a few libraries that are often used together with Gosu.

        *Alternative game upload
        - Gem install releasy
            - automatically distributes any Ruby game app.
            - [https://github.com/Spooner/releasy/

