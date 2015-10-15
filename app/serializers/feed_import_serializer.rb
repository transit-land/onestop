# == Schema Information
#
# Table name: feed_imports
#
#  id                :integer          not null, primary key
#  feed_id           :integer
#  success           :boolean
#  sha1              :string
#  import_log        :text
#  validation_report :text
#  created_at        :datetime
#  updated_at        :datetime
#  exception_log     :text
#
# Indexes
#
#  index_feed_imports_on_created_at  (created_at)
#  index_feed_imports_on_feed_id     (feed_id)
#

class FeedImportSerializer < ApplicationSerializer
  attributes :id,
             :feed_onestop_id,
             :feed_url,
             :success,
             :sha1,
             :import_log,
             :exception_log,
             :validation_report,
             :created_at,
             :updated_at

  has_many :feed_schedule_imports

  def feed_onestop_id
    object.feed.onestop_id
  end

  def feed_url
    api_v1_feed_url(object.feed.onestop_id)
  end
end
