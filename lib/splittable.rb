# frozen_string_literal: true

require 'splittable/version'
require 'bigdecimal/util'

module Splittable
  class << self
    # receive total value and to quantity installments are required to equal division
    # just the first installment will receive the difference cents
    def division(value:, quantity:)
      convert_params!(value: value, quantity: quantity)
      params_validation!(@quantity)
      partial_value = (@value / @quantity).truncate(2)
      decimal_difference = @value - (@quantity * partial_value)
      installments = [partial_value] * @quantity
      installments[0] += decimal_difference

      installments
    end

    # receive total value and specific value of installments are required to specific division
    # just the first installment will receive the difference cents
    def normalize(value:, installments:)
      convert_params!(value: value, installments: installments)
      decimal_difference = @value - @installments.sum
      @installments[0] += decimal_difference

      @installments
    end

    private

    attr_accessor :value, :quantity, :installments

    def params_validation!(quantity)
      return if quantity.positive?

      raise ArgumentError, 'quantity should be positive'
    end

    def convert_params!(value: nil, quantity: nil, installments: nil)
      @value = BigDecimal(value, 15).truncate(2) unless value.nil?
      @quantity = BigDecimal(quantity.to_i, 15) unless quantity.nil?
      @installments = installments.map { |installment| BigDecimal(installment.round(2), 15) } unless installments.nil?
    end
  end
end
