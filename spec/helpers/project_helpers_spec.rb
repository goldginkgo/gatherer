require 'spec_helper'

describe ProjectsHelper do
  let(:project) { Project.new(name: "Project Runway")}

  it "returns a project name with status info" do
    allow(project).to receive(:on_schedule?).and_return(true)
    expected = '<span class="on_schedule">Project Runway</span>'
    expect(helper.name_with_status(project)).to eq(expected)
  end

  it "returns a project name with status info" do
    allow(project).to receive(:on_schedule?).and_return(false)
    expected = '<span class="behind_schedule">Project Runway</span>'
    expect(helper.name_with_status(project)).to eq(expected)
  end
end
