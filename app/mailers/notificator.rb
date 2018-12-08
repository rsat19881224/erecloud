# -*- coding: utf-8 -*-
class Notificator < ActionMailer::Base
  default charset: 'iso-2022-jp'
  def error_notification(path, message, trace=nil)
    @path, @message, @trace = path, message, trace
    mail(Hash[*Settings.notification.error.map { |(k, v)| [k.to_sym, v] }.flatten]) { |format| format.text }
  end
end
