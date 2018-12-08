class Admin::InfosController < Admin::BaseController
	permit_attributes :type, :title, :content, :display_from, :display_to
end
