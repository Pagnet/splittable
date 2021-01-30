# frozen_string_literal: true

require 'splittable/version'
require 'splittable/division'
require 'splittable/normalize'
require 'bigdecimal/util'

module Splittable
  class << self
    # receive total value and to quantity installments are required to equal division
    # just the first installment will receive the difference cents
    def division(value:, quantity:, precision: 2)
      Splittable::Division.new(value: value, quantity: quantity, precision: precision).call
    end

    # receive total value and specific value of installments are required to specific division
    # just the first installment will receive the difference cents
    def normalize(value:, installments:, precision: 2)
      Splittable::Normalize.new(value: value, installments: installments, precision: precision).call
    end
  end
end
