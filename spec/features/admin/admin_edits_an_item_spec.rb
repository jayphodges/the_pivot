require 'rails_helper'

describe 'Admin visits admin/items' do
  context 'admin clicks edit' do
    context 'admin is taken to the edit item path' do
      scenario 'admin can update item information' do
        Role.create(name: "registered")
        store = create(:store)
        category = create(:category)
        role  = Role.create(name: "business admin")
        user = User.create(username: "David Bowie",
                           password: "Goblin King",
                           full_name: "Ziggy Stardust",
                           address: "Labyrinth")
        user_role = UserRole.create(user: user, role: role)
        category = create(:category)
        item = create(:item, category: category)

        visit root_path

        click_on "Login"

        expect(current_path).to eq login_path

        fill_in "session[username]", with: user.username
        fill_in "session[password]", with: user.password
        click_button "Login"

        visit admin_items_path

        expect(item.status).to eq("active")

        click_on ("Edit")

        expect(current_path).to eq(edit_admin_item_path(item))

        fill_in "item-title", with: "whatever"
        fill_in "item-description", with: "something else"
        attach_file("item-image", './app/assets/images/logo-header.png')

        click_on ("Submit")

        expect(page).to have_content("whatever")
        expect(page).to have_content("something else")
      end
    end
  end
end
