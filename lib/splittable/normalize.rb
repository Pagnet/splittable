# frozen_string_literal: true

class Splittable::Normalize
  def initialize(value:, installments:, precision: 2)
    @value = BigDecimal(value, 15).truncate(precision)
    @installments = installments.map { |installment| BigDecimal(installment.round(precision), 15) }
  end

  def call
    decimal_difference = value - installments.sum
    installments[0] += decimal_difference

    installments
  end

  private

  attr_reader :value
  attr_accessor :installments
end
