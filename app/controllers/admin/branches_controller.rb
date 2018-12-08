class Admin::BranchesController < Admin::BaseController
  permit_attributes :code, :name, :kana
end
