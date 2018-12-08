# -*- coding: utf-8 -*-
module Api
  module Proxy
    extend ActiveSupport::Concern

    included do |klass|
      include Virtus.model
      extend ActiveModel::Naming
      extend ActiveModel::Translation
      include ActiveModel::Conversion
      include ActiveModel::Validations
      include Api::Base

      class_attribute :api_endpoint
    end

    module ClassMethods
      def find(id, *ancestor_ids)
        response = Typhoeus.get(Addressable::URI.join(base_url(*ancestor_ids), id.to_s).to_s, headers: {'Accept' => 'application/json'})
        response.success? && new(JSON.parse(response.body, symbolize_names: true)) || nil
      end

      def where(parameters={})
        response = \
          Typhoeus.get(
            Addressable::URI.new(base_url(*get_ancestor_ids(parameters))).tap { |uri| uri.query_values = parameters }.to_s,
            headers: {'Accept' => 'application/json'}
          )
        response.success? && JSON.parse(response.body, symbolize_names: true).map { |attributes| new(attributes) } || nil
      end
      alias_method :all, :where

      def get_ancestor_ids(attribtues={})
        (ancestor_ids = (resource_ancestors || []).map { |ancestor_name| attributes[ancestor_name.to_sym] }).any?(&:nil?) && [] || ancestor_ids
      end

      def update(attributes={})
        (subject = new(attributes)).create_begats(subject.get_begats(attributes)).update
      end

      def create(attributes={})
        (subject = new(attributes)).create_begats(subject.get_bagats(attributes)).create
      end

      def destroy(id, *ancestor_ids)
        (subject = find(id, *ancestor_ids)) && subject.create_begats(*subject.get_begats(*ancestor_ids)).destroy
      end

      def base_url(*ancestor_ids)
        begats = (pairs = (resource_ancestors.try(:map, &:pluralize).try(:reverse) || []).zip(ancestor_ids.map(&:to_s)).flatten).any?(&:nil?) && [] || pairs
        [*begats, model_name.demodulize.to_s.underscore.downcase.pluralize] \
          .inject(Addressable::URI.parse(api_endpoint)) { |uri, subject| uri.join(subject).trail_slash }.to_s
      end

      def envelope(target, options={})
        ActiveModel::Serializer.serializer_for(target).new(target, options).serializable_object.to_json
      end

      def get_begats(*ancestor_ids)
        begats, _ = \
          (resource_ancestors || []).inject([[], ancestor_ids.dup]) do |(descendants, rest_ids), ancestor_name|
            [descendants << ((ancestor_id = rest_ids.shift) && parent.const_get(ancestor_name.camelize).find(ancestor_id, *rest_ids)), rest_ids]
          end
        begats.any?(&:nil?) && [] || begats
      end
    end

    def persisted?
      id.present?
    end

    def save
      persisted? ? update : create
    end

    def save!
      save || raise(RecordNotSaved)
    end

    def assign_attributes(attributes={})
      self.attributes = attributes
    end

    def update_attributes(attributes={})
      assign_attributes(attributes) && update
    end

    def update_attributes!(attributes={})
      update_attributes(attributes) || raise(RecordNotSaved)
    end

    def create
      unless valid?
        false
      else
        response = Typhoeus::Request.post(collection_url, body: envelope, headers: {'content-type' => 'application/json'})
        result = JSON.parse(response.body, symbolize_names: true)
        if created = response.success?
          self.attributes = JSON.parse(response.body, symbolize_names: true)
        else
          assign_errors(result) if response.response_code == 422
        end
        created
      end
    end

    def create!
      create || raise(RecordNotSaved)
    end

    def update
      unless persisted? && valid?
        false
      else
        response = Typhoeus::Request.put(member_url, body: envelope, headers: {'content-type' => 'application/json'})
        response.success? || response.response_code == 422 && assing_errors(JSON.parse(response.body, symbolize_names: true)) && false
      end
    end

    def update!
      update || raise(RecordNotSaved)
    end

    def destroy
      unless persisted?
        true
      else
        response = Typhoeus::Request.delete(member_url)
        response.success? || response.response_code == 422 && assing_errors(JSON.parse(response.body, symbolize_names: true)) && false
      end
    end

    def assign_errors(result)
      result.each { |error_entry| error_entry[:errors].each { |error| errors.add(error_entry[:attribute], error) } }
    end

  private
    def base_url
      ancestor_ids, _ = \
        (self.class.resource_ancestors || []).inject([[], self]) do |(descendant_ids, subject), ancestor_name|
          (parent = subject && subject.respond_to?(:"#{ancestor_name}") && subject.send(:"#{ancestor_name}")) \
            && [descendant_ids << parent.id, parent] \
            || [descendant_ids << nil, nil]
        end
      self.class.base_url(*(ancestor_ids.any?(&:nil?) && [] || ancestor_ids))
    end

    def collection_url
      base_url
    end

    def member_url
      Addressable::URI.join(base_url, id.to_s).to_s
    end

    def envelope(options={})
      self.class.envelope(self, options)
    end
  end
end
