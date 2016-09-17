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
