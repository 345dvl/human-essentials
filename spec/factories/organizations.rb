# == Schema Information
#
# Table name: organizations
#
#  id                       :integer          not null, primary key
#  city                     :string
#  deadline_day             :integer
#  default_storage_location :integer
#  distribute_monthly       :boolean          default(FALSE), not null
#  email                    :string
#  intake_location          :integer
#  invitation_text          :text
#  latitude                 :float
#  longitude                :float
#  name                     :string
#  partner_form_fields      :text             default([]), is an Array
#  reminder_day             :integer
#  repackage_essentials     :boolean          default(FALSE), not null
#  short_name               :string
#  state                    :string
#  street                   :string
#  url                      :string
#  zipcode                  :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  account_request_id       :integer
#  ndbn_member_id           :bigint
#

FactoryBot.define do
  factory :organization do
    transient do
      skip_items { false }
    end

    sequence(:name) { |n| "Diaper Bank #{n}" } # 037000863427
    sequence(:short_name) { |n| "db_#{n}" } # 037000863427
    sequence(:email) { |n| "email#{n}@example.com" } # 037000863427
    sequence(:url) { |n| "https://organization#{n}.org" } # 037000863427
    street { "1500 Remount Road" }
    city { 'Front Royal' }
    state { 'VA' }
    zipcode { '22630' }
    reminder_day { 10 }
    deadline_day { 20 }

    logo { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/logo.jpg"), "image/jpeg") }

    trait :without_deadlines do
      reminder_day { nil }
      deadline_day { nil }
    end

    after(:create) do |instance, evaluator|
      Organization.seed_items(instance) unless evaluator.skip_items
    end
  end
end
