# frozen_string_literal: true

module Splittable
  class Division
    def initialize(value:, quantity:)
      @value = BigDecimal(value.truncate(2), 15)
      @quantity = BigDecimal(quantity.to_i, 15)

      quantity_positive_validation!
    end

    def call
      partial_value = (value / quantity).truncate(2)

      installments = [partial_value] * quantity
      installments[0] += value - installments.sum
      installments
    end

    private

    attr_reader :value, :quantity

    def quantity_positive_validation!
      return if quantity.positive?

      raise ArgumentError, 'quantity should be positive'
    end
  end
end
