require 'rails_helper'

xdescribe "Platform Admin can manage stores" do
  before(:each) do
    @store = create(:store)
    @category = create(:category)
    @role  = Role.create(name: "platform_admin")
    @user = User.create(username: "David Bowie",
                       password: "Goblin King",
                       full_name: "Ziggy Stardust",
                       address: "Labyrinth")
    @user_role = UserRole.create(store: @store, user: @user, role: @role)
    @item = Item.create(title: "Wand",
                       description: "Power Tool",
                       price: 12.0,
                       image: "imagestring",
                       category: @category,
                       store: @store)
  end

  it "admin manages an item for a store" do
    visit store_admin_items_path(@store.name)
    expect(current_path).to eq("/#{@store.name}/admin/items")

    expect(page).to have_css('.item')
    within first('.item') do
      expect(page).to have_link "Edit"
      expect(page).to have_content("Wand")
      click_on "Edit"
    end

    expect(current_path).to eq("/admin/items/#{@item.id}/edit")

    fill_in "item[name]", with: "Power Stick"
    click_on "Submit Changes"

    expect(current_path).to eq("/#{@store.name}/admin/items")
    expect(page).to have_css('.item')
    within first('.item') do
      expect(page).to_not have_content("Wand")
      expect(page).to have_content("Power Stick")
    end
  end

  it 'admin can edit store information' do
    name = @store.name
    visit store_path(@store.name)
    expect(current_path).to eq("/#{@store.name}")
    expect(page).to have_content("Edit Business")

    click_on "Edit Business"

    expect(current_path).to eq("/stores/#{@store.id}/edit")

    fill_in "store[name]", with: "Test Name"
    click_on "Submit Changes"

    expect(current_path).to eq("/test-name")
    expect(current_path).to_not eq("/#{name}")
  end
end
