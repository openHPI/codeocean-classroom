require 'rails_helper'

RSpec.describe "licenses/index", type: :view do
  before(:each) do
    allow(view).to receive(:will_paginate)
    assign(:licenses, [
      License.create!(),
      License.create!()
    ])
  end

  it "renders a list of licenses" do
    render
  end
end
