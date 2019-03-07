require 'rails_helper'

RSpec.feature "ユーザー管理機能", type: :feature do
    feature "管理機能のテスト" do
        given(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
        given(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
        Label.create!(name: 'ruby')
        Label.create!(name: 'php')
        Label.create!(name: 'java')
        Label.create!(name: 'javascript')
        before do
            visit new_session_path
            fill_in 'session_email', with: login_user.email
            fill_in 'session_password', with: login_user.password
            click_button 'Log in'
        end

        context "作成したラベル機能がきちんと動くか実装" do
            given(:login_user) { user_a }
            scenario "タスクに複数のラベルが登録でき、一覧と詳細画面で表示されるかテスト" do
                visit new_task_path
                fill_in 'task_title', with: '岸'
                fill_in 'task_content', with: '大介'
                fill_in 'task_deadline', with: Date.today
                select'高', from: 'task_priority'
                select'未着手', from: 'task_status'
                check 'task_label_ids_1'
                check 'task_label_ids_2'
                check 'task_label_ids_3'
                click_on '登録する'
                expect(page).to have_content "ruby", "php"
                expect(page).to have_content "java"
                click_on '登録する'
                expect(page).to have_content "ruby", "php"
                expect(page).to have_content "java"
                click_on '詳細を確認する'
                expect(page).to have_content "ruby", "php"
                expect(page).to have_content "java"
            end

            scenario "一覧画面でラベル検索ができるかテスト" do
                visit new_task_path
                fill_in 'task_title', with: '岸'
                fill_in 'task_content', with: '大介'
                fill_in 'task_deadline', with: Date.today
                select'高', from: 'task_priority'
                select'未着手', from: 'task_status'
                check 'task_label_ids_1'
                check 'task_label_ids_2'
                check 'task_label_ids_3'
                click_on '登録する'
                click_on '登録する'
                click_on '新しくタスクを投稿する'
                fill_in 'task_title', with: '太秦の'
                fill_in 'task_content', with: '空き時間'
                fill_in 'task_deadline', with: Date.today
                select'高', from: 'task_priority'
                select'未着手', from: 'task_status'
                check 'task_label_ids_4'
                click_on '登録する'
                click_on '登録する'
                select'ruby', from: 'task_label_id'
                click_on 'Search'
                expect(page).to have_content "岸", "大介"
                expect(page).to have_no_content "太秦の", "空き時間"
            end
        end
    end
end