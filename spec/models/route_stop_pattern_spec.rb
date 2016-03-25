# == Schema Information
#
# Table name: current_route_stop_patterns
#
#  id                                 :integer          not null, primary key
#  onestop_id                         :string
#  geometry                           :geography({:srid geometry, 4326
#  tags                               :hstore
#  stop_pattern                       :string           default([]), is an Array
#  version                            :integer
#  is_generated                       :boolean          default(FALSE)
#  is_modified                        :boolean          default(FALSE)
#  trips                              :string           default([]), is an Array
#  identifiers                        :string           default([]), is an Array
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  created_or_updated_in_changeset_id :integer
#  route_id                           :integer
#
# Indexes
#
#  c_rsp_cu_in_changeset                              (created_or_updated_in_changeset_id)
#  index_current_route_stop_patterns_on_identifiers   (identifiers)
#  index_current_route_stop_patterns_on_onestop_id    (onestop_id)
#  index_current_route_stop_patterns_on_route_id      (route_id)
#  index_current_route_stop_patterns_on_stop_pattern  (stop_pattern)
#  index_current_route_stop_patterns_on_trips         (trips)
#

# duplicate of gtfs_graph_spec function
def load_feed(feed_version_name: nil, feed_version: nil, import_level: 1)
  feed_version = create(feed_version_name) if feed_version.nil?
  feed = feed_version.feed
  graph = GTFSGraph.new(feed_version.file.path, feed, feed_version)
  graph.create_change_osr
  if import_level >= 2
    graph.ssp_schedule_async do |trip_ids, agency_map, route_map, stop_map, rsp_map|
      graph.ssp_perform_async(trip_ids, agency_map, route_map, stop_map, rsp_map)
    end
  end
  feed.activate_feed_version(feed_version.sha1, import_level)
  return feed, feed_version
end

describe RouteStopPattern do
  let(:stop_1) { create(:stop,
    onestop_id: "s-9q8yw8y448-bayshorecaltrainstation",
    geometry: Stop::GEOFACTORY.point(-122.401811, 37.706675).to_s
  )}
  let(:stop_2) { create(:stop,
    onestop_id: "s-9q8yyugptw-sanfranciscocaltrainstation",
    geometry: Stop::GEOFACTORY.point(-122.394935, 37.776348).to_s
  )}
  let(:stop_a) { create(:stop,
    onestop_id: "s-9q9k659e3r-sanjosecaltrainstation",
    geometry: Stop::GEOFACTORY.point(-121.902181, 37.329392).to_s
  )}
  let(:stop_b) { create(:stop,
    onestop_id: "s-9q9hxhecje-sunnyvalecaltrainstation",
    geometry: Stop::GEOFACTORY.point(-122.030742, 37.378427).to_s
  )}
  let(:stop_c) { create(:stop,
    onestop_id: "s-9q9hwp6epk-mountainviewcaltrainstation",
    geometry: Stop::GEOFACTORY.point(-122.076327, 37.393879).to_s
  )}
  let(:route_onestop_id) { 'r-9q9j-bullet' }

  before(:each) do
    @geom_points = [[-122.401811, 37.706675],[-122.394935, 37.776348]]
    @geom = RouteStopPattern::GEOFACTORY.line_string(
      @geom_points.map {|lon, lat| RouteStopPattern::GEOFACTORY.point(lon, lat)}
    )
    @sp = [stop_1.onestop_id, stop_2.onestop_id]
    @onestop_id = OnestopId::RouteStopPatternOnestopId.new(route_onestop_id: route_onestop_id,
                                                           stop_pattern: @sp,
                                                           geometry_coords: @geom.coordinates).to_s
    @rsp = RouteStopPattern.new(
     stop_pattern: @sp,
     geometry: @geom
    )
  end

  context 'creation' do

    it 'can be created' do
      rsp = create(:route_stop_pattern, stop_pattern: @sp, geometry: @geom, onestop_id: @onestop_id)
      expect(RouteStopPattern.exists?(rsp.id)).to be true
      expect(RouteStopPattern.find(rsp.id).stop_pattern).to match_array(@sp)
      expect(RouteStopPattern.find(rsp.id).geometry[:coordinates]).to eq @geom.points.map{|p| [p.x,p.y]}
    end

    it 'cannot be created when stop_pattern has less than two stops' do
      sp = [stop_1.onestop_id]
      rsp = expect(build(:route_stop_pattern, stop_pattern: sp, geometry: @geom, onestop_id: @onestop_id)
        .valid?
      ).to be false
    end

    it 'cannot be created when geometry has less than two points' do
      rsp = build(:route_stop_pattern,
            stop_pattern: @sp,
            geometry: @geom,
            onestop_id: @onestop_id
      )
      points = [[-122.401811, 37.706675]]
      geom = RouteStopPattern::GEOFACTORY.line_string(
        points.map {|lon, lat| RouteStopPattern::GEOFACTORY.point(lon, lat)}
      )
      rsp.geometry = geom
      rsp = expect(rsp.valid?).to be false
    end
  end

  it 'can create new geometry' do
    expect(RouteStopPattern.line_string([[1,2],[2,2]]).is_a?(RGeo::Geographic::SphericalLineStringImpl)).to be true
  end

  it '#simplify_geometry' do
    expect(RouteStopPattern.simplify_geometry([[-122.0123456,45.01234567],
                                               [-122.0123478,45.01234589],
                                               [-123.0,45.0]])).to match_array([[-122.01235,45.01235],[-123.0,45.0]])
  end

  it '#set_precision' do
    expect(RouteStopPattern.set_precision([[-122.0123456,45.01234567],
                                           [-122.9123478,45.91234589]])).to match_array([[-122.01235,45.01235],[-122.91235,45.91235]])
  end

  it '#remove_duplicate_points' do
    expect(RouteStopPattern.remove_duplicate_points([[-122.0123,45.0123],
                                                     [-122.0123,45.0123],
                                                     [-122.9876,45.9876],
                                                     [-122.0123,45.0123]])).to match_array([[-122.0123,45.0123],[-122.9876,45.9876],[-122.0123,45.0123]])
  end

  context 'new import' do
    before(:each) do
      @route = create(:route, onestop_id: route_onestop_id)
      @saved_rsp = create(:route_stop_pattern, stop_pattern: @sp, geometry: @geom, onestop_id: @onestop_id, route: @route)
      import_sp = [ stop_a.onestop_id, stop_b.onestop_id, stop_c.onestop_id ]
      import_geometry = RouteStopPattern.line_string([stop_a.geometry[:coordinates],
                                                      stop_b.geometry[:coordinates],
                                                      stop_c.geometry[:coordinates]])
      import_onestop_id = OnestopId::RouteStopPatternOnestopId.new(route_onestop_id: route_onestop_id,
                                                                  stop_pattern: import_sp,
                                                                  geometry_coords: import_geometry.coordinates).to_s
      @import_rsp = RouteStopPattern.new(
        onestop_id: import_onestop_id,
        stop_pattern: import_sp,
        geometry: import_geometry,
        route: @route
      )
    end
  end

  it 'can be found by stops' do
    rsp = create(:route_stop_pattern, stop_pattern: @sp, geometry: @geom, onestop_id: @onestop_id)
    expect(RouteStopPattern.with_stops('s-9q8yw8y448-bayshorecaltrainstation')).to match_array([rsp])
    expect(RouteStopPattern.with_stops('s-9q8yw8y448-bayshorecaltrainstation,s-9q8yyugptw-sanfranciscocaltrainstation')).to match_array([rsp])
    expect(RouteStopPattern.with_stops('s-9q9k659e3r-sanjosecaltrainstation')).to match_array([])
    expect(RouteStopPattern.with_stops('s-9q8yw8y448-bayshorecaltrainstation,s-9q9k659e3r-sanjosecaltrainstation')).to match_array([])
  end

  it 'can be found by trips' do
    rsp = create(:route_stop_pattern, stop_pattern: @sp, geometry: @geom, onestop_id: @onestop_id, trips: ['trip1','trip2'])
    expect(RouteStopPattern.with_trips('trip1')).to match_array([rsp])
    expect(RouteStopPattern.with_trips('trip1,trip2')).to match_array([rsp])
    expect(RouteStopPattern.with_trips('trip3')).to match_array([])
    expect(RouteStopPattern.with_trips('trip1,trip3')).to match_array([])
  end

  context 'calculate_distances' do
    before(:each) do
      @sp = [stop_a.onestop_id,
             stop_b.onestop_id,
             stop_c.onestop_id]
      @geom = RouteStopPattern.line_string([stop_a.geometry[:coordinates],
                                            stop_b.geometry[:coordinates],
                                            stop_c.geometry[:coordinates]])
      @rsp = RouteStopPattern.new(
        stop_pattern: @sp,
        geometry: @geom
      )
      @rsp.route = Route.new(onestop_id: route_onestop_id)
      @rsp.onestop_id = OnestopId::RouteStopPatternOnestopId.new(route_onestop_id: route_onestop_id,
                                                             stop_pattern: @sp,
                                                             geometry_coords: @geom.coordinates).to_s
      @trip = GTFS::Trip.new(trip_id: 'test', shape_id: 'test')
    end

    it 'can calculate distances when the geometry and stop coordinates are equal' do
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.1).of(17001.5107)])
    end

    it 'can calculate distances when a stop is on a segment between two geometry coordinates' do
      mv_syvalue_midpoint = [(@rsp.geometry[:coordinates][2][0] + @rsp.geometry[:coordinates][1][0])/2.0,
                             (@rsp.geometry[:coordinates][2][1] + @rsp.geometry[:coordinates][1][1])/2.0]
      midpoint = create(:stop,
        onestop_id: "s-9q9hwtgq4s-midpoint",
        geometry: Stop::GEOFACTORY.point(mv_syvalue_midpoint[0], mv_syvalue_midpoint[1]).to_s
      )
      @rsp.stop_pattern = [stop_a.onestop_id,
                           stop_b.onestop_id,
                           midpoint.onestop_id,
                           stop_c.onestop_id]
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.1).of(14809.7189),
                                                              a_value_within(0.1).of(17001.5107)])
    end

    it 'can calculate distances when a stop is between two geometry coordinates but not on a segment' do
      p_offset = create(:stop,
       onestop_id: "s-9q9hwtgq4s-midpoint~perpendicular~offset",
       geometry: Stop::GEOFACTORY.point(-122.053340913, 37.3867241032).to_s
      )
      @rsp.stop_pattern = [stop_a.onestop_id,
                           stop_b.onestop_id,
                           p_offset.onestop_id,
                           stop_c.onestop_id]
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.5).of(14809.7189),
                                                              a_value_within(0.1).of(17001.5107)])
    end

    it '#distance_along_line_to_nearest' do
      cartesian_line = @rsp.cartesian_cast(@rsp[:geometry])
      # this is the midpoint between stop_a and stop_b, with a little offset
      target_point = @rsp.cartesian_cast(Stop::GEOFACTORY.point(-121.9664615, 37.36))
      locators = cartesian_line.locators(target_point)
      i = @rsp.nearest_segment_index(locators, target_point, 0, locators.size-1)
      nearest_point = @rsp.nearest_point(locators, i)
      expect(@rsp.distance_along_line_to_nearest(cartesian_line, nearest_point, i)).to be_within(0.1).of(6508.84)
    end

    it '#nearest_segment_index' do
      coords = @rsp.geometry[:coordinates].concat [stop_b.geometry[:coordinates],stop_a.geometry[:coordinates]]
      @rsp.geometry = RouteStopPattern.line_string(coords)
      cartesian_line = @rsp.cartesian_cast(@rsp[:geometry])
      # this is the midpoint between stop_a and stop_b, with a little offset
      target_point = @rsp.cartesian_cast(Stop::GEOFACTORY.point(-121.9664615, 37.36))
      locators = cartesian_line.locators(target_point)
      i = @rsp.nearest_segment_index(locators, target_point, 0, locators.size - 1)
      expect(i).to eq 0
      i = @rsp.nearest_segment_index(locators, target_point, 0, locators.size - 1, first=false)
      expect(i).to eq locators.size - 1
    end

    it 'accurately correctly the distances of nyc staten island ferry 2-stop routes with before/after stops' do
      @feed, @feed_version = load_feed(feed_version_name: :feed_version_nycdotsiferry, import_level: 2)
      expect(@feed.imported_route_stop_patterns[0].calculate_distances).to match_array([0.0, 8138.0])
      expect(@feed.imported_route_stop_patterns[1].calculate_distances).to match_array([3.2, 8141.2])
    end

    it 'accurately calculates the distances of a route line that loops back over itself' do
      # see docs/actransit-route-677.png
      @feed, @feed_version = load_feed(feed_version_name: :feed_version_actransit, import_level: 2)
      expect(@feed.imported_route_stop_patterns[0].calculate_distances[14..18]).to match_array([4809.3, 5147.2, 5619.5, 6404.2, 8569.0])
    end

    it 'calculates the first stop distance correctly' do
      # from sfmta route 54 and for regression. case where first stop is not a 'before' stop
      # see docs/first_stop_correct_distance.png
      @feed, @feed_version = load_feed(feed_version_name: :feed_version_sfmta_6720619, import_level: 2)
      rsp = @feed.imported_route_stop_patterns[0]
      stop_points = rsp.stop_pattern.map { |s| Stop.find_by_onestop_id!(s).geometry[:coordinates] }
      # using the fake trip with shape id
      has_issues, issues = rsp.evaluate_geometry(@trip, stop_points)
      rsp.tl_geometry(stop_points, issues)
      distances = rsp.calculate_distances
      expect(distances[0]).to be_within(0.1).of(201.1)
    end

    it 'can accurately calculate distances when a stop is repeated.' do
      # from f-9q9-vta, r-9q9k-66. see docs/repeated_stop_vta_66.png
      @feed, @feed_version = load_feed(feed_version_name: :feed_version_vta_1930705, import_level: 2)
      repeated_rsp = @feed.imported_route_stop_patterns[0]
      stop_points = repeated_rsp.stop_pattern.map { |s| Stop.find_by_onestop_id!(s).geometry[:coordinates] }
      # using the fake trip with shape id
      has_issues, issues = repeated_rsp.evaluate_geometry(@trip, stop_points)
      repeated_rsp.tl_geometry(stop_points, issues)
      distances = repeated_rsp.calculate_distances
      expect(distances[77]).to be > distances[75]
    end

    it 'can accurately calculate distances when a stop matches to a segment before the previous stop\'s matching segment' do
      # from sfmta, N-OWL route. See docs/previous_segment_1_sfmta_n~owl.png and docs/previous_segment_2_sfmta_n~owl.png
      @feed, @feed_version = load_feed(feed_version_name: :feed_version_sfmta_6731593, import_level: 2)
      tricky_rsp = @feed.imported_route_stop_patterns[0]
      stop_points = tricky_rsp.stop_pattern.map { |s| Stop.find_by_onestop_id!(s).geometry[:coordinates] }
      # using the fake trip with shape id
      has_issues, issues = tricky_rsp.evaluate_geometry(@trip, stop_points)
      tricky_rsp.tl_geometry(stop_points, issues)
      distances = tricky_rsp.calculate_distances
      expect(distances[-1]).to be > distances[-2]
    end

    it 'calculates the distance of the first stop to be 0 if it is before the first point of a geometry' do
      @rsp.stop_pattern = @rsp.stop_pattern.unshift(create(:stop,
        onestop_id: "s-9q9hwp6epk-before~geometry",
        geometry: Stop::GEOFACTORY.point(-121.5, 37.30).to_s
      ).onestop_id)
      stop_points = @rsp.geometry[:coordinates].unshift([-121.5, 37.30])
      has_issues, issues = @rsp.evaluate_geometry(@trip, stop_points)
      @rsp.tl_geometry(stop_points, issues)
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                       a_value_within(0.1).of(0.0),
                                                       a_value_within(0.1).of(12617.9),
                                                       a_value_within(0.1).of(17001.5)])
    end

    it 'calculates the distance of the last stop to be the length of the line geometry if it is after the last point of the geometry' do
      @rsp.stop_pattern << create(:stop,
       onestop_id: "s-9q9hwp6epk-after~geometry",
       geometry: Stop::GEOFACTORY.point(-122.1, 37.41).to_s
      ).onestop_id
      @rsp.geometry = RouteStopPattern.line_string(@rsp.geometry[:coordinates] << [-122.09, 37.401])
      distances = @rsp.calculate_distances
      expect(distances[3]).to be_within(0.1).of(@rsp[:geometry].length)
      expect(distances).to match_array([a_value_within(0.1).of(0.0),
                                                       a_value_within(0.1).of(12617.9),
                                                       a_value_within(0.1).of(17001.5),
                                                       a_value_within(0.1).of(18447.4)])
    end

    it 'can continue distance calculation when a stop is an outlier' do
      outlier = create(:stop,
        onestop_id: "s-9q9hwtgq4s-outlier",
        geometry: Stop::GEOFACTORY.point(-63.0, 30.0).to_s
      )
      @rsp.stop_pattern = [stop_a.onestop_id,
                           stop_b.onestop_id,
                           outlier.onestop_id,
                           stop_c.onestop_id]
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.1).of(17001.5107)])
    end

    it 'assign a fallback distance value equal to the geometry length to the last stop if it is an outlier' do
      last_stop_outlier = create(:stop,
        onestop_id: "s-9q9hwtgq4s-last~outlier",
        geometry: Stop::GEOFACTORY.point(-121.5, 37.3).to_s
      )
      @rsp.stop_pattern << last_stop_outlier.onestop_id
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.1).of(17001.5107),
                                                              a_value_within(0.1).of(17001.5107)])
    end

    it 'can calculate distances when two consecutive stop points are identical' do
      identical = create(:stop,
        onestop_id: "s-9q9hwtgq4s-sunnyvaleidentical",
        geometry: stop_b.geometry
      )
      @rsp.stop_pattern = [stop_a.onestop_id,
                           stop_b.onestop_id,
                           identical.onestop_id,
                           stop_c.onestop_id]
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.1).of(17001.5107)])
    end

    it 'handles the sfmta, route 23, rsp r-9q8y-23-e51455-1b44d1 case' do
      @feed, @feed_version = load_feed(feed_version_name: :feed_version_sfmta_23, import_level: 1)
      rsp = @feed.imported_route_stop_patterns[0]
      # TODO: tweak algorithm to handle this case and fill out spec
    end
  end

  context 'determining outlier stops' do
    it 'returns false when the stop is within 100 meters of the closest point on the line' do
      # distance is approx 81 m
      test_stop = create(:stop,
        onestop_id: "s-9q8yw8y448-test",
        geometry: Stop::GEOFACTORY.point(-122.3975, 37.741).to_s
      )
      @rsp.stop_pattern = [@sp[0],test_stop.onestop_id,@sp[1]]
      expect(@rsp.outlier_stop(test_stop[:geometry])).to be false
    end

    it 'returns true when the stop is greater than 100 meters of the closest point on the line' do
      # distance is approx 146 m
      test_stop = create(:stop,
        onestop_id: "s-9q8yw8y448-test",
        geometry: Stop::GEOFACTORY.point(-122.3968, 37.7405).to_s
      )
      @rsp.stop_pattern = [@sp[0],test_stop.onestop_id,@sp[1]]
      expect(@rsp.outlier_stop(test_stop[:geometry])).to be true
    end
  end

  context 'before and after stops' do
    before(:each) do
      @trip = GTFS::Trip.new(trip_id: 'test')
    end

    it 'is marked correctly as having an after stop after evaluation' do
      stop_points = @geom_points << [-122.38, 37.8]
      @trip.shape_id = 'test_shape'
      has_issues, issues = @rsp.evaluate_geometry(@trip, stop_points)
      expect(has_issues).to be true
      expect(issues).to match_array([:has_after_stop])
    end

    it 'does not have an after stop if the last stop is close to the line and below the last stop perpendicular' do
      stop_points = @geom_points << [-122.3975, 37.741]
      @trip.shape_id = 'test_shape'
      has_issues, issues = @rsp.evaluate_geometry(@trip, stop_points)
      expect(has_issues).to be false
      expect(issues).to match_array([])
    end

    it 'has an after stop if the last stop is below the last stop perpendicular but not close enough to the line' do
      stop_points = @geom_points << [-122.39, 37.77]
      @trip.shape_id = 'test_shape'
      has_issues, issues = @rsp.evaluate_geometry(@trip, stop_points)
      expect(has_issues).to be true
      expect(issues).to match_array([:has_after_stop])
    end

    it 'is marked correctly as having a before stop after evaluation' do
      stop_points = @geom_points.unshift([-122.405, 37.63])
      @trip.shape_id = 'test_shape'
      has_issues, issues = @rsp.evaluate_geometry(@trip, stop_points)
      expect(has_issues).to be true
      expect(issues).to match_array([:has_before_stop])
    end

    it 'does not have a before stop if the first stop is close to the line and above the first stop perpendicular' do
      stop_points = @geom_points.unshift([-122.40182, 37.7067])
      @trip.shape_id = 'test_shape'
      has_issues, issues = @rsp.evaluate_geometry(@trip, stop_points)
      expect(has_issues).to be false
      expect(issues).to match_array([])
    end

    it 'has a before stop if the first stop is above the first stop perpendicular but not close enough to the line' do
      stop_points = @geom_points.unshift([-122.40182, 37.72])
      @trip.shape_id = 'test_shape'
      has_issues, issues = @rsp.evaluate_geometry(@trip, stop_points)
      expect(has_issues).to be true
      expect(issues).to match_array([:has_before_stop])
    end
  end

  context 'without shape or shape points' do
    before(:each) do
      @trip = GTFS::Trip.new(trip_id: 'test')
      @empty_rsp = RouteStopPattern.new(stop_pattern: [], geometry: RouteStopPattern.line_string([]))
    end

    it 'is marked as empty after evaluation' do
      has_issues, issues = @empty_rsp.evaluate_geometry(@trip, [])
      expect(has_issues).to be true
      expect(issues).to match_array([:empty])

      has_issues, issues = @rsp.evaluate_geometry(@trip, [])
      expect(has_issues).to be true
      expect(issues).to match_array([:empty])

      @trip.shape_id = 'test_shape'
      has_issues, issues = @empty_rsp.evaluate_geometry(@trip, [])
      expect(has_issues).to be true
      expect(issues).to match_array([:empty])
    end

    it 'adds geometry consisting of stop points' do
      issues = [:empty]
      stop_points = @geom_points
      @empty_rsp.tl_geometry(stop_points, issues)
      expect(@empty_rsp.geometry[:coordinates]).to eq(RouteStopPattern.simplify_geometry(stop_points))
      expect(@empty_rsp.is_generated).to be true
      expect(@empty_rsp.is_modified).to be true
    end
  end
end
