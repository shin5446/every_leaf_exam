require 'rails_helper'

RSpec.describe Task, type: :model do
  FactoryBot.create(:task)
  FactoryBot.create(:second_task)
  FactoryBot.create(:third_task)
  FactoryBot.create(:fourth_task)

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end

  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(title: '失敗テスト', content: '失敗テスト')
    expect(task).to be_valid
  end

  it 'sort_deadlineスコープに対するテスト' do
    expect(Task.sort_deadline).to eq Task.order(deadline: :desc)
  end

  it 'sort_created_atスコープに対するテスト' do
    expect(Task.sort_created_at).to eq Task.order(created_at: :desc)
  end

  it 'search_titleスコープに対するテスト' do
    expect(Task.search_title('test_task_01')).to eq Task.where('title LIKE ?', '%test_task_01%')
  end

  it 'search_statusスコープに対するテスト' do
    expect(Task.search_status('完了')).to eq Task.where('status LIKE ?', '%完了%')
  end
end
