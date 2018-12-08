class Admin::TopsController < Admin::BaseController
  skip_before_filter :load_object
end
