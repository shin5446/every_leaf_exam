require 'rails_helper'

RSpec.feature "ユーザー管理機能", type: :feature do
    feature "管理機能のテスト" do
        given(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
        given(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }

        context "管理ユーザー画面の作成・一覧・詳細・更新・削除のテスト" do

            scenario "ユーザーの作成" do
                visit new_admin_user_path
                fill_in 'user[name]', with: '岸'
                fill_in 'user_email', with: 'uzumasanoakijikan@daian.com'
                check 'user_admin'
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on '登録する'
                expect(page).to have_content "岸", "uzumasanoakijikan@daian.com"
                expect(page).to have_content "管理者権限", "あり"
            end

            scenario "ユーザーの一覧" do
                user_a
                user_b
                visit admin_users_path
                expect(page).to have_content "ユーザーA", "a@example.com"
                expect(page).to have_content "ユーザーB", "b@example.com"
            end

            scenario "ユーザーの更新" do
                user_a
                visit admin_users_path
                click_on 'ユーザーを編集する'
                visit edit_admin_user_path(user_a)
                fill_in 'user[name]', with: '岸'
                fill_in 'user_email', with: 'uzumasanoakijikan@daian.com'
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on '編集する'
                expect(page).to have_content "岸", "uzumasanoakijikan@daian.com"
                expect(page).to have_no_content "", "a@example.com"
            end

            scenario "ユーザーの詳細" do
                FactoryBot.create(:task, title: '最初のタスク', user: user_a)
                FactoryBot.create(:task, title: '最後のタスク', user: user_a)
                visit admin_users_path(user_a)
                click_on '詳細を確認する'
                expect(page).to have_content  "最初のタスク", "最後のタスク"
            end

            scenario "ユーザーの削除" do
                user_a
                visit admin_users_path
                click_on 'ユーザーを削除する'
                expect(page).to have_no_content "ユーザーA", "a@example.com"
            end
        end
    end
end