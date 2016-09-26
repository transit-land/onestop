# == Schema Information
#
# Table name: current_feeds
#
#  id                                 :integer          not null, primary key
#  onestop_id                         :string
#  url                                :string
#  feed_format                        :string
#  tags                               :hstore
#  last_fetched_at                    :datetime
#  last_imported_at                   :datetime
#  license_name                       :string
#  license_url                        :string
#  license_use_without_attribution    :string
#  license_create_derived_product     :string
#  license_redistribute               :string
#  version                            :integer
#  created_at                         :datetime
#  updated_at                         :datetime
#  created_or_updated_in_changeset_id :integer
#  geometry                           :geography({:srid geometry, 4326
#  latest_fetch_exception_log         :text
#  license_attribution_text           :text
#  active_feed_version_id             :integer
#  edited_attributes                  :string           default([]), is an Array
#
# Indexes
#
#  index_current_feeds_on_active_feed_version_id              (active_feed_version_id)
#  index_current_feeds_on_created_or_updated_in_changeset_id  (created_or_updated_in_changeset_id)
#  index_current_feeds_on_geometry                            (geometry)
#  index_current_feeds_on_onestop_id                          (onestop_id) UNIQUE
#

class FeedSerializer < ApplicationSerializer
  attributes :onestop_id,
             :url,
             :feed_format,
             :tags,
             :geometry,
             :license_name,
             :license_url,
             :license_use_without_attribution,
             :license_create_derived_product,
             :license_redistribute,
             :license_attribution_text,
             :last_fetched_at,
             :last_imported_at,
             :latest_fetch_exception_log,
             :import_status,
             :created_at,
             :updated_at,
             :feed_versions_count,
             :feed_versions_url,
             :feed_versions,
             :active_feed_version,
             :import_level_of_active_feed_version,
             :created_or_updated_in_changeset_id,
             :changesets_imported_from_this_feed

  has_many :operators_in_feed

  def feed_versions_count
    object.feed_versions.count
  end

  def feed_versions_url
    if object.persisted?
      api_v1_feed_versions_url({
        feed_onestop_id: object.onestop_id
      })
    end
  end

  def feed_versions
    object.feed_versions.pluck(:sha1) if object.persisted?
  end

  def active_feed_version
    object.active_feed_version.try(:sha1)
  end

  def import_level_of_active_feed_version
    object.active_feed_version.try(:import_level)
  end

  def changesets_imported_from_this_feed
    object.changesets_imported_from_this_feed.map(&:id)
  end
end
