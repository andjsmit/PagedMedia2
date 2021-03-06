FactoryGirl.define do
  factory :collection, class: Collection do
    transient do
      user { FactoryGirl.build(:user) }
    end

    after(:build) do |work, evaluator|
      work.apply_depositor_metadata(evaluator.user.user_key)
    end

    title ["A Paged Media Collection"]

    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC

    factory :complete_collection do
      after(:create) do |work|
        work.ordered_members << FactoryGirl.build(:complete_paged_work)
      end
    end

    trait :with_chapters do
      after(:create) do |collection|
        collection.ordered_members << FactoryGirl.build(:contained_page)
        collection.ordered_members << FactoryGirl.build(:contained_page)
      end
    end

  end
end
