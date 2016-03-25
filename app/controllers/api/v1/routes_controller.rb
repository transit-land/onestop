class Api::V1::RoutesController < Api::V1::BaseApiController
  include JsonCollectionPagination
  include DownloadableCsv
  include AllowFiltering
  include Geojson
  GEOJSON_ENTITY_PROPERTIES = Proc.new { |properties, entity|
    # properties for GeoJSON simple style spec
    properties[:title] = entity.name
    properties[:stroke] = "##{entity.color}" if entity.color.present?

    properties[:vehicle_type] = entity.vehicle_type
    properties[:color] = entity.color
    properties[:operated_by_onestop_id] = entity.operator.try(:onestop_id)
    properties[:operated_by_name] = entity.operator.try(:name)
    properties[:route_stop_patterns_by_onestop_id] = entity.route_stop_patterns.map(&:onestop_id)
  }

  before_action :set_route, only: [:show]

  def index
    @routes = Route.where('')

    @routes = AllowFiltering.by_onestop_id(@routes, params)
    @routes = AllowFiltering.by_tag_keys_and_values(@routes, params)
    @routes = AllowFiltering.by_identifer_and_identifier_starts_with(@routes, params)
    @routes = AllowFiltering.by_updated_since(@routes, params)

    if params[:operated_by].present? || params[:operatedBy].present?
      # we previously allowed `operatedBy`, so we'll continue to honor that for the time being
      operator_onestop_id = params[:operated_by] || params[:operatedBy]
      @routes = @routes.operated_by(operator_onestop_id)
    end
    if params[:traverses].present?
      @routes = @routes.traverses(params[:traverses].split(','))
    end
    if params[:vehicle_type].present?
      # some count be integers, some could be strings
      vehicle_types_mixed = params[:vehicle_type].split(',')
      # turn them all into integers
      vehicle_types_integers = vehicle_types_mixed.map do |vt|
        if vt.match(/\d+/)
          vt.to_i
        elsif vt.to_s
          GTFS::Route::VEHICLE_TYPES.invert[vt.to_s.titleize.to_sym].to_s.to_i
        end
      end
      @routes = @routes.where(vehicle_type: vehicle_types_integers)
    end
    if params[:bbox].present?
      @routes = @routes.stop_within_bbox(params[:bbox])
    end
    if params[:color].present?
      if ['true', true].include?(params[:color])
        @routes = @routes.where.not(color: nil)
      else
        @routes = @routes.where(color: params[:color].upcase)
      end
    end
    if params[:import_level].present?
      @routes = @routes.where_import_level(AllowFiltering.param_as_array(params, :import_level))
    end

    @routes = @routes.includes{[
      operator,
      route_stop_patterns,
      imported_from_feeds,
      imported_from_feed_versions
    ]}

    respond_to do |format|
      format.json do
        render paginated_json_collection(
          @routes,
          Proc.new { |params| api_v1_routes_url(params) },
          params[:sort_key],
          params[:sort_order],
          params[:offset],
          params[:per_page],
          params[:total],
          params.slice(
            :identifier,
            :identifier_starts_with,
            :operated_by,
            :operatedBy,
            :color,
            :vehicle_type,
            :bbox,
            :onestop_id,
            :tag_key,
            :tag_value,
            :import_level
          )
        )
      end
      format.geojson do
        render json: Geojson.from_entity_collection(@routes, &GEOJSON_ENTITY_PROPERTIES)
      end
      format.csv do
        return_downloadable_csv(@routes, 'routes')
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        render json: @route
      end
      format.geojson do
        render json: Geojson.from_entity(@route, &GEOJSON_ENTITY_PROPERTIES)
      end
    end
  end

  private

  def set_route
    @route = Route.find_by_onestop_id!(params[:id])
  end
end
