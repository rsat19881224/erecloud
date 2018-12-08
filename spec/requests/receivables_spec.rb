require 'rails_helper'

RSpec.describe "Receivables", :type => :request do
  describe "GET /receivables" do
    it "works! (now write some real specs)" do
      get receivables_path
      expect(response).to have_http_status(200)
    end
  end
end
