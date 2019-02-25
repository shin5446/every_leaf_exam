FactoryBot.define do

    # 作成するテストデータの名前を「task」とします
    # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
    factory :task do
      title { 'test_task_01' }
      content { 'testtesttest' }
      deadline { '1923-04-20' }
      status {'完了'}
      priority {'低'}
    end

    # 作成するテストデータの名前を「second_task」とします
    # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
    factory :second_task, class: Task do
      title { 'test_task_02' }
      content { 'samplesample' }
      deadline { '2023-04-12' }
      priority {'中'}
    end

    factory :third_task, class: Task do
      title { 'test_task_03' }
      content { 'samplesample' }
      deadline { Date.today }
      priority {'高'}
    end

    factory :fourth_task, class: Task do
      title { 'test_task_04' }
      content { 'samplesample' }
      deadline { '3023-04-20' }
      priority {'高'}
    end

  end