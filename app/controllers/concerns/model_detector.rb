# -*- coding: utf-8 -*-
module ModelDetector
  extend ActiveSupport::Concern

  included do |klass|
    class_attribute :_model_namespace, :_model_name

    helper_method :model, :model_name, :model_symbol
  end

  module ClassMethods
    def model_namespace(model_namespace=nil)
      self._model_namespace = model_namespace if model_namespace
      _model_namespace || controller_path.split('/')[0..-2].join('/').camelize.presence.try(:constantize) || Object
    end

    def model_name(model_name=nil)
      self._model_name = model_name if model_name
      (_model_name || controller_name.classify).to_s
    end

    def model
      model_namespace.const_get(model_name)
    end

    def model_symbol
      model_name.underscore.to_sym
    end
  end

  def model_namespace
    self.class.model_namespace
  end

  def model
    model_namespace.const_get(self.class.model_name)
  end

  def model_name
    self.class.model_name
  end

  def model_symbol
    self.class.model_symbol
  end
end
