# Create a concrete class for testing
class TestOnestopId < OnestopId::OnestopIdBase
  PREFIX = :s
  MODEL = Stop
  NUM_COMPONENTS = 3
  GEOHASH_MAX_LENGTH = 5
  MAX_LENGTH = 32
end

describe OnestopId do
  it 'fails gracefully when given an invalid geometry' do
    expect {
      TestOnestopId.new('Retiro Station', '-58.374722 -34.591389')
    }.to raise_error(ArgumentError)

    expect {
      TestOnestopId.new('Retiro Station', [-58.374722,-34.591389])
    }.to raise_error(ArgumentError)
    expect {
      TestOnestopId.new(name: 'Retiro Station')
    }.to raise_error(ArgumentError)
    expect {
      TestOnestopId.new(geohash: '9q9')
    }.to raise_error(ArgumentError)
  end

  context 'max length' do
    it 'truncates beyond maximum length' do
      expect(
        TestOnestopId.new(
          geohash: '9q9',
          name: 'pneumonoultramicroscopicsilicovolcanoconiosis'
        ).to_s
      ).to eq('s-9q9-pneumonoultramicroscopicsi')
    end

    it 'truncates beyond maximum geohash length' do
      expect(
        TestOnestopId.new(
          geohash: '1234567890',
          name: 'name'
        ).to_s
      ).to eq('s-12345-name')
    end
  end

  context '#geohash' do
    it 'filters geohashes' do
      expect(
        TestOnestopId.new(geohash: 'a9q9', name: 'test').to_s
      ).to eq('s-9q9-test')
    end
  end

  context '#name' do
    it 'filters out characters: \s \b ; ? = " # % { } | \ ^ [ ] ` $ _ . + ! * \' ( ) ,' do
      expect(TestOnestopId.new(geohash: '9q9', name: 'foo bar').to_s).to eq('s-9q9-foobar')
      expect(TestOnestopId.new(geohash: '9q9', name: 'foo&bar').to_s).to eq('s-9q9-foo~bar')
      expect(TestOnestopId.new(geohash: '9q9', name: 'foo~bar').to_s).to eq('s-9q9-foo~bar')
      expect(TestOnestopId.new(geohash: '9q9', name: 'foo~bar0').to_s).to eq('s-9q9-foo~bar0')
      expect(TestOnestopId.new(geohash: '9q9', name: 'foo~bar;?="#%{}|\\^[]`$_.+!*\'(),').to_s).to eq('s-9q9-foo~bar')
      expect(TestOnestopId.new(geohash: '9q9', name: "長田").to_s).to eq('s-9q9-長田')
    end
  end

  context '#validate' do
    it 'requires valid geohash' do
      expect(TestOnestopId.new(geohash: 'a@', name: 'test').errors).to include 'invalid geohash'
    end
    it 'requires name' do
      expect(TestOnestopId.new(geohash: '9q9', name: '!').errors).to include 'invalid name'
    end
  end

  context 'RouteOnestopId' do
    it 'truncates beyond maximum length' do
      expect(
        OnestopId::RouteOnestopId.new(
          geohash: '9q9',
          name: 'pneumonoultramicroscopicsilicovolcanoconiosis'
        ).to_s
      ).to eq('r-9q9-pneumonoultramicroscopicsilicovolcanoconiosi')
    end
  end

  context 'RouteStopPatternOnestopId' do
    context 'invalid arguments' do
      it 'fails gracefully when given an invalid stop pattern' do
        expect {
          OnestopId::RouteStopPatternOnestopId.new(route_onestop_id: 'r-the~route',
                                                   geometry_coords: [[-122.0, 40.0], [-121.0, 41.0]]).to_s
        }.to raise_error(ArgumentError)
      end
      it 'fails gracefully when given an invalid geometry' do
        expect {
          OnestopId::RouteStopPatternOnestopId.new(route_onestop_id: 'r-9q9-the~route',
                                                   stop_pattern: ['s-9q9-stop~1', 's-9q9-stop~2']).to_s
        }.to raise_error(ArgumentError)
      end
      it 'fails gracefully when given an invalid route' do
        expect {
          OnestopId::RouteStopPatternOnestopId.new(stop_pattern: ['s-9q9-stop~1', 's-9q9-stop~2'],
                                                   geometry_coords: [[-122.0, 40.0], [-121.0, 41.0]]).to_s
        }.to raise_error(ArgumentError)
      end
    end

    it 'handles route onestop id' do
      onestop_id = OnestopId::RouteStopPatternOnestopId.new(
            route_onestop_id: 'r-9q9-the~route',
            stop_pattern: ['s-9q9-stop~1', 's-9q9-stop~2'],
            geometry_coords: [[-122.0, 40.0], [-121.0, 41.0]])
      expect([onestop_id.geohash, onestop_id.name]).to match_array(['9q9','the~route'])
    end

    it 'produces the first 6 hexadecimal characters of the geometry MD5 hash' do
      expect(OnestopId::RouteStopPatternOnestopId.new(
            route_onestop_id: 'r-9q9-the~route',
            stop_pattern: ['s-9q9-stop~1', 's-9q9-stop~2'],
            geometry_coords: [[-122.0, 40.0], [-121.0, 41.0]]).geometry_hash
      ).to eq('e0b430')
    end

    it 'produces the first 6 hexadecimal characters of the stop MD5 hash' do
      expect(OnestopId::RouteStopPatternOnestopId.new(
            route_onestop_id: 'r-9q9-the~route',
            stop_pattern: ['s-9q9-stop~1', 's-9q9-stop~2'],
            geometry_coords: [[-122.0, 40.0], [-121.0, 41.0]]).stop_hash
      ).to eq('b5c0d1')
    end

    it 'truncates beyond maximum length' do
      expect(
        OnestopId::RouteStopPatternOnestopId.new(
          route_onestop_id: 'r-9q9-pneumonoultramicroscopicsilicovolcanoconiosis',
          stop_pattern: ['s-9q9-stop~1', 's-9q9-stop~2'],
          geometry_coords: [[-122.0, 40.0], [-121.0, 41.0]]
        ).to_s
      ).to eq('r-9q9-pneumonoultramicroscopicsilicovolcanoconiosi-b5c0d1-e0b430')
    end

    context '#validate' do
      it 'requires valid route onestop id' do
        expect(
            OnestopId::RouteStopPatternOnestopId.new(string: 'r-9q9-the~route!-fca1a5-48fed0').errors
        ).to include 'invalid name'
      end

      it 'requires valid stop pattern hash prefix' do
        expect(
            OnestopId::RouteStopPatternOnestopId.new(string: 'r-9q9-the~route-fca1a5xx-48fed0').errors
        ).to include 'invalid stop pattern hash'
      end

      it 'requires valid geometry hash prefix' do
        expect(
            OnestopId::RouteStopPatternOnestopId.new(string: 'r-9q9-the~route-fca1a5-x48fed0x').errors
        ).to include 'invalid geometry hash'
      end
    end
  end

  context 'finder methods' do
    before(:each) do
      @glen_park = create(:stop, onestop_id: 's-9q8y-GlenPark', geometry: 'POINT(-122.433416 37.732525)', name: 'Glen Park' )
      @bosworth_diamond = create(:stop, onestop_id: 's-9q8y-BosDiam', geometry: 'POINT(-122.434011 37.733595)', name: 'Bosworth + Diamond')
      @metro_embarcadero = create(:stop, onestop_id: 's-9q8y-MetEmb', geometry: 'POINT(-122.396431 37.793152)', name: 'Metro Embarcadero')
      @gilman_paul_3rd = create(:stop, onestop_id: 's-9q8y-GilPaul3rd', geometry: 'POINT(-122.395644 37.722413)', name: 'Gilman + Paul + 3rd St.')
      @sfmta = create(:operator, onestop_id: 'o-9q8y-SFMTA', geometry: 'POINT(-122.395644 37.722413)', name: 'SFMTA')
    end

    context 'find!' do
      it 'a Stop' do
        found_bosworth_diamond = OnestopId.find!(@bosworth_diamond.onestop_id)
        expect(found_bosworth_diamond.id).to eq @bosworth_diamond.id
      end

      it 'an Operator' do
        found_sfmta = OnestopId.find!(@sfmta.onestop_id)
        expect(found_sfmta.id).to eq @sfmta.id
      end

      it 'will throw an exception when nothing found with that OnestopID' do
        expect {
          OnestopId.find!('s-b3-FakeSt')
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'find' do
      it 'returns nil when nothing found with that OnestopID' do
        expect(OnestopId.find('s-b3-FakeSt')).to be_nil
      end
    end
  end
end
