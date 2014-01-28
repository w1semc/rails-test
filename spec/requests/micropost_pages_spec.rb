require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  describe "post" do

    it "should list each micropost" do
      Micropost.all.each do |micropost|
        page.should have_selector('li', text: micropost.zagolovok)
      end
    end
  end

  describe "post create page" do
    before { visit postcreate_path }
    
    it { should have_selector('h1', text: 'Create Post') }
    it { should have_selector('title', text: 'Create Post') }
  end

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit postcreate_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'micropost_zagolovok', with: "Lorem ipsum" 
        fill_in 'micropost_content', with: "Lorem ipsum" 
      end

      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "post page" do
    let(:micropost) { FactoryGirl.create(:micropost) }
    let!(:m1) { FactoryGirl.create(:comment, micropost: micropost, content: "Lorem ipsum") }
    let!(:m2) { FactoryGirl.create(:comment, micropost: micropost, content: "Lorem ipsum") }

    before { visit microposts_path(micropost) }

    describe "comments" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(micropost.comments.count) }
    end
  end
end
