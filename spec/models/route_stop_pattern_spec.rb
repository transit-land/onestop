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
#  created_or_updated_in_changeset_id :integer
#  is_generated                       :boolean          default(FALSE)
#  is_modified                        :boolean          default(FALSE)
#  is_only_stop_points                :boolean          default(FALSE)
#  trips                              :string           default([]), is an Array
#  identifiers                        :string           default([]), is an Array
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  route_id                           :integer
#
# Indexes
#
#  index_current_route_stop_patterns_on_identifiers  (identifiers)
#  index_current_route_stop_patterns_on_route_id     (route_id)
#

describe RouteStopPattern do
  before(:each) do
    create(:stop,
      onestop_id: "s-9q8yw8y448-bayshorecaltrainstation",
      geometry: point = Stop::GEOFACTORY.point(-122.401811, 37.706675).to_s
    )
    create(:stop,
      onestop_id: "s-9q8yyugptw-sanfranciscocaltrainstation",
      geometry: point = Stop::GEOFACTORY.point(-122.394935, 37.776348).to_s
    )
  end

  context 'creation' do
    before (:each) do
      points = [[-122.401811, 37.706675],[-122.394935, 37.776348]]
      @geom = RouteStopPattern::GEOFACTORY.line_string(
        points.map {|lon, lat| RouteStopPattern::GEOFACTORY.point(lon, lat)}
      )
      @sp = ["s-9q8yw8y448-bayshorecaltrainstation", "s-9q8yyugptw-sanfranciscocaltrainstation"]
    end

    it 'can be created' do
      rsp = create(:route_stop_pattern, stop_pattern: @sp, geometry: @geom, onestop_id: 'r-9q9j-bullet-S1-G1')
      expect(RouteStopPattern.exists?(rsp.id)).to be true
      expect(RouteStopPattern.find(rsp.id).stop_pattern).to match_array(@sp)
      expect(RouteStopPattern.find(rsp.id).geometry[:coordinates]).to eq @geom.points.map{|p| [p.x,p.y]}
    end

    it 'cannot be created when stop_pattern has less than two stops' do
      rsp = expect(
        build(:route_stop_pattern,
              stop_pattern: ["s-9q8yw8y448-bayshorecaltrainstation"],
              geometry: @geom,
              onestop_id: 'r-9q9j-bullet-S1-G1'
        ).valid?
      ).to be false
    end

    it 'cannot be created when geometry has less than two points' do
      rsp = build(:route_stop_pattern,
            stop_pattern: @sp,
            geometry: @geom,
            onestop_id: 'r-9q9j-bullet-S1-G1'
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

  it 'can be found by stops' do
    points = [[-122.401811, 37.706675],[-122.394935, 37.776348]]
    geom = RouteStopPattern::GEOFACTORY.line_string(
      points.map {|lon, lat| RouteStopPattern::GEOFACTORY.point(lon, lat)}
    )
    sp = ["s-9q8yw8y448-bayshorecaltrainstation", "s-9q8yyugptw-sanfranciscocaltrainstation"]
    rsp = create(:route_stop_pattern, stop_pattern: sp, geometry: geom, onestop_id: 'r-9q9j-bullet-S1-G1')
    expect(RouteStopPattern.with_stops('s-9q8yw8y448-bayshorecaltrainstation')).to match_array([rsp])
    expect(RouteStopPattern.with_stops('s-9q8yw8y448-bayshorecaltrainstation,s-9q8yyugptw-sanfranciscocaltrainstation')).to match_array([rsp])
    expect(RouteStopPattern.with_stops('s-9q9k659e3r-sanjosecaltrainstation')).to match_array([])
    expect(RouteStopPattern.with_stops('s-9q8yw8y448-bayshorecaltrainstation,s-9q9k659e3r-sanjosecaltrainstation')).to match_array([])
  end

  it 'can be found by trips' do
    points = [[-122.401811, 37.706675],[-122.394935, 37.776348]]
    geom = RouteStopPattern::GEOFACTORY.line_string(
      points.map {|lon, lat| RouteStopPattern::GEOFACTORY.point(lon, lat)}
    )
    sp = ["s-9q8yw8y448-bayshorecaltrainstation", "s-9q8yyugptw-sanfranciscocaltrainstation"]
    rsp = create(:route_stop_pattern, stop_pattern: sp, geometry: geom, onestop_id: 'r-9q9j-bullet-S1-G1', trips: ['trip1','trip2'])
    expect(RouteStopPattern.with_trips('trip1')).to match_array([rsp])
    expect(RouteStopPattern.with_trips('trip1,trip2')).to match_array([rsp])
    expect(RouteStopPattern.with_trips('trip3')).to match_array([])
    expect(RouteStopPattern.with_trips('trip1,trip3')).to match_array([])
  end

  context 'calculate_distances' do
    before(:each) do
      create(:stop,
        onestop_id: "s-9q9k659e3r-sanjosecaltrainstation",
        geometry: point = Stop::GEOFACTORY.point(-121.902181, 37.329392).to_s
      )
      create(:stop,
        onestop_id: "s-9q9hxhecje-sunnyvalecaltrainstation",
        geometry: point = Stop::GEOFACTORY.point(-122.030742, 37.378427).to_s
      )
      create(:stop,
        onestop_id: "s-9q9hwp6epk-mountainviewcaltrainstation",
        geometry: point = Stop::GEOFACTORY.point(-122.076327, 37.393879).to_s
      )
      @rsp = RouteStopPattern.new(
        stop_pattern: ["s-9q9k659e3r-sanjosecaltrainstation",
                       "s-9q9hxhecje-sunnyvalecaltrainstation",
                       "s-9q9hwp6epk-mountainviewcaltrainstation"],
        geometry: RouteStopPattern.line_string([[-121.902181, 37.329392],[-122.030742, 37.378427],[-122.076327, 37.393879]])
      )
    end

    it 'can calculate distances when the geometry and stop coordinates are equal' do
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.1).of(17001.5107)])
    end

    it 'can calculate distances when a stop is on a segment between two geometry coordinates' do
      mv_syvalue_midpoint = [(@rsp.geometry[:coordinates][2][0] + @rsp.geometry[:coordinates][1][0])/2.0,
                             (@rsp.geometry[:coordinates][2][1] + @rsp.geometry[:coordinates][1][1])/2.0]
      create(:stop,
        onestop_id: "s-9q9hwtgq4s-midpoint",
        geometry: point = Stop::GEOFACTORY.point(mv_syvalue_midpoint[0], mv_syvalue_midpoint[1]).to_s
      )
      @rsp.stop_pattern = ["s-9q9k659e3r-sanjosecaltrainstation",
                           "s-9q9hxhecje-sunnyvalecaltrainstation",
                           "s-9q9hwtgq4s-midpoint",
                           "s-9q9hwp6epk-mountainviewcaltrainstation"]
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.1).of(14809.7189),
                                                              a_value_within(0.1).of(17001.5107)])
    end

    it 'can calculate distances when a stop is between two geometry coordinates but not on a segment' do
      create(:stop,
       onestop_id: "s-9q9hwtgq4s-midpoint~perpendicular~offset",
       geometry: point = Stop::GEOFACTORY.point(-122.0519858, 37.39072182536).to_s
      )
      @rsp.stop_pattern = ["s-9q9k659e3r-sanjosecaltrainstation",
                           "s-9q9hxhecje-sunnyvalecaltrainstation",
                           "s-9q9hwtgq4s-midpoint~perpendicular~offset",
                           "s-9q9hwp6epk-mountainviewcaltrainstation"]
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                              a_value_within(0.1).of(12617.9271),
                                                              a_value_within(0.5).of(14809.7189),
                                                              a_value_within(0.1).of(17001.5107)])
    end

    it 'can calculate distances by matching stops to the right segments if considered sequentially' do
      create(:stop,
        onestop_id: "s-dqcjq9vgbv-A",
        geometry: point = Stop::GEOFACTORY.point(-77.050171, 38.901890).to_s
      )
      create(:stop,
        onestop_id: "s-dqcjq9vc13-B",
        geometry: point = Stop::GEOFACTORY.point(-77.050155, 38.901394).to_s
      )

      @loop_rsp = RouteStopPattern.new(stop_pattern: ["s-dqcjq9vgbv-A", "s-dqcjq9vc13-B"], geometry: RouteStopPattern.line_string(
        [[-77.050176, 38.900751],
        [-77.050187, 38.901394],
        [-77.050187, 38.901920],
        [-77.050702, 38.902195],
        [-77.050777, 38.902638],
        [-77.050401, 38.903005],
        [-77.049961, 38.903034],
        [-77.049634, 38.902901],
        [-77.049473, 38.902638],
        [-77.049527, 38.902312],
        [-77.049725, 38.902078],
        [-77.050069, 38.901978],
        [-77.050074, 38.901389],
        [-77.050048, 38.900776]]
      ))

      expect(@loop_rsp.calculate_distances).to match_array(
        [a_value_within(0.1).of(126.80),
        a_value_within(0.1).of(553.56)]
      )
    end

    it 'can calculate distances when a stop is before the first point of a geometry' do
      create(:stop,
        onestop_id: "s-9q9hwp6epk-before~geometry",
        geometry: point = Stop::GEOFACTORY.point(-121.5, 37.30).to_s
      )
      @rsp.stop_pattern = ["s-9q9hwp6epk-before~geometry",
                           "s-9q9k659e3r-sanjosecaltrainstation",
                           "s-9q9hxhecje-sunnyvalecaltrainstation",
                           "s-9q9hwp6epk-mountainviewcaltrainstation"]
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                       a_value_within(0.1).of(35756.8357),
                                                       a_value_within(0.1).of(48374.7628),
                                                       a_value_within(0.1).of(52758.3464)])
    end

    it 'can calculate distances when a stop is after the last point of a geometry' do
      create(:stop,
       onestop_id: "s-9q9hwp6epk-after~geometry",
       geometry: point = Stop::GEOFACTORY.point(-122.1, 37.41).to_s
      )
      @rsp.stop_pattern << "s-9q9hwp6epk-after~geometry"
      expect(@rsp.calculate_distances).to match_array([a_value_within(0.1).of(0.0),
                                                       a_value_within(0.1).of(12617.9271),
                                                       a_value_within(0.1).of(17001.5107),
                                                       a_value_within(0.1).of(19758.8669)])
    end
  end

  context 'without shape or shape points' do
    before(:each) do
      @trip = GTFS::Trip.new(trip_id: 'test')
      @empty_rsp = RouteStopPattern.new(stop_pattern: [], geometry: RouteStopPattern.line_string([]))
      @geom_rsp = RouteStopPattern.new(
        stop_pattern: ["s-9q8yw8y448-bayshorecaltrainstation", "s-9q8yyugptw-sanfranciscocaltrainstation"],
        geometry: RouteStopPattern.line_string([[-122.401811, 37.706675],[-122.394935, 37.776348]])
      )
    end

    it 'is marked as empty after evaluation' do
      expect(@empty_rsp.evaluate_geometry(@trip, [])[:empty]).to be true
      expect(@geom_rsp.evaluate_geometry(@trip, [])[:empty]).to be true

      @trip.shape_id = 'test_shape'
      expect(@empty_rsp.evaluate_geometry(@trip, [])[:empty]).to be true
      expect(@geom_rsp.evaluate_geometry(@trip, [])[:empty]).to be false
    end

    it 'adds geometry consisting of stop points' do
      issues = {:empty => true}
      stop_points = [[-122.401811, 37.706675],[-122.394935, 37.776348]]
      @empty_rsp.tl_geometry(stop_points, issues)
      expect(@empty_rsp.geometry[:coordinates]).to eq(stop_points)
      expect(@empty_rsp.is_generated).to be true
      expect(@empty_rsp.is_modified).to be true
    end

    it 'RouteStopPattern.inspect_geometry' do
      @geom_rsp.inspect_geometry
      expect(@geom_rsp.is_only_stop_points).to be true

      @geom_rsp.geometry = RouteStopPattern.line_string([[-121.902181, 37.329392],[-122.030742, 37.378427],[-122.076327, 37.393879]])
      @geom_rsp.inspect_geometry
      expect(@geom_rsp.is_only_stop_points).to be false
    end
  end
end
