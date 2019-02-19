# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  let(:task_a) {Task.create!(title: 'test_task_01', content: 'testtesttest')}
  scenario "タスク一覧のテスト" do
    Task.create!(title: 'test_task_01', content: 'testtesttest')
    Task.create!(title: 'test_task_02', content: 'samplesample')
    visit tasks_path
    # save_and_open_page

    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    # fill_in 'task[title]', with: 'あああ'
    fill_in 'task_title', with: 'あああ'

    fill_in 'task[content]', with: 'いいい'
    click_on 'Create Task'
    expect(page).to have_content "以下の内容で、送信する。\nタイトル:あああ\n本文:いいい"
    click_on '登録する'
    expect(page).to have_content "タスクを作成いたしました\nタスク一覧\nタイトル 内容 あああ いいい 詳細を確認する タスクを編集する タスクを削除する\n新しくタスクを投稿する"
    # save_and_open_page
  end

  scenario "タスク詳細のテスト" do
    visit task_path(task_a)
    save_and_open_page
    expect(page).to have_content "タスク詳細画面\nタイトル: test_task_01\n内容: testtesttest"
  end
end