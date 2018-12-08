# -*- coding: utf-8 -*-
module Api
  module V1
    # TODO: unify standard process for basic web and api.
    # TODO: add process about nested resources
    class BaseController < ActionController::Base
      include ErrorHandler
      include ResourceDetector

      model_namespace Object

      def index
        respond_to do |format|
          format.json # index.json.rabl
        end
      end

      def show
        respond_to do |format|
          format.json # show.json.rabl
        end
      end

      def create
        respond_to do |format|
          unless @instance.save
            format.json { render action: 'error', status: :unprocessable_entity }
          else
            format.json do
              render \
                status: :created,
                location: send(:"#{route_name}_url", *(resource_ancestors || []).reverse.map { |ancestor_name| instance_variable_get("@#{ancestor_name}") }, @instance.id)
            end
          end
        end
      end

      def update
        respond_to do |format|
          if @instance.save
            format.json { render action: 'show' }
          else
            format.json { render action: 'error', status: :unprocessable_entity }
          end
        end
      end

      def destroy
        respond_to do |format|
          if @instance.destroy
            format.json # destroy.json.rabl
          else
            format.json { render action: 'error', status: :unprocessable_entity }
          end
        end
      end
    end
  end
end
