# -*- coding: utf-8 -*-
module Decoratable
  extend ActiveSupport::Concern

  included do |_klass|
  end

  module ClassMethods
    def inherited(klass)
      klass.send(:include, klass.parent.const_get(klass.model_name.demodulize + 'Decorator'))
    rescue NameError
    end
  end
end
