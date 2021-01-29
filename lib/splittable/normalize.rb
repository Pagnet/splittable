# frozen_string_literal: true

class Splittable::Normalize
  def initialize(value:, installments:)
    @value = BigDecimal(value.truncate(2), 15)
    @installments = installments.map { |installment| BigDecimal(installment.round(2), 15) }
  end

  def call
    decimal_difference = @value - @installments.sum
    @installments[0] += decimal_difference

    @installments
  end
end
