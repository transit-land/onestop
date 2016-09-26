# == Schema Information
#
# Table name: current_stops
#
#  id                                 :integer          not null, primary key
#  onestop_id                         :string
#  geometry                           :geography({:srid geometry, 4326
#  tags                               :hstore
#  created_at                         :datetime
#  updated_at                         :datetime
#  name                               :string
#  created_or_updated_in_changeset_id :integer
#  version                            :integer
#  identifiers                        :string           default([]), is an Array
#  timezone                           :string
#  last_conflated_at                  :datetime
#  type                               :string
#  parent_stop_id                     :integer
#  osm_way_id                         :integer
#  edited_attributes                  :string           default([]), is an Array
#  wheelchair_boarding                :boolean
#
# Indexes
#
#  #c_stops_cu_in_changeset_id_index           (created_or_updated_in_changeset_id)
#  index_current_stops_on_geometry             (geometry)
#  index_current_stops_on_identifiers          (identifiers)
#  index_current_stops_on_onestop_id           (onestop_id) UNIQUE
#  index_current_stops_on_parent_stop_id       (parent_stop_id)
#  index_current_stops_on_tags                 (tags)
#  index_current_stops_on_updated_at           (updated_at)
#  index_current_stops_on_wheelchair_boarding  (wheelchair_boarding)
#

describe Stop do
  it 'can be created' do
    stop = create(:stop)
    expect(Stop.exists?(stop.id)).to be true
  end

  it "won't have extra spaces in its name" do
    stop = create(:stop, name: ' Main St. Stop ')
    expect(stop.name).to eq 'Main St. Stop'
  end

  context 'geometry' do
    it 'can be specified with WKT' do
      stop = create(:stop, geometry: 'POINT(-122.433416 37.732525)')
      expect(Stop.exists?(stop.id)).to be true
      expect(stop.geometry).to eq({ type: 'Point', coordinates: [-122.433416, 37.732525] })
    end

    it 'can be specified with GeoJSON' do
      geojson = { type: 'Point', coordinates: [-122.433416, 37.732525] }
      stop = create(:stop, geometry: geojson)
      expect(Stop.exists?(stop.id)).to be true
      expect(stop.geometry).to eq geojson
    end

    it 'can be read as GeoJSON (by default)' do
      geojson = { type: 'Point', coordinates: [-122.433416, 37.732525] }
      stop = create(:stop, geometry: geojson)
      expect(stop.geometry).to eq geojson
    end

    it 'can be read as WKT' do
      stop = create(:stop, geometry: { type: 'Point', coordinates: [-122.433416, 37.732525] })
      expect(stop.geometry(as: :wkt).to_s).to eq('POINT (-122.433416 37.732525)')
    end

    it 'can provide a centroid when geometry is a polygon' do
      # TODO: rewrite this functionality
    end

    it 'can compute a convex hull around multiple stops' do
      # using similar points to http://turfjs.org/static/docs/module-turf_convex.html
      s1 = build(:stop, geometry: { type: 'Point', coordinates: [10.195312, 43.755225] })
      s2 = build(:stop, geometry: { type: 'Point', coordinates: [10.404052, 43.8424511] })
      s3 = build(:stop, geometry: { type: 'Point', coordinates: [10.579833, 43.659924] })
      s4 = build(:stop, geometry: { type: 'Point', coordinates: [10.360107, 43.516688] })
      s5 = build(:stop, geometry: { type: 'Point', coordinates: [10.14038, 43.588348] })
      s6 = build(:stop, geometry: { type: 'Point', coordinates: [10.255312, 43.605225] })
      s7 = build(:stop, geometry: { type: 'Point', coordinates: [10.394439, 43.902839] })

      unprojected_convex_hull = Stop.convex_hull([s1,s2,s3,s4,s5,s6,s7], as: :wkt)
      expect(unprojected_convex_hull.exterior_ring.num_points).to eq 6

      projected_convex_hull = Stop.convex_hull([s1,s2,s3,s4,s5,s6,s7], as: :wkt, projected: true)
      [s1,s2,s3,s4,s5,s6,s7].each do |stop|
        touches = stop.geometry(as: :wkt, projected: true).touches?(projected_convex_hull)
        within = stop.geometry(as: :wkt, projected: true).within?(projected_convex_hull)
        expect(touches || within).to eq true
      end
    end

    it 'can find stops by bounding box' do
      santa_clara = create(:stop, geometry: { type: 'Point', coordinates: [-121.936376, 37.352915] })
      mountain_view = create(:stop, geometry: { type: 'Point', coordinates: [-122.076327, 37.393879] })
      random = create(:stop, geometry: { type: 'Point', coordinates: [10.195312, 43.755225] })
      expect(Stop.geometry_within_bbox('-122.0,37.25,-121.75,37.5')).to match_array([santa_clara])
      expect(Stop.geometry_within_bbox('-122.25,37.25,-122.0,37.5')).to match_array([mountain_view])
    end

    it 'fails gracefully when ill-formed bounding box is provided' do
      expect { Stop.geometry_within_bbox('-122.25,37.25,-122.0') }.to raise_error(ArgumentError)
      expect { Stop.geometry_within_bbox() }.to raise_error(ArgumentError)
      expect { Stop.geometry_within_bbox([-122.25,37.25,-122.0]) }.to raise_error(ArgumentError)
    end
  end

  context '.served_by_vehicle_types' do
    before(:each) do
      @route1 = create(:route, vehicle_type: 'metro')
      @route2 = create(:route, vehicle_type: 'bus')
      @route3 = create(:route, vehicle_type: 'tram')
      @stop1 = create(:stop)
      @stop2 = create(:stop)
      @stop3 = create(:stop)
      RouteServingStop.create!(route: @route1, stop: @stop1)
      RouteServingStop.create!(route: @route2, stop: @stop2)
      RouteServingStop.create!(route: @route3, stop: @stop3)
    end

    it 'accepts a string' do
      expect(Stop.served_by_vehicle_types('metro')).to match_array([@stop1])
    end

    it 'accepts an integer' do
      expect(Stop.served_by_vehicle_types(3)).to match_array([@stop2])
    end

    it 'accepts a mix of strings and integers' do
      expect(Stop.served_by_vehicle_types(['metro', 3])).to match_array([@stop1, @stop2])
    end

    it 'fails when invalid vehicle_type' do
      expect{ Stop.served_by_vehicle_types('unicycle') }.to raise_error(KeyError)
    end
  end

  context 'served_by' do
    before(:each) do
      @bart = create(:operator, name: 'BART')
      @sfmta = create(:operator, name: 'SFMTA')
      @bart_route = create(:route, operator: @bart)
      @sfmta_route = create(:route, operator: @sfmta)
      @stop_with_both = create(:stop)
      @stop_with_sfmta = create(:stop)
      @stop_with_both.routes << [@bart_route, @sfmta_route]
      @stop_with_both.operators << [@bart, @sfmta]
      @stop_with_sfmta.routes << @sfmta_route
      @stop_with_sfmta.operators << @sfmta
    end

    it 'by operator' do
      expect(Stop.served_by([@sfmta])).to match_array([@stop_with_both, @stop_with_sfmta])
      expect(Stop.served_by([@sfmta.onestop_id])).to match_array([@stop_with_both, @stop_with_sfmta])
      expect(Stop.served_by([@bart])).to match_array([@stop_with_both])
      expect(Stop.served_by([@bart.onestop_id])).to match_array([@stop_with_both])
      expect(Stop.served_by([@sfmta.onestop_id, @bart])).to match_array([@stop_with_both, @stop_with_sfmta])
    end

    it 'by route' do
      expect(Stop.served_by([@sfmta_route])).to match_array([@stop_with_both, @stop_with_sfmta])
      expect(Stop.served_by([@sfmta_route.onestop_id])).to match_array([@stop_with_both, @stop_with_sfmta])
      expect(Stop.served_by([@bart_route])).to match_array([@stop_with_both])
      expect(Stop.served_by([@bart_route.onestop_id])).to match_array([@stop_with_both])
      expect(Stop.served_by([@sfmta_route.onestop_id, @bart_route])).to match_array([@stop_with_both, @stop_with_sfmta])
    end

    it 'by both operator and route' do
      expect(Stop.served_by([@sfmta_route.onestop_id, @bart])).to match_array([@stop_with_both, @stop_with_sfmta])
      expect(Stop.served_by([@sfmta_route, @bart.onestop_id])).to match_array([@stop_with_both, @stop_with_sfmta])
    end
  end

  context 'conflation' do
    it 'finds stops that have not been conflated since' do
      stop1 = create(:stop, last_conflated_at: 1.hours.ago)
      stop2 = create(:stop, last_conflated_at: 3.hours.ago)
      expect(Stop.last_conflated_before(2.hours.ago)).to match_array([stop2])
    end

    it '.re_conflate_with_osm' do
      stop1 = create(:stop, last_conflated_at: 3.hours.ago)
      expect {
        Stop.re_conflate_with_osm(2.hours.ago)
      }.to change(ConflateStopsWithOsmWorker.jobs, :size).by(1)
    end

    it '.conflate_with_osm' do
      #pending 'write some specs'
    end
  end

  context 'diff_against' do
    pending 'write some specs'
  end
end
