class Api::V1::RoutesController < Api::V1::BaseApiController
  include JsonCollectionPagination
  include DownloadableCsv
  include AllowFiltering

  before_action :set_route, only: [:show]

  # GET /routes
  include Swagger::Blocks
  swagger_path '/routes' do
    operation :get do
      key :tags, ['route']
      key :name, :tags
      key :summary, 'Returns all routes with filtering and sorting'
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
            key :'$ref', :Route
          end
        end
      end
    end
  end
  def index
    # Entity
    @routes = Route.where('')
    @routes = AllowFiltering.by_onestop_id(@routes, params)
    @routes = AllowFiltering.by_tag_keys_and_values(@routes, params)
    @routes = AllowFiltering.by_updated_since(@routes, params)

    # Imported From Feed
    if params[:imported_from_feed].present?
      @routes = @routes.where_imported_from_feed(Feed.find_by_onestop_id(params[:imported_from_feed]))
    end
    if params[:imported_from_feed_version].present?
      @routes = @routes.where_imported_from_feed_version(FeedVersion.find_by!(sha1: params[:imported_from_feed_version]))
    end
    if params[:imported_from_active_feed_version].presence.eql?("true")
      @routes = @routes.where_imported_from_active_feed_version
    end
    if params[:imported_with_gtfs_id].present?
      @routes = @routes.where_imported_with_gtfs_id(params[:gtfs_id])
    end
    if params[:import_level].present?
      @routes = @routes.where_import_level(AllowFiltering.param_as_array(params, :import_level))
    end

    # Geometry
    if [params[:lat], params[:lon]].map(&:present?).all?
      point = Route::GEOFACTORY.point(params[:lon], params[:lat])
      r = params[:r] || 100 # meters TODO: move this to a more logical place
      @routes = @routes.where{st_dwithin(geometry, point, r)}.order{st_distance(geometry, point)}
    end
    if params[:bbox].present?
      @routes = @routes.stop_within_bbox(params[:bbox])
    end

    # Routes
    if params[:serves].present?
      @routes = @routes.where_serves(AllowFiltering.param_as_array(params, :serves))
    end
    if params[:operated_by].present? || params[:operatedBy].present?
      # we previously allowed `operatedBy`, so we'll continue to honor that for the time being
      param = params[:operated_by].present? ? :operated_by : :operatedBy
      operator_onestop_ids = AllowFiltering.param_as_array(params, param)
      @routes = @routes.operated_by(operator_onestop_ids)
    end
    if params[:traverses].present?
      @routes = @routes.traverses(params[:traverses].split(','))
    end
    if params[:vehicle_type].present?
      # some could be integers, some could be strings
      @routes = @routes.where_vehicle_type(AllowFiltering.param_as_array(params, :vehicle_type))
    end
    if params[:color].present?
      if ['true', true].include?(params[:color])
        @routes = @routes.where.not(color: nil)
      else
        @routes = @routes.where(color: params[:color].upcase)
      end
    end
    if params[:wheelchair_accessible].present?
      @routes = @routes.where(wheelchair_accessible: params[:wheelchair_accessible])
    end
    if params[:bikes_allowed].present?
      @routes = @routes.where(bikes_allowed: params[:bikes_allowed])
    end

    # Includes
    @routes = @routes.includes{[
      operator,
      stops,
      route_stop_patterns,
      imported_from_feeds,
      imported_from_feed_versions
    ]}
    @routes = @routes.includes(:issues) if AllowFiltering.to_boolean(params[:embed_issues])

    respond_to do |format|
      # consider removing exclude_geometry
      format.json { render paginated_json_collection(@routes).merge({ scope: { exclude_geometry: AllowFiltering.to_boolean(params[:exclude_geometry]),
                                                                               include_geometry: AllowFiltering.to_boolean(params[:include_geometry]),
                                                                               embed_issues: AllowFiltering.to_boolean(params[:embed_issues]) } })
      }
      format.geojson { render paginated_geojson_collection(@routes) }
      format.csv { return_downloadable_csv(@routes, 'routes') }
    end
  end

  # GET /routes/{onestop_id}
  include Swagger::Blocks
  swagger_path '/routes/{onestop_id}' do
    operation :get do
      key :tags, ['route']
      key :name, :tags
      key :summary, 'Returns a single route'
      key :produces, [
        'application/json',
        # TODO: 'application/vnd.geo+json'
      ]
      parameter do
        key :name, :onestop_id
        key :in, :path
        key :description, 'Onestop ID for route'
        key :required, true
        key :type, :string
      end
      response 200 do
        # key :description, 'stop response'
        schema do
          key :'$ref', :Route
        end
      end
    end
  end
  def show
    respond_to do |format|
      # consider removing exclude_geometry
      format.json { render json: @route, scope: { exclude_geometry: AllowFiltering.to_boolean(params[:exclude_geometry]),
                                                  include_geometry: AllowFiltering.to_boolean(params[:include_geometry]),
                                                  embed_issues: AllowFiltering.to_boolean(params[:embed_issues])} }
      format.geojson { render json: @route, serializer: GeoJSONSerializer }
    end
  end

  private

  def query_params
    params.slice(
      :operated_by,
      :operatedBy,
      :color,
      :vehicle_type,
      :bbox,
      :onestop_id,
      :tag_key,
      :tag_value,
      :import_level,
      :imported_from_feed,
      :imported_from_feed_version,
      :exclude_geometry,
      :include_geometry
    )
  end

  def set_route
    @route = Route.find_by_onestop_id!(params[:id])
  end
end
