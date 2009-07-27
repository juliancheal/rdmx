module Rdmx
  class Layers < Array
    attr_accessor :universe

    def initialize count, universe
      self.universe = universe
      super(count){|i|Rdmx::Layer.new(self)}
    end

    def apply!
      universe.values = blend
    end

    def blend
      inject(Array.new(universe.values.size, 0)) do |blended, layer|
        layer.values.each_index do |i|
          blended[i] = [([(blended[i] + layer[i]), 255].min), 0].max
        end
        blended
      end
    end
  end

  class Layer
    include Rdmx::Universe::Accessors

    attr_accessor :values

    def initialize parent
      self.values = parent.universe.values.clone
    end
  end
end
