require 'spec_helper'

describe Post do
  it "title should be automatically titleized before save" do
    post = Post.new
    post.title = "new post"
    post.content = "cool content"

    post.save

    expect(post.title).to eq("New Post")
  end

  it "post should be unpublished by default" do
  end


  # a slug is an automaticaly generated url-friendly
  # version of the title
  it "slug should be automatically generated" do
    post = Post.new
    post.title   = "New post!"
    post.content = "A great story"
    expect(post.slug).to be_nil

    post.save

    post.slug.should eq "new-post"
  end
end
