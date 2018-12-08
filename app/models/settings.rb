class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env

  def self.menu_each(&block)
    enumerize_options.menu_attrs.each(&block)
  end
end
