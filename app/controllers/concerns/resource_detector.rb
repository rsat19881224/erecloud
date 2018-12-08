# -*- coding: utf-8 -*-
module ResourceDetector
  extend ActiveSupport::Concern

  included do |klass|
    include ModelDetector

    class_attribute :_resource_ancestors, :_permit_attributes
    cattr_accessor :option_stylesheet_links, :option_javascript_includes

    helper_method :route_name, :resource_ancestors

    before_action :load_ancestors, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    before_action :create_object, only: [:new, :create]
    before_action :load_objects,  only: [:index]
    before_action :load_object, only: [:show, :edit, :update, :destroy]
  end

  module ClassMethods
    def resource_ancestors(resource_ancestors=nil)
      self._resource_ancestors = resource_ancestors if resource_ancestors
      _resource_ancestors
    end

    def permit_attributes(*permitted)
      self._permit_attributes = permitted if permitted.presence
      _permit_attributes
    end
  end

  def route_name
    [*controller_path.split('/')[0..-2], *(resource_ancestors || []).reverse, model_name.underscore].join('_')
  end

  def resource_ancestors
    unless @resource_ancestors ||= self.class.resource_ancestors
      Rails.application.routes.router.recognize(request) do |route, matches, params|
        @resource_ancestors = route.path.names.reverse.drop_while { |name| ['id', 'format'].include?(name) }.map { |ancestor_id_name| ancestor_id_name.sub(/_id$/, '') }
      end
    end
    @resource_ancestors
  end

protected
  # TODO: reconsider handling of parent resources
  def load_ancestors
    resource_ancestors.map do |ancestor_name|
      # TODO: reconsider namespace handling
      instance_variable_set("@#{ancestor_name}", model_namespace.const_get(ancestor_name.camelize).find(params[:"#{ancestor_name}_id"]))
    end
  end

  def create_object
    instance_variable_set("@#{model_name.underscore}", (@instance = model.new(permitted_parameters || {}) rescue nil))
  end

  # TODO: reconsider resource filtering
  def load_objects
    instance_variable_set("@#{model_name.underscore.pluralize}", (@instances = model.where(params || {}) rescue nil))
  end

  def load_object
    instance_variable_set \
      "@#{model_name.underscore}",
      (@instance = model.find(params[:id]) rescue nil).tap { |instance| instance.try(:assign_attributes, permitted_parameters) }
  end

private
  def ancestor_ids
    (ancestor_ids = resource_ancestors.map { |ancestor_name| params[:"#{ancestor_name}_id"] }).any?(&:nil?) && [] || ancestor_ids
  end

  def permitted_parameters
    (params.require(model_symbol) rescue params).permit(*(self.class.permit_attributes.presence || []))
  end
end
