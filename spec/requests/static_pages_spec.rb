require 'spec_helper'

describe "Static Pages" do
  let(:base_title) { "Recepten Boek" }
  
  describe "Home page" do
    it "should have the base title" do
      visit '/static_pages/home'
      expect(page).to have_title("Recepten Boek")
    end

    it "should have the content 'Recepten Boek'" do
      visit "/static_pages/home"
      expect(page).to have_content("Recepten Boek")
    end
  end
  
  describe "About page" do
    it "should have the base title" do
      visit "/static_pages/about"
      expect(page).to have_title("Recepten Boek")
    end

    it "should have the content 'About'" do
      visit "/static_pages/about"
      expect(page).to have_content("About")
    end
  end
  
  describe "Contact page" do
    it "should have the base title" do
      visit "/static_pages/contact"
      expect(page).to have_title("Recepten Boek")
    end

    it "should have the content 'Contact'" do
      visit "/static_pages/contact"
      expect(page).to have_content("Contact")
    end
  end
end
