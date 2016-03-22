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
#  stop_distances                     :float            default([]), is an Array
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

FactoryGirl.define do

  factory :route_stop_pattern, class: RouteStopPattern do
    geometry { RouteStopPattern::GEOFACTORY.line_string([
      Stop::GEOFACTORY.point(-122.353165, 37.936887),
      Stop::GEOFACTORY.point(-122.38666, 37.599787)
    ])}
    stop_pattern {[Faker::OnestopId.stop, Faker::OnestopId.stop]}
    version 1
    association :route, factory: :route
    after(:build) { |rsp|
      rsp.onestop_id = OnestopId.handler_by_model(RouteStopPattern).new(
      route_onestop_id: "#{rsp.route.onestop_id}",
      stop_pattern: rsp.stop_pattern,
      geometry_coords: rsp.geometry[:coordinates]
    )}
  end

  factory :route_stop_pattern_bart, class: RouteStopPattern do
    geometry { RouteStopPattern.line_string([
      [-122.353165, 37.936887],
      [-122.38666, 37.599787]
    ])}
    stop_pattern {[
      's-9q8zzf1nks-richmond',
      's-9q8vzhbf8h-millbrae'
    ]}
    version 1
    association :route, factory: :route, onestop_id: 'r-9q8y-richmond~dalycity~millbrae', name: 'Richmond - Daly City/Millbrae'
    after(:build) { |rsp_bart|
      rsp_bart.onestop_id = OnestopId.handler_by_model(RouteStopPattern).new(
      route_onestop_id: "#{rsp_bart.route.onestop_id}",
      stop_pattern: rsp_bart.stop_pattern,
      geometry_coords: rsp_bart.geometry[:coordinates]
    )}
  end
end
