require 'rails_helper'

xdescribe "Admin visits /admin/dashboard" do
  context "and Admin clicks link to view all items" do
    context "Admin should see a table with all items" do
      scenario "Admin should see all attributes of all items with option to edit" do
        admin = create(:user, role: 'admin')
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
