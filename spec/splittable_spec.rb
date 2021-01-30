# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Splittable do
  describe '.division' do
    subject(:division) { described_class.division(value: value, quantity: quantity, precision: precision) }

    [
      # input: [value, quantity, precision]
      { input: [0.1, 3, 2],     result: [0.04, 0.03, 0.03], result_sum: 0.1 },
      { input: [0.11888, 3, 2], result: [0.05, 0.03, 0.03], result_sum: 0.11 },
      { input: [0.18, 5, 2],    result: [0.06, 0.03, 0.03, 0.03, 0.03], result_sum: 0.18 },
      { input: [0.04, 5, 2],    result: [0.04, 0.0, 0.0, 0.0, 0.0], result_sum: 0.04 },
      { input: [0.07, 5, 2],    result: [0.03, 0.01, 0.01, 0.01, 0.01], result_sum: 0.07 },
      { input: [100, 12, 2],    result: [8.37, 8.33, 8.33, 8.33, 8.33, 8.33, 8.33, 8.33, 8.33, 8.33, 8.33, 8.33],
        result_sum: 100 },
      { input: [10, 2, 2],      result: [5, 5], result_sum: 10 },
      { input: [294.03, 6, 2],  result: [49.03, 49, 49, 49, 49, 49], result_sum: 294.03 },
      { input: [10, 3, 3], result: [3.334, 3.333, 3.333], result_sum: 10 }
    ].each do |example|
      context "when input is #{example[:input]}" do
        let(:value) { example[:input][0] }
        let(:quantity) { example[:input][1] }
        let(:precision) { example[:input][2] }
        let(:expected_result) { example[:result].map { |r| BigDecimal(r, 15) } }

        it { expect(division).to eq expected_result }
        it { expect(division.sum.to_f).to eq example[:result_sum].to_f }
        it { expect(division.map(&:class).uniq).to eq [BigDecimal] }
      end
    end

    context 'when quantity is zero' do
      let(:value) { 1 }
      let(:quantity) { 0 }
      let(:precision) { 2 }
      let(:error_message) { 'quantity should be positive' }

      it { expect { division }.to raise_error(ArgumentError, error_message) }
    end
  end

  describe '.normalize' do
    [
      { value: 1000,    installments: [35.987, 964.013],         result: [35.99, 964.01], precision: 2 },
      { value: 1000,    installments: [35.987, 964.019],         result: [35.98, 964.02], precision: 2 },
      { value: 1000,    installments: [35.98, 964.01],           result: [35.99, 964.01], precision: 2 },
      { value: 100,     installments: [33.33, 33.333, 33.33333], result: [33.34, 33.33, 33.33], precision: 2 },
      { value: 100.003, installments: [33.33, 33.333, 33.33333], result: [33.34, 33.33, 33.33], precision: 2 },
      { value: 294.03,  installments: [49.005, 49.005, 49.005, 49.005, 49.005, 49.005],
        result: [48.98, 49.01, 49.01, 49.01, 49.01, 49.01], precision: 2 },
      { value: 1170,    installments: [235.224, 235.224, 229.11000000000027, 235.21999999999974, 235.224],
        result: [235.23, 235.22, 229.11, 235.22, 235.22], precision: 2 },
      { value: 10, installments: [3.33333, 3.333333, 3.3333333], result: [3.334, 3.333, 3.333], precision: 3 }
    ].each do |example|
      it "installments like #{example[:installments]} should be normalized to #{example[:result]}" do
        normalized = described_class.normalize(value: example[:value], installments: example[:installments],
                                               precision: example[:precision])
        expect(normalized).to eq(example[:result])
      end
    end
  end
end
