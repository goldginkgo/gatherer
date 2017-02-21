require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "POST create" do
    #
    it "creates a project" do
      post :create, params: { project: {name: "Runway", tasks: "Start something:2"} }
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action).project.name).to eq("Runway")
    end
    #

    #
    it "creates a project (mock version)" do
      fake_action = instance_double(CreatesProject, create: true)
      expect(CreatesProject).to receive(:new)
          .with(name: "Runway", task_string: "start something:2")
          .and_return(fake_action)
      post :create, params: { project: {name: "Runway", tasks: "start something:2"} }
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action)).not_to be_nil
    end
  #

    #
    it "goes back to the form on failure" do
      post :create, params: { project: {name: "", tasks: ""} }
      expect(response).to render_template(:new)
      expect(assigns(:project)).to be_present
    end
    #

    #
    it "fails create gracefully" do
      action_stub = double(create: false, project: Project.new)
      expect(CreatesProject).to receive(:new).and_return(action_stub)
      post :create, params: { :project => {name: 'Project Runway'} }
      expect(response).to render_template(:new)
    end

    #
  end

  describe "PATCH update" do
  #
    it "fails update gracefully" do
      sample = Project.create!(name: "Test Project")
      expect(sample).to receive(:update_attributes).and_return(false)
      allow(Project).to receive(:find).and_return(sample)
      patch :update, params: { id: sample.id, project: {name: "Fred"} }
      expect(response).to render_template(:edit)
    end
  #
  end

end
