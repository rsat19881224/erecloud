# -*- coding: utf-8 -*-
module ErrorHandler
  extend ActiveSupport::Concern

  included do |klass|
    rescue_from StandardError, with: :error_handler
    rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :error404
  end

  module ClassMethods
  end

  def error404
    respond_to do |format|
      format.html { render 'error404' }
      format.json { render nothing: true, status: :not_found }
    end
  end

  def error
    respond_to do |format|
      format.html { render 'error500' }
      format.json { render nothing: true, status: :internal_server_error }
    end
  end

  def error_handler(e=nil)
    if e
      logger.error("[error] message: #{e.message}")
      logger.error('[error] trace:')
      logger.error(e.backtrace.map { |t| t.force_encoding('utf-8') }.join("\n"))
      Notificator.error_notification(e.message, e.backtrace).deliver
    end
    error
  end
end
