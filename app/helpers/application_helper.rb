module ApplicationHelper
  def confirm_message
    t('general.message.confirm_proceed')
  end

  def nl2br( value )
    return nil if value == nil
    value.gsub(/\r\n|\r|\n/, '<br />')
  end

  def current_controller?(controllers)
    return false if controllers == nil || controllers.is_a?(Hash)
    if controllers.is_a?(Array)
      controllers.map(&:to_s).include?(params[:controller])
    else
      controllers.to_s.gsub(/^\//, '') == params[:controller]
    end
  end

  def current_action?(actions)
    return false if actions.nil?
    if actions.is_a?(Array)
      actions.map(&:to_s).include?(params[:action])
    else
      actions.to_s == params[:action]
    end
  end
end
