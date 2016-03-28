class Api::V1::RouteStopPatternsController < Api::V1::BaseApiController
  include JsonCollectionPagination
  include DownloadableCsv
  include AllowFiltering
  include Geojson
  GEOJSON_ENTITY_PROPERTIES = Proc.new { |properties, entity|
    # properties for GeoJSON simple style spec
    properties[:title] = "Route stop pattern #{entity.onestop_id}"
    properties[:stroke] = "##{entity.route.color}" if entity.route.color.present?

    properties[:route_onestop_id] = entity.route.onestop_id
    properties[:stop_pattern] = entity.stop_pattern
    properties[:is_generated] = entity.is_generated
    properties[:is_modified] = entity.is_modified
    properties[:color] = entity.route.color
  }

  before_action :set_route_stop_pattern, only: [:show]

  def index
    @rsps = RouteStopPattern.where('')

    @rsps = AllowFiltering.by_onestop_id(@rsps, params)
    @rsps = AllowFiltering.by_tag_keys_and_values(@rsps, params)
    @rsps = AllowFiltering.by_identifer_and_identifier_starts_with(@rsps, params)
    @rsps = AllowFiltering.by_updated_since(@rsps, params)

    if params[:bbox].present?
      @rsps = @rsps.geometry_within_bbox(params[:bbox])
    end

    if params[:traversed_by].present?
      @rsps = @rsps.where(route: Route.find_by_onestop_id!(params[:traversed_by]))
    end

    if params[:trips].present?
      @rsps = @rsps.with_trips(params[:trips])
    end

    if params[:stops_visited].present?
      @rsps = @rsps.with_stops(params[:stops_visited])
    end

    @rsps = @rsps.includes{[
      route,
      imported_from_feeds,
      imported_from_feed_versions
    ]}

    respond_to do |format|
      format.json do
        render paginated_json_collection(
          @rsps,
          Proc.new { |params| api_v1_route_stop_patterns_url(params) },
          params[:sort_key],
          params[:sort_order],
          params[:offset],
          params[:per_page],
          params[:total],
          params.slice(:onestop_id, :traversed_by, :trip, :bbox, :stop_visited)
        )
      end
      format.geojson do
        render json: Geojson.from_entity_collection(@rsps, &GEOJSON_ENTITY_PROPERTIES)
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        render json: @route_stop_pattern
      end
      format.geojson do
        render json: Geojson.from_entity(@route_stop_pattern, &GEOJSON_ENTITY_PROPERTIES)
      end
    end
  end

  private

  def set_route_stop_pattern
    @route_stop_pattern = RouteStopPattern.find_by_onestop_id!(params[:id])
  end
end
