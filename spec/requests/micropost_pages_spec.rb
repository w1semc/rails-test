require 'spec_helper'

describe "Micropost pages" do

  subject { page }
  describe "post" do

    it { should have_selector('title', text: 'All Post') }
    it { should have_selector('h1',    text: 'All Post') }

    it "should list each micropost" do
      Micropost.all.each do |micropost|
        page.should have_selector('li', text: micropost.zagolovok)
      end
    end
  end
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_zagolovok('error') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'micropost_zagolovok', with: "Lorem ipsum" }
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end
end
