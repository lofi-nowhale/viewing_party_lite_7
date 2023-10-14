require 'rails_helper'

RSpec.describe 'Movie Details Page', type: :feature do
  before :each do
    @u1 = User.create!(name: 'Tim', email: 'tim@brayn10.com')
    visit user_path(@u1)
  end

  it 'displays movie details by id and buttons' do
  
    stub_request(:get, "https://api.themoviedb.org/3/movie/5142?api_key=#{Rails.application.credentials.api_key}&movie_id=5142").
    to_return(status: 200, body: File.read("spec/features/fixtures/movie_details.json"), headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/movie/5142/credits?api_key=#{Rails.application.credentials.api_key}&movie_id=5142").
      to_return(status: 200, body: File.read("spec/features/fixtures/movie_cast.json"), headers: {})
        
    visit user_movie_path(user_id: @u1.id, id: 5142) 

    expect(page).to have_content('Movie Title: Santo')
    expect(page).to have_content('Vote Average: 6.114')
    expect(page).to have_content('Runtime: 95')
    expect(page).to have_content('Genre(s): Horror, Action')
    expect(page).to have_content('Summary description: Innocent')
  end

  it "displays the first 10 cast members" do
    # Stub the API request for movie credits
    stub_request(:get, "https://api.themoviedb.org/3/movie/5124?api_key=#{Rails.application.credentials.api_key}&movie_id=5124").
    to_return(status: 200, body: File.read("spec/features/fixtures/movie_details.json"), headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/movie/5124/credits?api_key=#{Rails.application.credentials.api_key}&movie_id=5124").
      to_return(status: 200, body: File.read("spec/features/fixtures/movie_cast.json"), headers: {})
  
    visit user_movie_path(user_id: @u1.id, id: 5124)
  
    expect(page).to have_content('Cast')
    expect(page).to have_content('Anup Jagdale')
    expect(page).to have_content('Blue Demon')
    expect(page.all('li').count).to be <= 10
  end
  
end
  # expect(page).to have_content('Total Reviews')
    # expect(page).to have_content('Review Author')
    # expect(page).to have_content('Review Information')

    # Assertions for buttons
    # expect(page).to have_link('Create a Viewing Party', href: new_user_movie_viewing_party_path(user_id: @u1, id: @movie1.id)) # Use 'id' instead of 'movie_id'
    # expect(page).to have_link('Return to Discover Page', href: user_discover_index_path(user_id: @u1))