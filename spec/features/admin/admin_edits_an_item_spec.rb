require 'rails_helper'

describe 'Admin visits admin/items' do
  context 'admin clicks edit' do
    context 'admin is taken to the edit item path' do
      scenario 'admin can update item information' do
        admin = create(:user, role: 1)
        category = create(:category)
        item = create(:item, category: category)

        visit root_path

        click_on "Login"

        expect(current_path).to eq login_path

        fill_in "session[username]", with: admin.username
        fill_in "session[password]", with: admin.password
        click_button "Login"

        visit admin_items_path

        expect(item.status).to eq("active")

        click_on ("Edit")

        expect(current_path).to eq(edit_admin_item_path(item))

        fill_in "Title", with: "whatever"
        fill_in "Description", with: "something else"
        attach_file("Image", './app/assets/images/logo-header.png')
        select "retired", from: "Status"

        click_on ("Submit")

        expect(current_path).to eq(admin_items_path)

        expect(page).to have_content("whatever")
        expect(page).to have_content("something else")
        expect(page).to have_content("retired")
      end
    end
  end
end
