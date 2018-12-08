require 'rails_helper'

RSpec.describe "receivables/new", :type => :view do
  before(:each) do
    assign(:receivable, Receivable.new())
  end

  it "renders new receivable form" do
    render

    assert_select "form[action=?][method=?]", receivables_path, "post" do
    end
  end
end
