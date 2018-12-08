# coding: utf-8
require 'rails_helper'

describe AnalysisDivisionDecorator do
  let(:analysis_division) { AnalysisDivision.new.extend AnalysisDivisionDecorator }
  subject { analysis_division }
  it { should be_a AnalysisDivision }
end
