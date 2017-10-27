require 'rails_helper'

describe "Admin visits /admin/dashboard" do
  context "and Admin clicks link to view all items" do
    context "Admin should see a table with all items" do
      scenario "Admin should see all attributes of all items with option to edit" do
        Role.create(name: "registered")
        role  = Role.create(name: "platform admin")
        admin = User.create(username: "David Bowie",
                           password: "Goblin King",
                           full_name: "Ziggy Stardust",
                           address: "Labyrinth")

        user_role = UserRole.create(user: admin, role: role)
        category = create(:category, title: "Guitars")
        item_1 = create(:item, category: category)

        visit login_path

        fill_in "session[username]", with: admin.username
        fill_in "session[password]", with: admin.password
        click_button "Login"

        visit admin_dashboard_path

        click_on "View Items"

        expect(current_path).to eq(admin_items_path)

        expect(page).to have_content(item_1.title)
        expect(page).to have_content(item_1.description)
        expect(page).to have_content(item_1.status)
        expect(page).to have_selector(:link_or_button, "Edit")
      end
    end
  end
end
