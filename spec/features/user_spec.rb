require 'spec_helper'

feature 'User browsing the website' do
  before(:all) do
    @post = Post.create(title: 'My Title', content: 'my content')
  end

  context "on homepage" do
    it "sees a list of recent posts titles" do

      visit '/'

      expect(page).to have_text('My Title')

      # given a user and a list of posts
      # user visits the homepage
      # user can see the posts titles
    end

    it "can click on titles of recent posts and should be on the post show page" do
      visit '/'

      click_link('My Title')

      current_path.should eq("/posts/#{@post.id}")
      # given a user and a list of posts
      # user visits the homepage
      # when a user can clicks on a post title they should be on the post show page
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      visit "/posts/#{@post.id}"

      expect(page).to have_text('My Title')
      expect(page).to have_text('my content')
      # given a user and post(s)
      # user visits the post show page
      # user should see the post title
      # user should see the post body
    end
  end
end
