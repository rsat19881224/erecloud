# coding: utf-8
module AnalysisDivisionDecorator
  def human_input_division
    division = Settings.enumerize_options.analysis_division.input_divisions.find {|idiv| idiv.value == input_division }
    division.present? ? I18n.t(division.human) : ''
  end
end
