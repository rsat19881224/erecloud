# -*- coding: utf-8 -*-
module Api
  Error = Struct.new(:attribute, :errors)
  module Base
    extend ActiveSupport::Concern

    included do |_klass|
      include ActiveModel::SerializerSupport
      include Decoratable

      class_attribute :resource_ancestors
    end

    module ClassMethods
    end

    def create_begats(*resource_ancestors)
      (self.class.resource_ancestors || []).zip(resource_ancestors).inject(self) do |subject, (parent_name, parent)|
        subject && subject.respond_to?(:"#{parent_name}") && (subject.send(:"#{parent_name}") || subject.send(:"#{parent_name}=", parent))
      end
      self
    end

    def error_messages
      errors.messages.map { |(attribute, messages)| Error.new(attribute, messages) }
    end
  end
end
