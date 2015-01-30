FactoryGirl.define do

  factory :participant do
    arm nil
    protocol nil
    first_name 'First name'
    last_name 'Last name'
    mrn 5
    status 'Active'
    date_of_birth Time.current.last_year
    gender 'Male'
    ethnicity 'Not Hispanic or Latino'
    race 'Caucasian'
    address 'Address'
    phone '123-456-7890'

    trait :with_protocol do
      protocol
    end

    trait :with_appointments do
      after(:create) do | participant, evaluator|
        participant.arm.visit_groups.each do |vg|
          create(:appointment, participant: participant, visit_group: vg, name: vg.name, visit_group_position: vg.position)
        end
      end
    end

    factory :participant_with_protocol, traits: [:with_protocol]
    factory :participant_with_appointments, traits: [:with_appointments]
  end
end
