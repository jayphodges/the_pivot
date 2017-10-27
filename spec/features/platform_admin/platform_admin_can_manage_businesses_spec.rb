require 'rails_helper'

describe "Platform Admin can manage stores" do
  before(:each) do
    @store = create(:store)
    @category = create(:category)
    Role.create(name: "registered")
    @role  = Role.create(name: "platform admin")
    @user = User.create(username: "David Bowie",
                       password: "Goblin King",
                       full_name: "Ziggy Stardust",
                       address: "Labyrinth", phone: '1234567890')
    @user_role = UserRole.create(user: @user, role: @role)
    @item = Item.create(title: "Wand",
                       description: "Power Tool",
                       price: 12.0,
                       image: "imagestring",
                       category: @category,
                       store: @store)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "admin manages an item for a store" do
    visit store_admin_items_path(@store.slug)
    expect(current_path).to eq("/#{@store.slug}/admin/items")

    expect(page).to have_css('.item')
    within first('.item') do
      expect(page).to have_link "Edit"
      expect(page).to have_content("Wand")
      click_on "Edit"
    end

    expect(current_path).to eq("/admin/items/#{@item.id}/edit")

    fill_in "item[title]", with: "Power Stick"
    click_on "Submit"

    expect(current_path).to eq("/#{@store.slug}/admin/items")
    expect(page).to have_css('.item')
    within first('.item') do
      expect(page).to_not have_content("Wand")
      expect(page).to have_content("Power Stick")
    end
  end

  it 'admin can edit store information' do
    name = @store.name
    visit "/#{@store.slug}"
    expect(current_path).to eq("/#{@store.slug}")
    expect(page).to have_content("Edit Business")

    click_on "Edit Business"

    expect(current_path).to eq("/#{@store.slug}/edit")

    fill_in "store[name]", with: "Test Name"
    click_on "Submit Changes"

    expect(current_path).to eq("/test-name")
    expect(current_path).to_not eq("/#{@store.slug}")
  end
end
