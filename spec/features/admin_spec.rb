require 'spec_helper'

feature 'Admin panel' do
  before(:all) do
    @post = Post.create(title: 'new title', content: 'more things')
  end

  context "on admin homepage" do
    it "can see a list of recent posts" do
      visit '/admin/posts'
      page.should have_content 'New Title'
    end


    it "can edit a post by clicking the edit link next to a post" do
      visit "/admin/posts/#{@post.id}"
      click_link('Edit')
      current_path.should eq("/admin/posts/#{@post.id}/edit")
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit "/admin/posts"
      click_link('Delete')
      page.should_not have_content 'New Title'
    end

    it "can create a new post and view it" do
       visit new_admin_post_url

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      @post.is_published = true

      visit "/admin/posts/#{@post.id}/edit"
      uncheck('post_is_published')
      click_button('Save')
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      visit '/admin/posts'
      click_link("#{@post.title}")
      current_path.should eq("/admin/posts/#{@post.id}")
    end

    it "can see an edit link that takes you to the edit post path" do
      visit '/admin/posts'
      click_link('Edit')
      current_path.should eq("/admin/posts/#{@post.id}/edit")
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      visit "/admin/posts/#{@post.id}"
      click_link('Admin welcome page')
      current_path.should eq('/admin/posts')
    end
  end
end