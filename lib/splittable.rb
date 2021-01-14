# frozen_string_literal: true

require "splittable/version"

module Splittable
  def self.division(value:, quantity:)
    convert_params!(value: value, quantity: quantity)
    params_validation!(@quantity)
    partial_value = (@value / @quantity).truncate(2)
    decimal_difference = @value - (@quantity * partial_value)
    parcels = [partial_value] * @quantity
    parcels[0] += decimal_difference

    parcels
  end

  def self.normalize(value:, parcels:)
    convert_params!(value: value, parcels: parcels)
    decimal_difference = @value - @parcels.sum
    @parcels[0] += decimal_difference

    @parcels
  end

  private

  attr_accessor :value, :quantity, :parcels

  def self.params_validation!(quantity)
    return if quantity.positive?

    raise ArgumentError, 'quantidade deve ser positivo'
  end

  def self.convert_params!(value: nil, quantity: nil, parcels: nil)
    @value = BigDecimal(value.truncate(2), 15) unless value.nil?
    @quantity = BigDecimal(quantity.to_i, 15) unless quantity.nil?
    @parcels = parcels.map { |p| BigDecimal(p.round(2), 15) } unless parcels.nil?
  end
end
