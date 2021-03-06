require 'rails_helper'
require 'date'

RSpec.feature 'タスク管理機能', type: :feature do
  let(:task_a) { Task.create!(title: 'まいど', content: 'おおきに') }
  FactoryBot.create(:task)
  FactoryBot.create(:second_task)
  FactoryBot.create(:third_task)
  FactoryBot.create(:fourth_task)

  scenario 'タスク一覧のテスト' do
    visit tasks_path
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path
    fill_in 'task_title', with: 'あああ'
    fill_in 'task[content]', with: 'いいい'
    click_on '登録する'
    expect(page).to have_content "以下の内容で、送信する。\nタイトル:あああ\n本文:いいい"
    click_on '登録する'
  end

  scenario 'タスク詳細のテスト' do
    visit task_path(task_a)
    expect(page).to have_content "タスク詳細画面\nタイトル: まいど\n内容: おおきに"
  end

  scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
    visit tasks_path
    expect(Task.order('created_at DESC').map(&:id)).to eq [4, 3, 2, 1]
  end

  scenario 'タスク終了期限作成のテスト' do
    visit new_task_path
    fill_in 'task_title', with: 'あああ'
    fill_in 'task[content]', with: 'いいい'
    fill_in 'task_deadline', with: Date.today
    click_on '登録する'
    expect(page).to have_content "以下の内容で、送信する。\nタイトル:あああ\n本文:いいい\n終了期限:2019-02-25\n優先順位:\n状態:"
    click_on '登録する'
  end

  scenario 'タスクが終了期限の降順に並んでいるかのテスト' do
    visit tasks_path
    click_link '終了期限でソートする'
    expect(Task.order('deadline DESC').map(&:deadline)).to eq %w[test_task_04 test_task_02 test_task_03 test_task_01]
  end

  scenario 'sort_deadlineスコープに対するテスト' do
    visit tasks_path
    fill_in 'task_title', with: 'test_task_01'
    click_on 'Search'
    expect(Task.search_title('test_task_01')).to eq Task.where('title LIKE ?', '%test_task_01%')
  end

  scenario 'search_statusスコープに対するテスト' do
    visit tasks_path
    select'未着手', from: 'task_status'
    click_on 'Search'
    expect(Task.search_title('未着手')).to eq Task.where('title LIKE ?', '%未着手%')
  end

  scenario 'タスクが優先順位の降順に並んでいるかのテスト' do
    visit tasks_path
    click_link '優先順位でソートする'
    expect(Task.order('priority DESC').map(&:priority)).to eq %w[高 高 中 低]
  end
end
