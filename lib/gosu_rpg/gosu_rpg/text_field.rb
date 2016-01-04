# https://www.omniref.com/ruby/gems/gosu/0.7.24/universal-darwin/files/examples/TextInput.rb#line=153

module GosuRPG
  class TextField < Gosu::TextInput
    def initialize(window, font, x, y, background_color=0xcc666666, caret_color=0xffffffff, padding=5)
      super()

      @window, @font, @x, @y, @background_color, @caret_color, @padding = window, font, x, y, background_color, caret_color, padding
    end

    def draw(zorder)
      @window.draw_quad(@x - @padding,         @y - @padding,          @background_color,
                        @x + width + @padding, @y - @padding,          @background_color,
                        @x - @padding,         @y + height + @padding, @background_color,
                        @x + width + @padding, @y + height + @padding, @background_color, 0)

      draw_caret if @window.text_input == self

      @font.draw(self.text, @x, @y, zorder)
    end

    def width
      @font.text_width(self.text)
    end

    def height
      @font.height
    end

    def under_point?(mouse_x, mouse_y)
      mouse_x > @x - @padding && mouse_x < @x + width + @padding &&
        mouse_y > @y - @padding && mouse_y < @y + height + @padding
    end

    def move_caret(mouse_x)
      1.upto(self.text.length) do |i|
        if mouse_x < @x + @font.text_width(text[0...i])
          self.caret_pos = self.selection_start = i - 1
          return
        end
      end
      self.caret_pos = self.selection_start = self.text.length
    end

    private

    def draw_caret
      pos_x = @x + @font.text_width(self.text[0...self.caret_pos])
      sel_x = @x + @font.text_width(self.text[0...self.selection_start])

      @window.draw_line(pos_x, @y, @caret_color, pos_x, @y + height, @caret_color, 0)
    end
  end
end
