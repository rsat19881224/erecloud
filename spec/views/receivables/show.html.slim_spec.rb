require 'rails_helper'

RSpec.describe "receivables/show", :type => :view do
  before(:each) do
    @receivable = assign(:receivable, Receivable.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
