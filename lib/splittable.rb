# frozen_string_literal: true

require 'splittable/version'
require 'splittable/division'
require 'bigdecimal/util'

module Splittable
  class << self
    # receive total value and to quantity installments are required to equal division
    # just the first installment will receive the difference cents
    def division(value:, quantity:)
      Splittable::Division.new(value: value, quantity:quantity).call
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

    def convert_params!(value: nil, quantity: nil, installments: nil)
      @value = BigDecimal(value.truncate(2), 15) unless value.nil?
      @quantity = BigDecimal(quantity.to_i, 15) unless quantity.nil?
      @installments = installments.map { |installment| BigDecimal(installment.round(2), 15) } unless installments.nil?
    end
  end
end
