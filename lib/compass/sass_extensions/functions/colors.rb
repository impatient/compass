module Compass::SassExtensions::Functions::Colors
  if defined?(Sass::Util)
    include Sass::Util
  else
    include Haml::Util
  end

  # a genericized version of lighten/darken so that negative values can be used.
  def adjust_lightness(color, amount)
    assert_type color, :Color
    assert_type amount, :Number
    color.with(:lightness => restrict(color.lightness + amount.value, 0..100))
  end

  # Scales a color's lightness by some percentage.
  # If the amount is negative, the color is scaled darker, if positive, it is scaled lighter.
  # This will never return a pure light or dark color unless the amount is 100%.
  def scale_lightness(color, amount)
    assert_type color, :Color
    assert_type amount, :Number
    color.with(:lightness => scale_color_value(color.lightness, amount.value))
  end

  # a genericized version of saturation/desaturate so that negative values can be used.
  def adjust_saturation(color, amount)
    assert_type color, :Color
    assert_type amount, :Number
    color.with(:saturation => restrict(color.saturation + amount.value, 0..100))
  end

  # Scales a color's saturation by some percentage.
  # If the amount is negative, the color is desaturated, if positive, it is saturated.
  # This will never return a pure saturated or desaturated color unless the amount is 100%.
  def scale_saturation(color, amount)
    assert_type color, :Color
    assert_type amount, :Number
    color.with(:saturation => scale_color_value(color.saturation, amount.value))
  end

  private
  def scale_color_value(value, amount)
    if amount > 0
      value += (100 - value) * (amount / 100.0)
    elsif amount < 0
      value += value * amount / 100.0
    end
    value
  end
end