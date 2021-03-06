require "rails_helper"


RSpec.describe "project show page", type: :feature do

  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)

  end

  it "can access show page and see projects name, material and theme" do
    visit "/projects/#{@news_chic.id}"
    expect(page).to have_content("Name: #{@news_chic.name}")
    expect(page).to have_content("Material: #{@news_chic.material}")
    expect(page).to have_content("Theme: #{@recycled_material_challenge.theme}")
  end

  it "user can see the number of contestants" do


    visit "/projects/#{@news_chic.id}"
    expect(page).to have_content("Name: #{@news_chic.name}")
    expect(page).to have_content("Material: #{@news_chic.material}")
    expect(page).to have_content("Theme: #{@recycled_material_challenge.theme}")
    expect(page).to have_content("Number Of Contestants: 2")

    visit "/projects/#{@upholstery_tux.id}"
    expect(page).to have_content("Name: #{@upholstery_tux.name}")
    expect(page).to have_content("Material: #{@upholstery_tux.material}")
    expect(page).to have_content("Theme: #{@furniture_challenge.theme}")
    expect(page).to have_content("Number Of Contestants: 2")

  end
  it "user can see avg years of experience" do

    visit "/projects/#{@news_chic.id}"
    expect(page).to have_content("Name: #{@news_chic.name}")
    expect(page).to have_content("Material: #{@news_chic.material}")
    expect(page).to have_content("Theme: #{@recycled_material_challenge.theme}")
    expect(page).to have_content("Number Of Contestants: 2")
    expect(page).to have_content("Average Contestant Experience: 12.5")

    visit "/projects/#{@upholstery_tux.id}"
    expect(page).to have_content("Name: #{@upholstery_tux.name}")
    expect(page).to have_content("Material: #{@upholstery_tux.material}")
    expect(page).to have_content("Theme: #{@furniture_challenge.theme}")
    expect(page).to have_content("Number Of Contestants: 2")
    expect(page).to have_content("Average Contestant Experience: 10")
  end

  it "user can add a contestant to a project" do
    visit "/projects/#{@news_chic.id}"

    fill_in "Contestant ID", with: @erin.idea
    click_button "Add Contestant To Project"
    expect(current_path).to eq("/projects/#{@news_chic.id}")

    expect(page).to have_content("Name: #{@news_chic.name}")
    expect(page).to have_content("Material: #{@news_chic.material}")
    expect(page).to have_content("Theme: #{@recycled_material_challenge.theme}")
    expect(page).to have_content("Number Of Contestants: 3")
    expect(page).to have_content("Average Contestant Experience: 13.3")



    # And when I visit the contestants index page
    # I see that project listed under that contestant's name



  end
end
