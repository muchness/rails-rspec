require 'spec_helper'

describe Admin::PostsController, :type => :controller do
  let(:my_post){Post.new(:title => 'new title', :content => 'new content')}

  describe "admin panel" do
    it "#index" do
      get :index
      response.status.should eq 200
    end

    it "#new" do
      get :new
      response.status.should eq 200
    end

    context "#create" do
      it "creates a post with valid params" do
        post_count = Post.count

        post :create, :post => {:title => 'title', :content =>
          'some content'}

        expect(Post.count).to eq(post_count + 1)
      end

      it "doesn't create a post when params are invalid" do
        post_count = Post.count

        post :create, :post => {:title => 'things'}

        expect(Post.count).to eq(post_count)
      end
    end

    context "#update" do
      it "updates a post with valid params" do

        my_post.save

        put :update, id: my_post.id, post: {title: 'newer title', content: my_post.content}

        expect(Post.find(my_post.id).title).to eq('Newer Title')
      end

      it "doesn't update a post when params are invalid" do

        my_post.save

        put :update, id: my_post.id, post: {title: 'newer title', content: '    '}

        expect(Post.find(my_post.id).title).to eq('New Title')
      end
    end

    it "#destroy" do
      my_post.save
      expect{
        delete :destroy, id: my_post.id
      }.to change{ Post.count }.by(-1)
    end
  end
end
