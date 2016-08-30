module IsAnEntityImportedFromFeeds
  extend ActiveSupport::Concern
  included do
    has_many :entities_imported_from_feed, as: :entity
    has_many :imported_from_feeds, through: :entities_imported_from_feed, source: :feed
    has_many :imported_from_feed_versions, through: :entities_imported_from_feed, source: :feed_version
    scope :where_import_level, -> (import_level) {
      joins(:entities_imported_from_feed)
        .where(entities_imported_from_feed: {
          feed_version_id: FeedVersion.where(import_level: import_level).ids
        })
        .distinct
    }
    scope :where_imported_from_feed, -> (feed) {
      joins(:entities_imported_from_feed)
        .where(entities_imported_from_feed: {
          feed_id: feed.id
        })
        .distinct
    }
    scope :where_imported_from_feed_version, -> (feed_version) {
      joins(:entities_imported_from_feed)
        .where(entities_imported_from_feed: {
          feed_version_id: feed_version.id
        })
        .distinct
    }

    scope :where_imported_from_active_feed_version, -> {
      joins(:entities_imported_from_feed)
        .joins('INNER JOIN current_feeds ON entities_imported_from_feed.feed_version_id = current_feeds.active_feed_version_id')
        .distinct
    }

    scope :where_not_imported_from_active_feed_version, -> {
      # This may be possible with a complex outer join, but this will do.
      where(id: self.all.select(:id).pluck(:id) - self.where_imported_from_active_feed_version.select(:id).pluck(:id))
    }

  end
end
