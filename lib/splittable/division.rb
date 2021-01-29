# frozen_string_literal: true

class Splittable::Division
  def initialize(value:, quantity:)
    @value = BigDecimal(value.truncate(2), 15)
    @quantity = BigDecimal(quantity.to_i, 15)

    check_quantity_as_positive_value!
  end

  def call
    partial_value = (value / quantity).truncate(2)
    installments = [partial_value] * quantity
    installments[0] += value - installments.sum.to_d
    installments
  end

  private

  attr_reader :value, :quantity

  def check_quantity_as_positive_value!
    return if quantity.positive?

    raise ArgumentError, 'quantity should be positive'
  end
end
