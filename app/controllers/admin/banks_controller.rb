class Admin::BanksController < Admin::BaseController
  permit_attributes :code, :name, :kana
end
