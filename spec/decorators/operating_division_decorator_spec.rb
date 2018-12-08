# coding: utf-8
require 'rails_helper'

describe OperatingDivisionDecorator do
  let(:operating_division) { OperatingDivision.new.extend OperatingDivisionDecorator }
  subject { operating_division }
  it { should be_a OperatingDivision }
end
