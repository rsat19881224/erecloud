require 'rails_helper'

RSpec.describe "receivables/edit", :type => :view do
  before(:each) do
    @receivable = assign(:receivable, Receivable.create!())
  end

  it "renders the edit receivable form" do
    render

    assert_select "form[action=?][method=?]", receivable_path(@receivable), "post" do
    end
  end
end
