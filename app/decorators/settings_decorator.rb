# coding: utf-8
module SettingsDecorator
  def submenu_each(&block)
    submenu.each(&block)
  end

  def t_title
    view_context.t(title)
  end

  # view_context.link_toが使えなかった、ブロックが二重に評価されてしまう
  def link_or_menu
    unless try_controller.nil?
      view_context.url_for({controller: try_controller, action: try_action})
    else
      "javascript:void(0)"
    end
  end

  def active_controller
    if view_context.current_controller?(try_controller)
      'active'
    else
      ''
    end
  end

  def active_keep_controller
    if view_context.current_controller?(keep_controllers) && view_context.current_action?(keep_actions)
      'active'
    else
      ''
    end
  end

  %i/controller action/.each do |m_name|
    define_method(('try_' + m_name.to_s).to_sym) do
      send(m_name) rescue nil
    end
  end

  private
  def view_context
    ActiveDecorator::ViewContext.current
  end
end
