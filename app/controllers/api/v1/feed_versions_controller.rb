# == Schema Information
#
# Table name: feed_versions
#
#  id                     :integer          not null, primary key
#  feed_id                :integer
#  feed_type              :string
#  file                   :string
#  earliest_calendar_date :date
#  latest_calendar_date   :date
#  sha1                   :string
#  md5                    :string
#  tags                   :hstore
#  fetched_at             :datetime
#  imported_at            :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  import_level           :integer          default(0)
#
# Indexes
#
#  index_feed_versions_on_feed_type_and_feed_id  (feed_type,feed_id)
#

class Api::V1::FeedVersionsController < Api::V1::BaseApiController
  include JsonCollectionPagination
  include DownloadableCsv
  include AllowFiltering

  before_action :set_feed_version, only: [:show, :update]
  before_filter :require_api_auth_token, only: [:update]

  include Swagger::Blocks
  swagger_path '/feed_versions' do
    operation :get do
      key :tags, ['feed']
      key :name, :tags
      key :summary, 'Returns all feed versions with filtering and sorting'
      key :produces, [
        'application/json',
        'application/vnd.geo+json',
        'text/csv'
      ]
      parameter do
        key :name, :onestop_id
        key :in, :query
        key :description, 'Onestop ID(s) to filter by'
        key :required, false
        key :type, :string
      end
      parameter do
        key :name, :servedBy
        key :in, :query
        key :description, 'operator Onestop ID(s) to filter by'
        key :required, false
        key :type, :string
      end
      response 200 do
        # key :description, 'stop response'
        schema do
          key :type, :array
          items do
            key :'$ref', :FeedVersion
          end
        end
      end
    end
  end
  def index
    @feed_versions = FeedVersion.where('').includes{[
      feed,
      feed_version_imports,
      feed.active_feed_version,
      changesets_imported_from_this_feed_version
    ]}

    @feed_versions = AllowFiltering.by_updated_since(@feed_versions, params)

    if params[:ids].present? || params[:sha1].present?
      sha1s = []
      if params[:sha1].present?
        if params[:sha1].is_a?(Array) # for Ember Data
          sha1s += params[:sha1]
        elsif params[:sha1].is_a?(String)
          sha1s += params[:sha1].split(',')
        end
      end
      if params[:ids].present?
        if params[:ids].is_a?(Array) # for Ember Data
          sha1s += params[:ids]
        elsif params[:ids].is_a?(String)
          sha1s += params[:ids].split(',')
        end
      end
      @feed_versions = @feed_versions.where(sha1: sha1s)
    end

    if params[:calendar_coverage_begins_at_or_before].present?
      @feed_versions = @feed_versions.where_calendar_coverage_begins_at_or_before(
        params[:calendar_coverage_begins_at_or_before]
      )
    end

    if params[:calendar_coverage_begins_at_or_after].present?
      @feed_versions = @feed_versions.where_calendar_coverage_begins_at_or_after(
        params[:calendar_coverage_begins_at_or_after]
      )
    end

    if params[:calendar_coverage_includes].present?
      @feed_versions = @feed_versions.where_calendar_coverage_includes(
        params[:calendar_coverage_includes]
      )
    end

    if params[:feed_onestop_id].present?
      feed_onestop_ids = params[:feed_onestop_id].split(',')
      @feed_versions = @feed_versions.where(feed: Feed.where(onestop_id: feed_onestop_ids))
    end

    @feed_versions = @feed_versions.includes(:issues) if AllowFiltering.to_boolean(params[:embed_issues])

    respond_to do |format|
      format.json { render paginated_json_collection(@feed_versions).merge({ scope: { embed_issues: AllowFiltering.to_boolean(params[:embed_issues]) } }) }
      format.csv { return_downloadable_csv(@feed_versions, 'feed_versions') }
    end
  end

  include Swagger::Blocks
  swagger_path '/feed_versions/{sha1}' do
    operation :get do
      key :tags, ['feed']
      key :name, :tags
      key :summary, 'Returns a single feed version'
      key :produces, ['application/json']
      parameter do
        key :name, :sha1
        key :in, :path
        key :description, 'SHA1 hash for feed version'
        key :required, true
        key :type, :string
      end
      response 200 do
        # key :description, 'stop response'
        schema do
          key :'$ref', :FeedVersion
        end
      end
    end
  end
  def show
    respond_to do |format|
      format.json { render json: @feed_version, scope: { embed_issues: AllowFiltering.to_boolean(params[:embed_issues]) } }
    end

  end

  include Swagger::Blocks
  swagger_path '/feed_versions/{sha1}' do
    operation :put do
      key :tags, ['feed']
      key :name, :tags
      key :summary, "Set a feed version's import level"
      key :produces, ['application/json']
      parameter do
        key :name, :sha1
        key :in, :path
        key :description, 'SHA1 hash for feed version'
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, :import_level
        key :in, :body
        key :description, 'Import level to set for feed version'
        key :required, true
        key :type, :integer
      end
      response 200 do
        # key :description, 'stop response'
        schema do
          key :'$ref', :FeedVersion
        end
      end
    end
  end
  def update
    @feed_version.update!(feed_version_params)
    render json: @feed_version
  end

  private

  def set_feed_version
    @feed_version = FeedVersion.find_by!(sha1: params[:id])
  end

  def feed_version_params
    params.require(:feed_version).permit(:import_level)
  end
end
