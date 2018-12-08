require 'rails_helper'

RSpec.describe "receivables/index", :type => :view do
  before(:each) do
    assign(:receivables, [
      Receivable.create!(),
      Receivable.create!()
    ])
  end

  it "renders a list of receivables" do
    render
  end
end
