FactoryGirl.define do

  factory :arm do
    protocol nil
    sparc_id 1
    subject_count 1
    visit_count 1
    sequence :name do |n|
      "Protocol #{n}"
    end
  end
end
