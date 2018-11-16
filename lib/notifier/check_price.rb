# frozen_string_literal: true

class CheckPrice
  def call(price, boundary)
    `say "Price is #{price}, time to buy"` if price > boundary
  end
end
