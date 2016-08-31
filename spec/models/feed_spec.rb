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
#
# Indexes
#
#  index_current_feeds_on_active_feed_version_id              (active_feed_version_id)
#  index_current_feeds_on_created_or_updated_in_changeset_id  (created_or_updated_in_changeset_id)
#  index_current_feeds_on_geometry                            (geometry)
#

require 'sidekiq/testing'

describe Feed do
  context 'changesets' do
    before(:each) do
      @changeset1 = create(:changeset, payload: {
        changes: [
          {
            action: 'createUpdate',
            operator: {
              onestopId: 'o-9q9-caltrain',
              name: 'Caltrain',
              identifiedBy: ['usntd://9134'],
              geometry: { type: "Polygon", coordinates:[[[-121.56649700000001,37.00360599999999],[-122.23195700000001,37.48541199999998],[-122.38653400000001,37.600005999999965],[-122.412018,37.63110599999998],[-122.39432299999996,37.77643899999997],[-121.65072100000002,37.12908099999998],[-121.61080899999999,37.085774999999984],[-121.56649700000001,37.00360599999999]]]}
            }
          },
          {
            action: 'createUpdate',
            feed: {
              onestopId: 'f-9q9-caltrain',
              url: 'http://www.caltrain.com/Assets/GTFS/caltrain/GTFS-Caltrain-Devs.zip',
              licenseUrl: 'http://www.caltrain.com/developer/Developer_License_Agreement_and_Privacy_Policy.html',
              licenseUseWithoutAttribution: 'yes',
              licenseCreateDerivedProduct: 'yes',
              licenseRedistribute: 'yes',
              includesOperators: [
                {
                  operatorOnestopId: 'o-9q9-caltrain',
                  gtfsAgencyId: 'caltrain-ca-us'
                }
              ]
            }
          }
        ]
      })
    end

    it 'can create a feed' do
      @changeset1.apply!
      expect(Operator.first.name).to eq "Caltrain"
      expect(Feed.first.url).to eq 'http://www.caltrain.com/Assets/GTFS/caltrain/GTFS-Caltrain-Devs.zip'
      expect(Feed.first.operators).to match_array([Operator.first])
      expect(@changeset1.feeds_created_or_updated).to match_array([Feed.first])
    end

    it 'can modify a feed, modifying model attributes' do
      changeset2 = create(:changeset, payload: {
        changes: [
          {
            action: 'createUpdate',
            feed: {
              onestopId: 'f-9q9-caltrain',
              licenseRedistribute: 'no'
            }
          }
        ]
      })
      @changeset1.apply!
      changeset2.apply!
      expect(Feed.first.operators).to match_array([Operator.first])
      expect(Feed.first.license_redistribute).to eq 'no'
      expect(changeset2.feeds_created_or_updated).to match_array([Feed.first])
    end

    it 'can modify a feed, modifying a GTFS agency ID' do
      changeset2 = create(:changeset, payload: {
        changes: [
          {
            action: 'createUpdate',
            feed: {
              onestopId: 'f-9q9-caltrain',
              includesOperators: [
                {
                  operatorOnestopId: 'o-9q9-caltrain',
                  gtfsAgencyId: 'new-id'
                }
              ]
            }
          }
        ]
      })
      @changeset1.apply!
      changeset2.apply!
      expect(Feed.first.operators).to match_array([Operator.first])
      expect(Feed.first.operators_in_feed.first.gtfs_agency_id).to eq 'new-id'
      expect(changeset2.feeds_created_or_updated).to match_array([Feed.first])
    end

    it 'can modify a feed, adding another operator' do
      changeset2 = create(:changeset, payload: {
        changes: [
          {
            action: 'createUpdate',
            operator: {
              onestopId: 'o-9q9-caltrain~dbtn',
              name: 'Caltrain Dumbarton',
              geometry: { type: "Polygon", coordinates:[[[-121.56649700000001,37.00360599999999],[-122.23195700000001,37.48541199999998],[-122.38653400000001,37.600005999999965],[-122.412018,37.63110599999998],[-122.39432299999996,37.77643899999997],[-121.65072100000002,37.12908099999998],[-121.61080899999999,37.085774999999984],[-121.56649700000001,37.00360599999999]]]}
            }
          },
          {
            action: 'createUpdate',
            feed: {
              onestopId: 'f-9q9-caltrain',
              includesOperators: [
                {
                  operatorOnestopId: 'o-9q9-caltrain~dbtn',
                  gtfsAgencyId: 'dumbarton'
                }
              ]
            }
          }
        ]
      })
      @changeset1.apply!
      changeset2.apply!
      expect(Feed.first.operators).to match_array([Operator.first, Operator.last])
      expect(Feed.first.operators_in_feed.map(&:gtfs_agency_id)).to match_array(['caltrain-ca-us', 'dumbarton'])
    end

    it 'can modify a feed, removing an operator relationship' do
      changeset2 = create(:changeset, payload: {
        changes: [
          {
            action: 'createUpdate',
            feed: {
              onestopId: 'f-9q9-caltrain',
              doesNotIncludeOperators: [
                {
                  operatorOnestopId: 'o-9q9-caltrain'
                }
              ]
            }
          }
        ]
      })
      @changeset1.apply!
      changeset2.apply!
      expect(Feed.first.operators).to match_array([])
      expect(Operator.first.feeds).to match_array([])
      expect(changeset2.operators_in_feed_destroyed).to match_array([OldOperatorInFeed.last])
    end

    it 'can delete a feed' do
      changeset2 = create(:changeset, payload: {
        changes: [
          {
            action: 'destroy',
            feed: {
              onestopId: 'f-9q9-caltrain'
            }
          }
        ]
      })
      @changeset1.apply!
      changeset2.apply!
      expect(Feed.count).to eq 0
      expect(Operator.count).to eq 1
      expect(OldFeed.count).to eq 1
      expect(OldFeed.first.old_operators_in_feed.first.operator).to eq Operator.first
      # TODO: figure out why this isn't working: expect(OldFeed.first.operators.first).to eq Operator.first
    end
  end

  context 'fetch_and_return_feed_version' do
    it 'creates a feed version the first time a file is downloaded' do
      feed = create(:feed_caltrain)
      expect(feed.feed_versions.count).to eq 0
      VCR.use_cassette('feed_fetch_caltrain') do
        feed.fetch_and_return_feed_version
      end
      expect(feed.feed_versions.count).to eq 1
    end

    it "does not create a duplicate, if remote file hasn't changed since last download" do
      feed = create(:feed_caltrain)
      VCR.use_cassette('feed_fetch_caltrain') do
        @feed_version1 = feed.fetch_and_return_feed_version
      end
      expect(feed.feed_versions.count).to eq 1
      VCR.use_cassette('feed_fetch_caltrain') do
        @feed_version2 = feed.fetch_and_return_feed_version
      end
      expect(feed.feed_versions.count).to eq 1
      expect(@feed_version1).to eq @feed_version2
    end

    it 'logs fetch errors' do
      feed = create(:feed_caltrain, url: 'http://httpbin.org/status/404')
      expect(feed.feed_versions.count).to eq 0
      VCR.use_cassette('feed_fetch_404') do
        feed.fetch_and_return_feed_version
      end
      expect(feed.feed_versions.count).to eq 0
      expect(feed.latest_fetch_exception_log).to be_present
      expect(feed.latest_fetch_exception_log).to include('404')
    end
  end

  it 'gets a bounding box around all its stops' do
    feed = build(:feed)
    stops = []
    stops << build(:stop, geometry: "POINT (-121.902181 37.329392)")
    stops << build(:stop, geometry: "POINT (-122.030742 37.378427)")
    stops << build(:stop, geometry: "POINT (-122.076327 37.393879)")
    stops << build(:stop, geometry: "POINT (-122.1649 37.44307)")
    feed.set_bounding_box_from_stops(stops)
    expect(feed.geometry(as: :geojson)).to eq({
      type: "Polygon",
      coordinates: [
        [
          [-122.1649, 37.329392],
          [-121.902181, 37.329392],
          [-121.902181, 37.44307],
          [-122.1649, 37.44307],
          [-122.1649, 37.329392]
        ]
      ]
    })
  end

  context 'import status' do
    it 'handles never imported' do
      feed = create(:feed)
      expect(feed.import_status).to eq :never_imported
    end

    it 'handles most recent failed' do
      feed = create(:feed)
      create(:feed_version_import, feed: feed, success: true)
      create(:feed_version_import, feed: feed, success: false)
      expect(feed.import_status).to eq :most_recent_failed
    end

    it 'handles most recent succeeded' do
      feed = create(:feed)
      create(:feed_version_import, feed: feed, success: false)
      create(:feed_version_import, feed: feed, success: true)
      expect(feed.import_status).to eq :most_recent_succeeded
    end

    it 'handles in progress' do
      feed = create(:feed)
      create(:feed_version_import, feed: feed, success: true)
      create(:feed_version_import, feed: feed, success: false)
      create(:feed_version_import, feed: feed, success: nil)
      expect(feed.import_status).to eq :in_progress
    end
  end

  context '#activate_feed_version' do
    before(:each) do
      @feed = create(:feed)
      @fv1 = create(:feed_version, feed: @feed)
      @ssp1 = create(:schedule_stop_pair, feed: @feed, feed_version: @fv1)
    end

    it 'sets active_feed_version' do
      expect(@feed.active_feed_version).to be nil
      @feed.activate_feed_version(@fv1.sha1, 1)
      expect(@feed.active_feed_version).to eq(@fv1)
    end

    it 'sets active_feed_version import_level' do
      @feed.activate_feed_version(@fv1.sha1, 2)
      expect(@fv1.reload.import_level).to eq(2)
    end

    it 'requires associated feed_version' do
      fv3 = create(:feed_version)
      expect {
        @feed.deactivate_feed_version(fv3.sha1)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context '#deactivate_feed_version' do
    before(:each) do
      @feed = create(:feed)
      # feed versions
      @fv1 = create(:feed_version, feed: @feed)
      @ssp1 = create(:schedule_stop_pair, feed: @feed, feed_version: @fv1)
      @fv2 = create(:feed_version, feed: @feed)
      @ssp2 = create(:schedule_stop_pair, feed: @feed, feed_version: @fv2)
    end

    it 'deletes old feed version ssps' do
      # activate
      @feed.activate_feed_version(@fv1.sha1, 2)
      @feed.activate_feed_version(@fv2.sha1, 2)
      expect(@fv1.imported_schedule_stop_pairs.count).to eq(1)
      @feed.deactivate_feed_version(@fv1.sha1)
      expect(@fv1.imported_schedule_stop_pairs.count).to eq(0)
      expect(@feed.imported_schedule_stop_pairs.where_imported_from_active_feed_version).to match_array([@ssp2])
    end

    it 'cannot deactivate current active_feed_version' do

    end

    it 'requires associated feed_version' do
      fv3 = create(:feed_version)
      expect {
        @feed.deactivate_feed_version(fv3.sha1)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end

  context '.where_latest_fetch_exception' do
    let(:feed_succeed) { create(:feed) }
    let(:feed_failed) { create(:feed, latest_fetch_exception_log: 'test') }

    it 'finds feeds with latest_fetch_exception_log' do
        expect(Feed.where_latest_fetch_exception(true)).to match_array([feed_failed])
    end

    it 'finds feeds without latest_fetch_exception_log' do
        expect(Feed.where_latest_fetch_exception(false)).to match_array([feed_succeed])
    end
  end

  context '.where_active_feed_version_import_level' do
    it 'finds active feed version with import_level' do
      fv1 = create(:feed_version, import_level: 2)
      feed1 = fv1.feed
      feed1.update!(active_feed_version: fv1)
      fv2 = create(:feed_version, import_level: 4)
      feed2 = fv2.feed
      feed2.update!(active_feed_version: fv2)
      expect(Feed.where_active_feed_version_import_level(0)).to match_array([])
      expect(Feed.where_active_feed_version_import_level(2)).to match_array([feed1])
      expect(Feed.where_active_feed_version_import_level(4)).to match_array([feed2])
    end

    it 'plays well with with_tag_equals' do
      feed = create(:feed, tags: {'test' => 'true'})
      fv1 = create(:feed_version, feed: feed)
      feed.activate_feed_version(fv1.sha1, 4)
      expect(Feed.where_active_feed_version_import_level(4).with_tag_equals('test', 'true')).to match_array([feed])
    end
  end

  context '.where_active_feed_version_valid' do
    before(:each) do
      date0 = Date.parse('2014-01-01')
      date1 = Date.parse('2015-01-01')
      date2 = Date.parse('2016-01-01')
      feed = create(:feed)
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date0, latest_calendar_date: date1)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date1, latest_calendar_date: date2)
      feed.update(active_feed_version: fv2)
    end

    it 'finds valid active_feed_version' do
      expect(Feed.where_active_feed_version_valid('2015-06-01').count).to eq(1)
    end

    it 'expired active_feed_version' do
      expect(Feed.where_active_feed_version_valid('2016-06-01').count).to eq(0)
    end

    it 'active_feed_version that has not started' do
      expect(Feed.where_active_feed_version_valid('2014-06-01').count).to eq(0)
    end
  end

  context '.where_newer_feed_version' do
    before(:each) do
      date0 = Date.parse('2014-01-01')
      date1 = Date.parse('2015-01-01')
      date2 = Date.parse('2016-01-01')
      # 3 feed versions, 2 newer
      @feed0 = create(:feed)
      fv0 = create(:feed_version, feed: @feed0, created_at: date0)
      fv1 = create(:feed_version, feed: @feed0, created_at: date1)
      fv2 = create(:feed_version, feed: @feed0, created_at: date2)
      @feed0.update!(active_feed_version: fv0)
      # 3 feed versions, 1 newer, 1 older
      @feed1 = create(:feed)
      fv3 = create(:feed_version, feed: @feed1, created_at: date0)
      fv4 = create(:feed_version, feed: @feed1, created_at: date1)
      fv5 = create(:feed_version, feed: @feed1, created_at: date2)
      @feed1.update!(active_feed_version: fv4)
      # 3 feed versions, 2 newer
      @feed2 = create(:feed)
      fv6 = create(:feed_version, feed: @feed2, created_at: date0)
      fv7 = create(:feed_version, feed: @feed2, created_at: date1)
      fv8 = create(:feed_version, feed: @feed2, created_at: date2)
      @feed2.update!(active_feed_version: fv8)
      # 1 feed version, current
      @feed3 = create(:feed)
      fv9 = create(:feed_version, feed: @feed3, created_at: date0)
      @feed3.update!(active_feed_version: fv9)
    end

    it 'finds superseded feeds' do
      expect(Feed.where_active_feed_version_update).to match_array([@feed0, @feed1])
    end
  end

  context '.find_next_feed_version' do
    let(:date) { DateTime.now }
    let(:date_earliest) { date - 2.month }
    let(:date_earlier) { date - 1.month }
    let(:date_later) { date + 1.month }
    let(:feed) { create(:feed) }

    it 'returns the next_feed_version' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date_earliest)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date_earlier)
      feed.update!(active_feed_version: fv1)
      expect(feed.find_next_feed_version(date)).to eq(fv2)
    end

    it 'returns feed_version if same service range but newer than active_feed_version' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date_earlier)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date_earlier)
      feed.update!(active_feed_version: fv1)
      expect(feed.find_next_feed_version(date)).to eq(fv2)
    end

    it 'returns feed_version ignoring feed_versions that begin in the future' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date_earliest)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date_earlier)
      fv3 = create(:feed_version, feed: feed, earliest_calendar_date: date_later)
      feed.update!(active_feed_version: fv1)
      expect(feed.find_next_feed_version(date)).to eq(fv2)
    end

    it 'returns most recently created feed_version if more than 1 result' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date_earliest)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date_earlier)
      fv3 = create(:feed_version, feed: feed, earliest_calendar_date: date_earlier)
      feed.update!(active_feed_version: fv1)
      expect(feed.find_next_feed_version(date)).to eq(fv3)
    end

    it 'returns nil if no active_feed_version' do
      expect(feed.find_next_feed_version(DateTime.now)).to be_nil
    end

    it 'returns nil if active_feed_version is most recent' do
      fv0 = create(:feed_version, feed: feed, earliest_calendar_date: date_earlier)
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date)
      feed.update!(active_feed_version: fv1)
      expect(feed.find_next_feed_version(DateTime.now)).to be_nil
    end

    it 'returns nil if earliest_calendar_date is less than active_feed_version' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date_earlier)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date_earliest)
      feed.update!(active_feed_version: fv1)
      expect(feed.find_next_feed_version(date)).to be_nil
    end
  end

  context '.enqueue_next_feed_versions' do
    let(:date) { DateTime.now }
    let(:feed) { create(:feed) }

    it 'enqueues next_feed_version' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date - 2.months)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date - 1.months)
      feed.update!(active_feed_version: fv1)
      expect {
        Feed.enqueue_next_feed_versions(date)
      }.to change(FeedEaterWorker.jobs, :size).by(1)
    end

    it 'does not enqueue if no next_feed_version' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date - 2.months)
      feed.update!(active_feed_version: fv1)
      expect {
        Feed.enqueue_next_feed_versions(date)
      }.to change(FeedEaterWorker.jobs, :size).by(0)
    end

    it 'allows max_imports' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date - 2.months)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date - 1.months)
      feed.update!(active_feed_version: fv1)
      expect {
        Feed.enqueue_next_feed_versions(date, max_imports: 0)
      }.to change(FeedEaterWorker.jobs, :size).by(0)
    end

    it 'skips if manual_import tag is true' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date - 2.months)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date - 1.months)
      feed.update!(active_feed_version: fv1, tags: {manual_import:"true"})
      expect {
        Feed.enqueue_next_feed_versions(date)
      }.to change(FeedEaterWorker.jobs, :size).by(0)
    end

    it 'does not enqueue if next_feed_version has a feed_version_import attempt' do
      fv1 = create(:feed_version, feed: feed, earliest_calendar_date: date - 2.months)
      fv2 = create(:feed_version, feed: feed, earliest_calendar_date: date - 1.months)
      create(:feed_version_import, feed_version: fv2)
      feed.update!(active_feed_version: fv1)
      expect {
        Feed.enqueue_next_feed_versions(date)
      }.to change(FeedEaterWorker.jobs, :size).by(0)
    end
  end

end
