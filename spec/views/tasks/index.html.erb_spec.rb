require 'spec_helper'

describe "tasks/index" do
  before(:each) do
    assign(:tasks, [
      stub_model(Task),
      stub_model(Task)
    ])
  end

  it "renders a list of tasks" do
    render
  end
end
