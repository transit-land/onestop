# Change Log

## [Unreleased](https://github.com/transitland/transitland-datastore/tree/HEAD)

[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.9.4...HEAD)

**Merged pull requests:**

- Production release 4.9.4 [\#738](https://github.com/transitland/transitland-datastore/pull/738) ([irees](https://github.com/irees))

## [4.9.4](https://github.com/transitland/transitland-datastore/tree/4.9.4) (2016-08-24)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.9.3...4.9.4)

**Implemented enhancements:**

- Issue controller update method fix and improvement [\#740](https://github.com/transitland/transitland-datastore/issues/740)
- Integrate memory\_profiling rake with CircleCI [\#733](https://github.com/transitland/transitland-datastore/issues/733)
- Changeset::Error errors to array [\#730](https://github.com/transitland/transitland-datastore/issues/730)
- Updating SSP distances in computed attributes [\#665](https://github.com/transitland/transitland-datastore/issues/665)

**Fixed bugs:**

- For profiling rake task some local environs failed [\#749](https://github.com/transitland/transitland-datastore/issues/749)
- Issue controller update method fix and improvement [\#740](https://github.com/transitland/transitland-datastore/issues/740)
- Updating SSP distances in computed attributes [\#665](https://github.com/transitland/transitland-datastore/issues/665)

**Closed issues:**

- specify how many feeds enqueue\_next\_feed\_versions re-imports and any feeds to skip [\#753](https://github.com/transitland/transitland-datastore/issues/753)
- Automate routine new feed version imports [\#745](https://github.com/transitland/transitland-datastore/issues/745)
- background application of changesets through API [\#634](https://github.com/transitland/transitland-datastore/issues/634)
- where\_active/where\_inactive scope for all entities [\#540](https://github.com/transitland/transitland-datastore/issues/540)

**Merged pull requests:**

- Enqueue next feed versions limit [\#754](https://github.com/transitland/transitland-datastore/pull/754) ([irees](https://github.com/irees))
- Upgrade Rails to 4.2.7.1 & update gems [\#751](https://github.com/transitland/transitland-datastore/pull/751) ([drewda](https://github.com/drewda))
- fixing OperatorInFeed bug and some comments [\#750](https://github.com/transitland/transitland-datastore/pull/750) ([doublestranded](https://github.com/doublestranded))
- Daily crontab: enqueue next feed version [\#744](https://github.com/transitland/transitland-datastore/pull/744) ([irees](https://github.com/irees))
- Issues controller update fix [\#741](https://github.com/transitland/transitland-datastore/pull/741) ([doublestranded](https://github.com/doublestranded))
- Entity: where\_imported\_from\_active\_feed\_version [\#739](https://github.com/transitland/transitland-datastore/pull/739) ([irees](https://github.com/irees))
- Circle ci profile logging [\#734](https://github.com/transitland/transitland-datastore/pull/734) ([doublestranded](https://github.com/doublestranded))
- ChangesetApplyWorker [\#732](https://github.com/transitland/transitland-datastore/pull/732) ([irees](https://github.com/irees))
- Production release 4.9.3 [\#727](https://github.com/transitland/transitland-datastore/pull/727) ([irees](https://github.com/irees))
- Ssp distance computed attribute [\#717](https://github.com/transitland/transitland-datastore/pull/717) ([doublestranded](https://github.com/doublestranded))

## [4.9.3](https://github.com/transitland/transitland-datastore/tree/4.9.3) (2016-08-15)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.9.2...4.9.3)

**Implemented enhancements:**

- Query Issues by Feed [\#724](https://github.com/transitland/transitland-datastore/issues/724)

**Fixed bugs:**

- Create Issue EntitiesWithIssues bug [\#722](https://github.com/transitland/transitland-datastore/issues/722)

**Closed issues:**

- Feed fetcher schedule fix [\#736](https://github.com/transitland/transitland-datastore/issues/736)
- GTFS: Configure temporary directory [\#718](https://github.com/transitland/transitland-datastore/issues/718)
- RSP memory use reduction part 1 [\#715](https://github.com/transitland/transitland-datastore/issues/715)
- automatically removed outdated ScheduleStopPairs after feed re-imports \(and delete any outdated SSPs currently in database\) [\#690](https://github.com/transitland/transitland-datastore/issues/690)
- in Stop, StopStation, and StopPlatform list the vehicle\_types that serve it [\#632](https://github.com/transitland/transitland-datastore/issues/632)
- Case-insensitive queries [\#578](https://github.com/transitland/transitland-datastore/issues/578)
- throw error when `vehicle\_type` value is invalid [\#474](https://github.com/transitland/transitland-datastore/issues/474)
- Profiling and benchmarking of RSP generation process \(and FeedEater\) [\#469](https://github.com/transitland/transitland-datastore/issues/469)

**Merged pull requests:**

- Feed fetcher service fix [\#737](https://github.com/transitland/transitland-datastore/pull/737) ([irees](https://github.com/irees))
- Memory profiler fix [\#731](https://github.com/transitland/transitland-datastore/pull/731) ([doublestranded](https://github.com/doublestranded))
- Baldur/memprofile work [\#729](https://github.com/transitland/transitland-datastore/pull/729) ([doublestranded](https://github.com/doublestranded))
- AllowFiltering: Case insensitive queries [\#728](https://github.com/transitland/transitland-datastore/pull/728) ([irees](https://github.com/irees))
- Fix Milan: empty stop timezone [\#726](https://github.com/transitland/transitland-datastore/pull/726) ([irees](https://github.com/irees))
- Query by feed [\#725](https://github.com/transitland/transitland-datastore/pull/725) ([doublestranded](https://github.com/doublestranded))
- ensuring distinct entities\_with\_issues created for each new issue [\#723](https://github.com/transitland/transitland-datastore/pull/723) ([doublestranded](https://github.com/doublestranded))
- Config: GTFS\_TMPDIR\_BASEPATH [\#721](https://github.com/transitland/transitland-datastore/pull/721) ([irees](https://github.com/irees))
- Rsp optimization 1 [\#720](https://github.com/transitland/transitland-datastore/pull/720) ([doublestranded](https://github.com/doublestranded))
- Production release 4.9.2 [\#716](https://github.com/transitland/transitland-datastore/pull/716) ([irees](https://github.com/irees))
- Stop: served\_by\_vehicle\_types [\#712](https://github.com/transitland/transitland-datastore/pull/712) ([irees](https://github.com/irees))

## [4.9.2](https://github.com/transitland/transitland-datastore/tree/4.9.2) (2016-07-28)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.9.1...4.9.2)

**Implemented enhancements:**

- ScheduleStopPair: when a trip has no headsign, fall back to name of last stop [\#705](https://github.com/transitland/transitland-datastore/issues/705)

**Fixed bugs:**

- Issues request returning routes on next page [\#706](https://github.com/transitland/transitland-datastore/issues/706)
- Issues not saving or appearing on dev or prod [\#688](https://github.com/transitland/transitland-datastore/issues/688)

**Merged pull requests:**

- SSP: headsign fallback [\#711](https://github.com/transitland/transitland-datastore/pull/711) ([irees](https://github.com/irees))
- Update gems [\#709](https://github.com/transitland/transitland-datastore/pull/709) ([drewda](https://github.com/drewda))
- FeedVersion activation: delete old FeedVersion SSPs [\#708](https://github.com/transitland/transitland-datastore/pull/708) ([irees](https://github.com/irees))
- fixed for next page pagination [\#707](https://github.com/transitland/transitland-datastore/pull/707) ([doublestranded](https://github.com/doublestranded))
- GTFSGraph: Skip agencies without stops [\#703](https://github.com/transitland/transitland-datastore/pull/703) ([irees](https://github.com/irees))
- production release 4.9.1 [\#699](https://github.com/transitland/transitland-datastore/pull/699) ([drewda](https://github.com/drewda))

## [4.9.1](https://github.com/transitland/transitland-datastore/tree/4.9.1) (2016-07-22)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.9.0...4.9.1)

**Implemented enhancements:**

- Coordinates in JSON are sometimes strings, not float [\#695](https://github.com/transitland/transitland-datastore/issues/695)

**Fixed bugs:**

- CircleCI failing on onestop-id-tidy branch with issue specs [\#693](https://github.com/transitland/transitland-datastore/issues/693)
- FeedEater import succeeds, but doesn't persist stops/routes/SSPs because of Exception on ChangePayload validation error [\#687](https://github.com/transitland/transitland-datastore/issues/687)
- OnestopIDs: Improve name filter [\#685](https://github.com/transitland/transitland-datastore/issues/685)

**Closed issues:**

- HashHelpers.merge\_hashes filters out nil-like values [\#686](https://github.com/transitland/transitland-datastore/issues/686)

**Merged pull requests:**

- Stop OnestopID: Filter special characters [\#702](https://github.com/transitland/transitland-datastore/pull/702) ([irees](https://github.com/irees))
- HashHelpers: dont remove empty keys [\#698](https://github.com/transitland/transitland-datastore/pull/698) ([irees](https://github.com/irees))
- Encode BigDecimal as float [\#697](https://github.com/transitland/transitland-datastore/pull/697) ([irees](https://github.com/irees))
- JSON Schema: Stop osmWayId [\#696](https://github.com/transitland/transitland-datastore/pull/696) ([irees](https://github.com/irees))
- removing duplicate entities in quality check spec [\#694](https://github.com/transitland/transitland-datastore/pull/694) ([doublestranded](https://github.com/doublestranded))
- Production release 4.9.0 [\#678](https://github.com/transitland/transitland-datastore/pull/678) ([drewda](https://github.com/drewda))

## [4.9.0](https://github.com/transitland/transitland-datastore/tree/4.9.0) (2016-07-15)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.8.8...4.9.0)

**Implemented enhancements:**

- Add feed version to Issues controller [\#664](https://github.com/transitland/transitland-datastore/issues/664)

**Fixed bugs:**

- Issue controller query param issue\_type not returning [\#681](https://github.com/transitland/transitland-datastore/issues/681)
- logstasher gem error [\#674](https://github.com/transitland/transitland-datastore/issues/674)
- Forth Worth & other feeds: Changeset::Error Couldn't find Stop [\#660](https://github.com/transitland/transitland-datastore/issues/660)

**Closed issues:**

- SSP 'where\_active' performance [\#657](https://github.com/transitland/transitland-datastore/issues/657)
- "issues" and "quality checks" [\#569](https://github.com/transitland/transitland-datastore/issues/569)

**Merged pull requests:**

- Station serializer: timezones [\#683](https://github.com/transitland/transitland-datastore/pull/683) ([irees](https://github.com/irees))
- Issue type fix [\#682](https://github.com/transitland/transitland-datastore/pull/682) ([doublestranded](https://github.com/doublestranded))
- upgrade to Rails 4.2.7 and update gems [\#680](https://github.com/transitland/transitland-datastore/pull/680) ([drewda](https://github.com/drewda))
- SSP: disable where\_active default scope [\#679](https://github.com/transitland/transitland-datastore/pull/679) ([irees](https://github.com/irees))
- rolling back to previous version of logstasher gem [\#675](https://github.com/transitland/transitland-datastore/pull/675) ([drewda](https://github.com/drewda))
- Update gems [\#673](https://github.com/transitland/transitland-datastore/pull/673) ([drewda](https://github.com/drewda))
- Issues with feed version [\#670](https://github.com/transitland/transitland-datastore/pull/670) ([doublestranded](https://github.com/doublestranded))
- Production release 4.8.8 [\#659](https://github.com/transitland/transitland-datastore/pull/659) ([irees](https://github.com/irees))
- Issues [\#599](https://github.com/transitland/transitland-datastore/pull/599) ([doublestranded](https://github.com/doublestranded))

## [4.8.8](https://github.com/transitland/transitland-datastore/tree/4.8.8) (2016-07-07)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.8.7...4.8.8)

**Implemented enhancements:**

- Updating RSP distances when related entities change with changeset [\#525](https://github.com/transitland/transitland-datastore/issues/525)

**Fixed bugs:**

- RSP not found in feeds where not all operators are imported [\#377](https://github.com/transitland/transitland-datastore/issues/377)

**Closed issues:**

- Route controller: serves stops [\#654](https://github.com/transitland/transitland-datastore/issues/654)
- Feeds controller: Filter by latest\_fetch\_exception\_log [\#651](https://github.com/transitland/transitland-datastore/issues/651)
- Station Hierarchy Import [\#257](https://github.com/transitland/transitland-datastore/issues/257)
- Station Hierarchy data model [\#256](https://github.com/transitland/transitland-datastore/issues/256)

**Merged pull requests:**

- Compatibility: Stop osm\_way\_id tag [\#663](https://github.com/transitland/transitland-datastore/pull/663) ([irees](https://github.com/irees))
- Add imported\_from\_\* params to pagination links [\#662](https://github.com/transitland/transitland-datastore/pull/662) ([irees](https://github.com/irees))
- GTFSGraph: Disable StopTransfer import [\#661](https://github.com/transitland/transitland-datastore/pull/661) ([irees](https://github.com/irees))
- EIFF: scope where\_imported\_from\_feed [\#658](https://github.com/transitland/transitland-datastore/pull/658) ([irees](https://github.com/irees))
- Stop JSON Schema fixes [\#656](https://github.com/transitland/transitland-datastore/pull/656) ([irees](https://github.com/irees))
- Computed attributes [\#655](https://github.com/transitland/transitland-datastore/pull/655) ([doublestranded](https://github.com/doublestranded))
- Route controller: serves stops [\#653](https://github.com/transitland/transitland-datastore/pull/653) ([irees](https://github.com/irees))
- Feeds controller: Filter by latest\_fetch\_exception\_log [\#652](https://github.com/transitland/transitland-datastore/pull/652) ([irees](https://github.com/irees))
- added stops\_served\_by\_route to route controller [\#650](https://github.com/transitland/transitland-datastore/pull/650) ([doublestranded](https://github.com/doublestranded))
- Fixing 1 stop, 2 stop times level 2 import bug [\#649](https://github.com/transitland/transitland-datastore/pull/649) ([doublestranded](https://github.com/doublestranded))
- SSP import: skip if missing entities [\#648](https://github.com/transitland/transitland-datastore/pull/648) ([irees](https://github.com/irees))
- Production release 4.8.7 [\#645](https://github.com/transitland/transitland-datastore/pull/645) ([irees](https://github.com/irees))
- Station hierarchy 4 [\#572](https://github.com/transitland/transitland-datastore/pull/572) ([irees](https://github.com/irees))

## [4.8.7](https://github.com/transitland/transitland-datastore/tree/4.8.7) (2016-06-23)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.8.6...4.8.7)

**Fixed bugs:**

- can't query by both tag and import level simultaneously [\#612](https://github.com/transitland/transitland-datastore/issues/612)

**Merged pull requests:**

- Fix ambiguous tags query [\#644](https://github.com/transitland/transitland-datastore/pull/644) ([irees](https://github.com/irees))
- \[WIP\] production release 4.8.6 [\#628](https://github.com/transitland/transitland-datastore/pull/628) ([drewda](https://github.com/drewda))

## [4.8.6](https://github.com/transitland/transitland-datastore/tree/4.8.6) (2016-06-21)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.8.5...4.8.6)

**Fixed bugs:**

- geometry nil value [\#636](https://github.com/transitland/transitland-datastore/issues/636)
- RSP generation should handle trips with 1 stop [\#600](https://github.com/transitland/transitland-datastore/issues/600)

**Closed issues:**

- spread feed fetching throughout the day [\#629](https://github.com/transitland/transitland-datastore/issues/629)
- remove unnecessary database indices [\#626](https://github.com/transitland/transitland-datastore/issues/626)
- stagger feed fetching [\#456](https://github.com/transitland/transitland-datastore/issues/456)

**Merged pull requests:**

- Rsp geom generation bugs fix [\#642](https://github.com/transitland/transitland-datastore/pull/642) ([doublestranded](https://github.com/doublestranded))
- only remove extraneous indexes if they exist [\#641](https://github.com/transitland/transitland-datastore/pull/641) ([drewda](https://github.com/drewda))
- update gems [\#638](https://github.com/transitland/transitland-datastore/pull/638) ([drewda](https://github.com/drewda))
- Stagger feed fetch [\#637](https://github.com/transitland/transitland-datastore/pull/637) ([drewda](https://github.com/drewda))
- Rake task: enqueue next feed version [\#630](https://github.com/transitland/transitland-datastore/pull/630) ([irees](https://github.com/irees))
- Remove unnecessary database indices [\#627](https://github.com/transitland/transitland-datastore/pull/627) ([drewda](https://github.com/drewda))
- Production deploy 4.8.5 [\#625](https://github.com/transitland/transitland-datastore/pull/625) ([irees](https://github.com/irees))

## [4.8.5](https://github.com/transitland/transitland-datastore/tree/4.8.5) (2016-06-13)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.8.4...4.8.5)

**Fixed bugs:**

- when import is in progress, activity updates show import as unsuccessful [\#606](https://github.com/transitland/transitland-datastore/issues/606)

**Closed issues:**

- Ambiguous 'tags' [\#619](https://github.com/transitland/transitland-datastore/issues/619)
- Set block\_id in SSPs [\#613](https://github.com/transitland/transitland-datastore/issues/613)
- Slow SSP pagination [\#610](https://github.com/transitland/transitland-datastore/issues/610)

**Merged pull requests:**

- activate PgHero in production [\#622](https://github.com/transitland/transitland-datastore/pull/622) ([drewda](https://github.com/drewda))
- Import trip block\_id [\#621](https://github.com/transitland/transitland-datastore/pull/621) ([irees](https://github.com/irees))
- Activity update bug [\#620](https://github.com/transitland/transitland-datastore/pull/620) ([drewda](https://github.com/drewda))
- update gems [\#618](https://github.com/transitland/transitland-datastore/pull/618) ([drewda](https://github.com/drewda))
- after\_create\_making\_history after all changes in payload [\#617](https://github.com/transitland/transitland-datastore/pull/617) ([irees](https://github.com/irees))
- logging initializer and gtfs\_graph log function [\#615](https://github.com/transitland/transitland-datastore/pull/615) ([doublestranded](https://github.com/doublestranded))
- SSP pagination performance [\#611](https://github.com/transitland/transitland-datastore/pull/611) ([irees](https://github.com/irees))
- Production release 4.8.4 [\#609](https://github.com/transitland/transitland-datastore/pull/609) ([irees](https://github.com/irees))

## [4.8.4](https://github.com/transitland/transitland-datastore/tree/4.8.4) (2016-05-27)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.8.3...4.8.4)

**Fixed bugs:**

- Sidekiq dashboard isn't allowing admins to delete enqueued jobs [\#445](https://github.com/transitland/transitland-datastore/issues/445)

**Closed issues:**

- Tyr transit costing update [\#607](https://github.com/transitland/transitland-datastore/issues/607)

**Merged pull requests:**

- Tyr costing transit [\#608](https://github.com/transitland/transitland-datastore/pull/608) ([irees](https://github.com/irees))
- fix for: Sidekiq dashboard isn't allowing admins to delete enqueued jobs [\#605](https://github.com/transitland/transitland-datastore/pull/605) ([drewda](https://github.com/drewda))
- update gems [\#604](https://github.com/transitland/transitland-datastore/pull/604) ([drewda](https://github.com/drewda))
- Production release 4.8.3 [\#603](https://github.com/transitland/transitland-datastore/pull/603) ([irees](https://github.com/irees))

## [4.8.3](https://github.com/transitland/transitland-datastore/tree/4.8.3) (2016-05-24)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.8.2...4.8.3)

**Closed issues:**

- Feed filter by active\_feed\_version import\_level [\#595](https://github.com/transitland/transitland-datastore/issues/595)
- Temporary files not being cleaned up [\#594](https://github.com/transitland/transitland-datastore/issues/594)
- allow `per\_page=false` to turn off pagination [\#592](https://github.com/transitland/transitland-datastore/issues/592)

**Merged pull requests:**

- Temporary file cleanup [\#602](https://github.com/transitland/transitland-datastore/pull/602) ([irees](https://github.com/irees))
- temporary fix to ignore trips with less than 2 unique stops [\#601](https://github.com/transitland/transitland-datastore/pull/601) ([doublestranded](https://github.com/doublestranded))
- updating gems [\#598](https://github.com/transitland/transitland-datastore/pull/598) ([drewda](https://github.com/drewda))
- allow `per\_page=false` to turn off pagination [\#597](https://github.com/transitland/transitland-datastore/pull/597) ([drewda](https://github.com/drewda))
- Feed active feed version import\_level [\#596](https://github.com/transitland/transitland-datastore/pull/596) ([irees](https://github.com/irees))
- Production release 4.8.2 [\#593](https://github.com/transitland/transitland-datastore/pull/593) ([irees](https://github.com/irees))

## [4.8.2](https://github.com/transitland/transitland-datastore/tree/4.8.2) (2016-05-11)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.8.1...4.8.2)

**Closed issues:**

- Expired Feed queries [\#591](https://github.com/transitland/transitland-datastore/issues/591)
- Operators: filter by name, short\_name [\#588](https://github.com/transitland/transitland-datastore/issues/588)
- Operator: add name and short\_name to aggregate endpoint [\#587](https://github.com/transitland/transitland-datastore/issues/587)

**Merged pull requests:**

- ChangesetError bug fix [\#590](https://github.com/transitland/transitland-datastore/pull/590) ([doublestranded](https://github.com/doublestranded))
- Operators filter name [\#589](https://github.com/transitland/transitland-datastore/pull/589) ([irees](https://github.com/irees))
- Operator aggregate: add name and short\_name [\#586](https://github.com/transitland/transitland-datastore/pull/586) ([irees](https://github.com/irees))
- Production release 4.8.1 [\#584](https://github.com/transitland/transitland-datastore/pull/584) ([irees](https://github.com/irees))
- Feed queries: valid, expired, updateable [\#581](https://github.com/transitland/transitland-datastore/pull/581) ([irees](https://github.com/irees))

## [4.8.1](https://github.com/transitland/transitland-datastore/tree/4.8.1) (2016-05-06)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.8.0...4.8.1)

**Implemented enhancements:**

- Support for non-ASCII onestop ids [\#579](https://github.com/transitland/transitland-datastore/issues/579)

**Fixed bugs:**

- RouteStopPattern creation error in `f-dpmg-rta` [\#573](https://github.com/transitland/transitland-datastore/issues/573)

**Closed issues:**

- Onestop Id exceptions [\#583](https://github.com/transitland/transitland-datastore/issues/583)
- Onestop Id Invalid Geometry Hash [\#575](https://github.com/transitland/transitland-datastore/issues/575)

**Merged pull requests:**

- Onestop ID exceptions, name fallbacks [\#582](https://github.com/transitland/transitland-datastore/pull/582) ([irees](https://github.com/irees))
- Unicode onestop ids [\#580](https://github.com/transitland/transitland-datastore/pull/580) ([doublestranded](https://github.com/doublestranded))
- Handle trips one stop time [\#577](https://github.com/transitland/transitland-datastore/pull/577) ([doublestranded](https://github.com/doublestranded))
- Onestop id name truncation [\#576](https://github.com/transitland/transitland-datastore/pull/576) ([doublestranded](https://github.com/doublestranded))
- production release 4.8 [\#574](https://github.com/transitland/transitland-datastore/pull/574) ([drewda](https://github.com/drewda))

## [4.8.0](https://github.com/transitland/transitland-datastore/tree/4.8.0) (2016-04-22)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.11...4.8.0)

**Closed issues:**

- Improve activity feed [\#564](https://github.com/transitland/transitland-datastore/issues/564)
- FeedVersion requires sha1 [\#560](https://github.com/transitland/transitland-datastore/issues/560)
- Feeds controller: last\_imported\_at [\#556](https://github.com/transitland/transitland-datastore/issues/556)
- return list of all possible country/state/metro for operators [\#549](https://github.com/transitland/transitland-datastore/issues/549)
- Timezone is not set for some stops in Transitland [\#528](https://github.com/transitland/transitland-datastore/issues/528)
- before RSP launch, clear out any duplicate or outdated RSPs [\#526](https://github.com/transitland/transitland-datastore/issues/526)
- AC Transit EIFF issues [\#492](https://github.com/transitland/transitland-datastore/issues/492)
- Datastore activity feed [\#395](https://github.com/transitland/transitland-datastore/issues/395)
- Onestop ID Foreign Key in Schedule Stop Pairs [\#318](https://github.com/transitland/transitland-datastore/issues/318)
- handle ZIP files that contain nested GTFS feeds \(and CSV files in a nested directory\) [\#316](https://github.com/transitland/transitland-datastore/issues/316)

**Merged pull requests:**

- return list of all possible country/state/metro for operators [\#568](https://github.com/transitland/transitland-datastore/pull/568) ([drewda](https://github.com/drewda))
- update gems [\#567](https://github.com/transitland/transitland-datastore/pull/567) ([drewda](https://github.com/drewda))
- Activity update improvements [\#566](https://github.com/transitland/transitland-datastore/pull/566) ([drewda](https://github.com/drewda))
- Stop timezone required [\#563](https://github.com/transitland/transitland-datastore/pull/563) ([irees](https://github.com/irees))
- Fix issue with Feed Version Controller Spec [\#559](https://github.com/transitland/transitland-datastore/pull/559) ([irees](https://github.com/irees))
- production release 4.7.11 [\#558](https://github.com/transitland/transitland-datastore/pull/558) ([drewda](https://github.com/drewda))
- Nested GTFS [\#545](https://github.com/transitland/transitland-datastore/pull/545) ([irees](https://github.com/irees))
- activity feed [\#476](https://github.com/transitland/transitland-datastore/pull/476) ([drewda](https://github.com/drewda))

## [4.7.11](https://github.com/transitland/transitland-datastore/tree/4.7.11) (2016-04-13)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.10...4.7.11)

**Merged pull requests:**

- Feed query last updated since [\#557](https://github.com/transitland/transitland-datastore/pull/557) ([irees](https://github.com/irees))
- production release 4.7.10 [\#551](https://github.com/transitland/transitland-datastore/pull/551) ([drewda](https://github.com/drewda))

## [4.7.10](https://github.com/transitland/transitland-datastore/tree/4.7.10) (2016-04-09)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.9...4.7.10)

**Fixed bugs:**

- re-import of an existing feed now fails when operator has customized Onestop ID [\#552](https://github.com/transitland/transitland-datastore/issues/552)
- README includes a link that no longer works [\#498](https://github.com/transitland/transitland-datastore/issues/498)

**Closed issues:**

- allow download of feed versions from CDN [\#404](https://github.com/transitland/transitland-datastore/issues/404)

**Merged pull requests:**

- allow download of feed versions from CDN [\#555](https://github.com/transitland/transitland-datastore/pull/555) ([drewda](https://github.com/drewda))
- move docs to website [\#554](https://github.com/transitland/transitland-datastore/pull/554) ([drewda](https://github.com/drewda))
- fix for: re-import of an existing feed now fails when operator has customized Onestop ID [\#553](https://github.com/transitland/transitland-datastore/pull/553) ([drewda](https://github.com/drewda))

## [4.7.9](https://github.com/transitland/transitland-datastore/tree/4.7.9) (2016-04-06)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.8...4.7.9)

**Closed issues:**

- Handling trips with no rsp generation [\#543](https://github.com/transitland/transitland-datastore/issues/543)
- GTFS Graph: Update entity attributes on subsequent imports of a feed/feed version [\#464](https://github.com/transitland/transitland-datastore/issues/464)
- the transitland@mapzen.com user shouldn't get notifications about changeset creation and application [\#411](https://github.com/transitland/transitland-datastore/issues/411)
- RouteStopPatterns: store shape ID in identifiers \(rather than tags\) [\#401](https://github.com/transitland/transitland-datastore/issues/401)

**Merged pull requests:**

- Shape identifiers [\#550](https://github.com/transitland/transitland-datastore/pull/550) ([doublestranded](https://github.com/doublestranded))
- update gems [\#548](https://github.com/transitland/transitland-datastore/pull/548) ([drewda](https://github.com/drewda))
- Interpolation of outlier stops [\#547](https://github.com/transitland/transitland-datastore/pull/547) ([doublestranded](https://github.com/doublestranded))
- adding stop\_distances to rsp geojson properties [\#546](https://github.com/transitland/transitland-datastore/pull/546) ([doublestranded](https://github.com/doublestranded))
- Handle trips without Route Stop Patterns [\#544](https://github.com/transitland/transitland-datastore/pull/544) ([doublestranded](https://github.com/doublestranded))
- Production release 4.7.8 [\#542](https://github.com/transitland/transitland-datastore/pull/542) ([irees](https://github.com/irees))
- Feed transition entity updates [\#536](https://github.com/transitland/transitland-datastore/pull/536) ([doublestranded](https://github.com/doublestranded))

## [4.7.8](https://github.com/transitland/transitland-datastore/tree/4.7.8) (2016-03-31)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.7...4.7.8)

**Implemented enhancements:**

- Distance Calculation 2.0 Documentation and Tweaks [\#530](https://github.com/transitland/transitland-datastore/issues/530)
- Refactor Distance Calculation [\#477](https://github.com/transitland/transitland-datastore/issues/477)

**Fixed bugs:**

- where\_import\_level should return unique results [\#537](https://github.com/transitland/transitland-datastore/issues/537)

**Closed issues:**

- rebuild operator convex hulls on production [\#516](https://github.com/transitland/transitland-datastore/issues/516)

**Merged pull requests:**

- Rsp distance caching [\#541](https://github.com/transitland/transitland-datastore/pull/541) ([doublestranded](https://github.com/doublestranded))
- Fix duplicate import\_level results [\#539](https://github.com/transitland/transitland-datastore/pull/539) ([irees](https://github.com/irees))
- Distance calc 2 refinements [\#535](https://github.com/transitland/transitland-datastore/pull/535) ([doublestranded](https://github.com/doublestranded))
- Production release 4.7.7 [\#534](https://github.com/transitland/transitland-datastore/pull/534) ([irees](https://github.com/irees))
- rake task to rebuild operator convex hulls [\#521](https://github.com/transitland/transitland-datastore/pull/521) ([drewda](https://github.com/drewda))

## [4.7.7](https://github.com/transitland/transitland-datastore/tree/4.7.7) (2016-03-24)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.6...4.7.7)

**Closed issues:**

- limit Onestop IDs to 64 characters in length [\#512](https://github.com/transitland/transitland-datastore/issues/512)

**Merged pull requests:**

- Maximum Onestop ID Length [\#533](https://github.com/transitland/transitland-datastore/pull/533) ([irees](https://github.com/irees))

## [4.7.6](https://github.com/transitland/transitland-datastore/tree/4.7.6) (2016-03-24)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.5...4.7.6)

**Fixed bugs:**

- Operator JSON schema fix: shortName [\#524](https://github.com/transitland/transitland-datastore/issues/524)
- AC Transit re-import fails [\#520](https://github.com/transitland/transitland-datastore/issues/520)

**Closed issues:**

- Import levels query parameter for operator, route, stop, rsp API endpoints [\#472](https://github.com/transitland/transitland-datastore/issues/472)
- FeedInfo: Warning for existing Feed or Operator [\#471](https://github.com/transitland/transitland-datastore/issues/471)
- an integration test that tests a new version of a feed being imported [\#400](https://github.com/transitland/transitland-datastore/issues/400)

**Merged pull requests:**

- Entity import level scope [\#529](https://github.com/transitland/transitland-datastore/pull/529) ([irees](https://github.com/irees))
- Feed import integration tests, Phase 1 [\#527](https://github.com/transitland/transitland-datastore/pull/527) ([doublestranded](https://github.com/doublestranded))
- production release 4.7.5 [\#519](https://github.com/transitland/transitland-datastore/pull/519) ([drewda](https://github.com/drewda))
- FeedInfo: Warning for existing Feed or Operator [\#470](https://github.com/transitland/transitland-datastore/pull/470) ([irees](https://github.com/irees))

## [4.7.5](https://github.com/transitland/transitland-datastore/tree/4.7.5) (2016-03-18)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.4...4.7.5)

**Implemented enhancements:**

- Distance Calculation 2.0 [\#515](https://github.com/transitland/transitland-datastore/issues/515)
- Evaluate distances separate method [\#509](https://github.com/transitland/transitland-datastore/issues/509)
- Stop adding first/last stops to route stop pattern geometry [\#490](https://github.com/transitland/transitland-datastore/issues/490)

**Fixed bugs:**

- `route\_stop\_patterns\_by\_onestop\_id` should appear for routes [\#510](https://github.com/transitland/transitland-datastore/issues/510)
- Evaluate distances separate method [\#509](https://github.com/transitland/transitland-datastore/issues/509)
- automatic fetch of newly created feeds fails [\#488](https://github.com/transitland/transitland-datastore/issues/488)

**Closed issues:**

- improve API queries for route color [\#514](https://github.com/transitland/transitland-datastore/issues/514)
- Operator.from\_gtfs convex hull [\#508](https://github.com/transitland/transitland-datastore/issues/508)
- route `operatedBy` and stop `servedBy` query params should be under\_scored, rather than camelCased [\#475](https://github.com/transitland/transitland-datastore/issues/475)
- FeedInfo "progress bar" [\#441](https://github.com/transitland/transitland-datastore/issues/441)
- Route Stop Pattern documentation [\#415](https://github.com/transitland/transitland-datastore/issues/415)

**Merged pull requests:**

- Operator schema shortName [\#523](https://github.com/transitland/transitland-datastore/pull/523) ([irees](https://github.com/irees))
- update gems [\#522](https://github.com/transitland/transitland-datastore/pull/522) ([drewda](https://github.com/drewda))
- allow users to query API for all routes that have a color defined [\#518](https://github.com/transitland/transitland-datastore/pull/518) ([drewda](https://github.com/drewda))
- Stop ordered segment matching [\#517](https://github.com/transitland/transitland-datastore/pull/517) ([doublestranded](https://github.com/doublestranded))
- try \#2 on deprecating `operatedBy` and `servedBy` [\#513](https://github.com/transitland/transitland-datastore/pull/513) ([drewda](https://github.com/drewda))
- CSV Bulk Import [\#507](https://github.com/transitland/transitland-datastore/pull/507) ([irees](https://github.com/irees))
- No added stops to rsp geom [\#506](https://github.com/transitland/transitland-datastore/pull/506) ([doublestranded](https://github.com/doublestranded))
- Eval distances [\#505](https://github.com/transitland/transitland-datastore/pull/505) ([doublestranded](https://github.com/doublestranded))
- test metadata for CircleCI [\#504](https://github.com/transitland/transitland-datastore/pull/504) ([drewda](https://github.com/drewda))
- fix for: automatic fetch of newly created feeds fails [\#503](https://github.com/transitland/transitland-datastore/pull/503) ([drewda](https://github.com/drewda))
- production release 4.7.4 [\#502](https://github.com/transitland/transitland-datastore/pull/502) ([drewda](https://github.com/drewda))
- route `operatedBy` and stop `servedBy` query params should be under\_scored, rather than camelCased [\#495](https://github.com/transitland/transitland-datastore/pull/495) ([drewda](https://github.com/drewda))

## [4.7.4](https://github.com/transitland/transitland-datastore/tree/4.7.4) (2016-03-11)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.3...4.7.4)

**Fixed bugs:**

- FeedsController\#show should throw 404 when feed not found [\#500](https://github.com/transitland/transitland-datastore/issues/500)

**Closed issues:**

- GtfsGraph refactoring [\#288](https://github.com/transitland/transitland-datastore/issues/288)

**Merged pull requests:**

- FeedsController\#show should throw 404 when feed not found [\#501](https://github.com/transitland/transitland-datastore/pull/501) ([drewda](https://github.com/drewda))
- Bump gtfs gem; fixes process leak [\#499](https://github.com/transitland/transitland-datastore/pull/499) ([irees](https://github.com/irees))
- Upgrade to Rails 4.2.6 \(and update misc. gems\) [\#496](https://github.com/transitland/transitland-datastore/pull/496) ([drewda](https://github.com/drewda))
- production release 4.7.3 [\#494](https://github.com/transitland/transitland-datastore/pull/494) ([drewda](https://github.com/drewda))
- Feed info progress bar [\#480](https://github.com/transitland/transitland-datastore/pull/480) ([irees](https://github.com/irees))
- Changeset "as\_change" [\#301](https://github.com/transitland/transitland-datastore/pull/301) ([irees](https://github.com/irees))

## [4.7.3](https://github.com/transitland/transitland-datastore/tree/4.7.3) (2016-03-09)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.2...4.7.3)

**Closed issues:**

- FeedEater: Keep change payloads [\#493](https://github.com/transitland/transitland-datastore/issues/493)
- improve GeoJSON endpoints [\#398](https://github.com/transitland/transitland-datastore/issues/398)

**Merged pull requests:**

- FeedEater: Keep change payloads [\#491](https://github.com/transitland/transitland-datastore/pull/491) ([irees](https://github.com/irees))
- improve GeoJSON endpoints [\#489](https://github.com/transitland/transitland-datastore/pull/489) ([drewda](https://github.com/drewda))
- production release 4.7.2 [\#485](https://github.com/transitland/transitland-datastore/pull/485) ([drewda](https://github.com/drewda))

## [4.7.2](https://github.com/transitland/transitland-datastore/tree/4.7.2) (2016-03-08)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.1...4.7.2)

**Implemented enhancements:**

- Route color model attribute [\#468](https://github.com/transitland/transitland-datastore/issues/468)
- Add single logging metric for determining Valhalla import use [\#466](https://github.com/transitland/transitland-datastore/issues/466)

**Closed issues:**

- Unreferenced entity cleanup [\#473](https://github.com/transitland/transitland-datastore/issues/473)
- SSP controller: Allow multiple import\_level [\#465](https://github.com/transitland/transitland-datastore/issues/465)
- Feed serializer: add active\_feed\_version\_import\_level [\#461](https://github.com/transitland/transitland-datastore/issues/461)

**Merged pull requests:**

- Entity cleanup more logging [\#486](https://github.com/transitland/transitland-datastore/pull/486) ([doublestranded](https://github.com/doublestranded))
- update gems [\#484](https://github.com/transitland/transitland-datastore/pull/484) ([drewda](https://github.com/drewda))
- Rsp single metric log [\#483](https://github.com/transitland/transitland-datastore/pull/483) ([doublestranded](https://github.com/doublestranded))
- logging for equal consecutive distances and segment mismatch case [\#482](https://github.com/transitland/transitland-datastore/pull/482) ([doublestranded](https://github.com/doublestranded))
- Unreferenced entity cleanup [\#479](https://github.com/transitland/transitland-datastore/pull/479) ([doublestranded](https://github.com/doublestranded))
- Route color [\#478](https://github.com/transitland/transitland-datastore/pull/478) ([doublestranded](https://github.com/doublestranded))
- SSP controller: allow multiple import\_level's [\#467](https://github.com/transitland/transitland-datastore/pull/467) ([irees](https://github.com/irees))
- Update gems and upgrade to Rails 4.2.5.2 [\#462](https://github.com/transitland/transitland-datastore/pull/462) ([drewda](https://github.com/drewda))
- Production release 4.7.1 [\#460](https://github.com/transitland/transitland-datastore/pull/460) ([irees](https://github.com/irees))

## [4.7.1](https://github.com/transitland/transitland-datastore/tree/4.7.1) (2016-02-27)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.7.0...4.7.1)

**Merged pull requests:**

- SSP controller: pass new query params to prev/next links [\#459](https://github.com/transitland/transitland-datastore/pull/459) ([irees](https://github.com/irees))
- production release 4.7 [\#442](https://github.com/transitland/transitland-datastore/pull/442) ([drewda](https://github.com/drewda))

## [4.7.0](https://github.com/transitland/transitland-datastore/tree/4.7.0) (2016-02-26)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.6.0...4.7.0)

**Fixed bugs:**

- distance\_from\_segment failing, causing distance calculations to fail [\#449](https://github.com/transitland/transitland-datastore/issues/449)
- Null values for SSP distances [\#447](https://github.com/transitland/transitland-datastore/issues/447)
- Fix last stop distance calc edge case [\#435](https://github.com/transitland/transitland-datastore/issues/435)
- SSP where\_active bug fix: returned all active feeds, not feed versions [\#431](https://github.com/transitland/transitland-datastore/issues/431)
- Incorrect distances saved in SSP when stop is repeated [\#418](https://github.com/transitland/transitland-datastore/issues/418)

**Closed issues:**

- Disk space leaks [\#455](https://github.com/transitland/transitland-datastore/issues/455)
- FeedVersionImports should probably list more than 1 per page [\#453](https://github.com/transitland/transitland-datastore/issues/453)
- Add sortkey/sortorder to paginated controllers [\#440](https://github.com/transitland/transitland-datastore/issues/440)
- FeedEater: Delete any existing SSPs for FeedVersion before starting [\#429](https://github.com/transitland/transitland-datastore/issues/429)
- FeedVersionImport: include import\_level [\#428](https://github.com/transitland/transitland-datastore/issues/428)
- SSP controller: where\_active default scope [\#427](https://github.com/transitland/transitland-datastore/issues/427)
- Feed activation: do not delete old SSPs [\#426](https://github.com/transitland/transitland-datastore/issues/426)
- Some problems with API endpoint [\#416](https://github.com/transitland/transitland-datastore/issues/416)
- FeedVersion import\_level should be editable [\#397](https://github.com/transitland/transitland-datastore/issues/397)
- RSP followup improvements [\#336](https://github.com/transitland/transitland-datastore/issues/336)

**Merged pull requests:**

- FeedVersionImports PER\_PAGE [\#458](https://github.com/transitland/transitland-datastore/pull/458) ([irees](https://github.com/irees))
- Distance calculation remove dup sqrt [\#457](https://github.com/transitland/transitland-datastore/pull/457) ([doublestranded](https://github.com/doublestranded))
- Add controller sorting [\#454](https://github.com/transitland/transitland-datastore/pull/454) ([meghanhade](https://github.com/meghanhade))
- logging for number of stop times with shape\_dist\_traveled if present [\#452](https://github.com/transitland/transitland-datastore/pull/452) ([doublestranded](https://github.com/doublestranded))
- Create Feed Onestop ID using GTFS feed\_id [\#451](https://github.com/transitland/transitland-datastore/pull/451) ([irees](https://github.com/irees))
- failsafe distance\_to\_segment value 0 if precision mismatch [\#450](https://github.com/transitland/transitland-datastore/pull/450) ([doublestranded](https://github.com/doublestranded))
- line points are de-duplicated after stop points are added [\#448](https://github.com/transitland/transitland-datastore/pull/448) ([doublestranded](https://github.com/doublestranded))
- API updates for Dispatcher [\#443](https://github.com/transitland/transitland-datastore/pull/443) ([drewda](https://github.com/drewda))
- import\_level improvements [\#439](https://github.com/transitland/transitland-datastore/pull/439) ([irees](https://github.com/irees))
- Improved Feed Version activation & SSP cleanup [\#438](https://github.com/transitland/transitland-datastore/pull/438) ([irees](https://github.com/irees))
- Is modified for before after stops [\#437](https://github.com/transitland/transitland-datastore/pull/437) ([doublestranded](https://github.com/doublestranded))
- Fix rsp last stop distance calc [\#436](https://github.com/transitland/transitland-datastore/pull/436) ([doublestranded](https://github.com/doublestranded))
- SSP controller default scope and new query params [\#434](https://github.com/transitland/transitland-datastore/pull/434) ([irees](https://github.com/irees))
- Repeating stops distance calc fix [\#433](https://github.com/transitland/transitland-datastore/pull/433) ([doublestranded](https://github.com/doublestranded))
- SSP\#where\_active bug fix [\#432](https://github.com/transitland/transitland-datastore/pull/432) ([irees](https://github.com/irees))
- production release 4.6.0 [\#425](https://github.com/transitland/transitland-datastore/pull/425) ([drewda](https://github.com/drewda))
- added rsp logging line in load\_tl\_route\_stop\_patterns [\#424](https://github.com/transitland/transitland-datastore/pull/424) ([doublestranded](https://github.com/doublestranded))
- update gems [\#423](https://github.com/transitland/transitland-datastore/pull/423) ([drewda](https://github.com/drewda))
- Rsp followup improvements [\#413](https://github.com/transitland/transitland-datastore/pull/413) ([doublestranded](https://github.com/doublestranded))

## [4.6.0](https://github.com/transitland/transitland-datastore/tree/4.6.0) (2016-02-18)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.5.1...4.6.0)

**Fixed bugs:**

- Convert email address to all lowercase [\#419](https://github.com/transitland/transitland-datastore/issues/419)
- FeedFetch and FeedInfo services aren't handling GTFS archives hosted on GitHub [\#407](https://github.com/transitland/transitland-datastore/issues/407)

**Closed issues:**

- create SSPs directly in FeedEaterScheduleWorker + activate a feed version by import\_level in FeedActivationWorker [\#392](https://github.com/transitland/transitland-datastore/issues/392)
- SSP Bulk Import [\#319](https://github.com/transitland/transitland-datastore/issues/319)

**Merged pull requests:**

- Convert email address to all lowercase [\#422](https://github.com/transitland/transitland-datastore/pull/422) ([drewda](https://github.com/drewda))
- Fix FeedFetch: Operator has no stops [\#421](https://github.com/transitland/transitland-datastore/pull/421) ([irees](https://github.com/irees))
- FeedFetch HTTPS [\#420](https://github.com/transitland/transitland-datastore/pull/420) ([irees](https://github.com/irees))
- Rsp documentation [\#414](https://github.com/transitland/transitland-datastore/pull/414) ([doublestranded](https://github.com/doublestranded))
- updating change log for 4.5.0 and 4.5.1 [\#412](https://github.com/transitland/transitland-datastore/pull/412) ([drewda](https://github.com/drewda))
- ScheduleStopPair Direct Import [\#277](https://github.com/transitland/transitland-datastore/pull/277) ([drewda](https://github.com/drewda))

## [4.5.1](https://github.com/transitland/transitland-datastore/tree/4.5.1) (2016-02-12)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.5.0...4.5.1)

**Fixed bugs:**

- fix RouteStopPatternController\#show [\#390](https://github.com/transitland/transitland-datastore/issues/390)

**Closed issues:**

- FeedActivationWorker [\#406](https://github.com/transitland/transitland-datastore/issues/406)
- Issue adding SEPTA GTFS file on https://transit.land/feed-registry/feeds/new [\#405](https://github.com/transitland/transitland-datastore/issues/405)
- RoutesController\#index and ScheduleStopPairController\#index should include `route\_stop\_patterns` in query [\#391](https://github.com/transitland/transitland-datastore/issues/391)
- RouteStopPatterns \(and improved route geometries\) [\#279](https://github.com/transitland/transitland-datastore/issues/279)

**Merged pull requests:**

- production release 4.5.1 [\#410](https://github.com/transitland/transitland-datastore/pull/410) ([drewda](https://github.com/drewda))
- adding more information to CONTRIBUTING.md [\#409](https://github.com/transitland/transitland-datastore/pull/409) ([drewda](https://github.com/drewda))
- update gems [\#403](https://github.com/transitland/transitland-datastore/pull/403) ([drewda](https://github.com/drewda))
- update annotations [\#402](https://github.com/transitland/transitland-datastore/pull/402) ([drewda](https://github.com/drewda))
- Feed Activation Worker [\#396](https://github.com/transitland/transitland-datastore/pull/396) ([irees](https://github.com/irees))
- Route stop pattern controller updates [\#394](https://github.com/transitland/transitland-datastore/pull/394) ([doublestranded](https://github.com/doublestranded))
- fix to RouteStopPattern show [\#393](https://github.com/transitland/transitland-datastore/pull/393) ([doublestranded](https://github.com/doublestranded))

## [4.5.0](https://github.com/transitland/transitland-datastore/tree/4.5.0) (2016-02-09)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.4.2...4.5.0)

**Fixed bugs:**

- admin reset isn't clearing out `User`s [\#386](https://github.com/transitland/transitland-datastore/issues/386)
- Rework RouteStopPattern.find\_rsp, mesh better with gtfs\_graph search/caching [\#380](https://github.com/transitland/transitland-datastore/issues/380)
- Changeset::Error PG::ProgramLimitExceeded: ERROR:  index row size 3304 exceeds maximum 2712 for index "index\_current\_route\_stop\_patterns\_on\_trips" [\#373](https://github.com/transitland/transitland-datastore/issues/373)
- Exit feed import if no agency\_id referenced operators found in feed [\#356](https://github.com/transitland/transitland-datastore/issues/356)
- Changeset::Error: PG::ProgramLimitExceeded: ERROR:  index row size 2944 exceeds maximum 2712 for index "index\_current\_route\_stop\_patterns\_on\_identifiers" [\#355](https://github.com/transitland/transitland-datastore/issues/355)
- wrong e-mail notifications are going out [\#347](https://github.com/transitland/transitland-datastore/issues/347)
- staging can't send e-mail notifications through Mandrill [\#345](https://github.com/transitland/transitland-datastore/issues/345)
- Fix Schedule Stop Pairs by Route Stop Pattern query [\#341](https://github.com/transitland/transitland-datastore/issues/341)
- Fix RSP Geometry distance calculation for stops outside [\#337](https://github.com/transitland/transitland-datastore/issues/337)
- `has\_a\_onestop\_id\_spec` sometimes fails based on `ActiveRecord::Relation` order [\#389](https://github.com/transitland/transitland-datastore/pull/389) ([drewda](https://github.com/drewda))

**Closed issues:**

- `has\_a\_onestop\_id\_spec` sometimes fails based on `ActiveRecord::Relation` order [\#388](https://github.com/transitland/transitland-datastore/issues/388)
- Missing Route geometries generated from RSPs [\#384](https://github.com/transitland/transitland-datastore/issues/384)
- Handle null gtfsAgencyId [\#374](https://github.com/transitland/transitland-datastore/issues/374)
- Don't delete ChangePayloads by default [\#370](https://github.com/transitland/transitland-datastore/issues/370)
- increase FeedInfo cache expiration \(and make it configurable by env variables\) [\#367](https://github.com/transitland/transitland-datastore/issues/367)
- Caltrain agency\_id [\#364](https://github.com/transitland/transitland-datastore/issues/364)
- Remove duplicate RSP trips [\#361](https://github.com/transitland/transitland-datastore/issues/361)
- Partial Station Hierarchy [\#360](https://github.com/transitland/transitland-datastore/issues/360)
- FeedInfo return remote request response code if exception [\#358](https://github.com/transitland/transitland-datastore/issues/358)
- when a new `Feed` has been created, automatically enqueue its first fetch [\#353](https://github.com/transitland/transitland-datastore/issues/353)
- validate that `User.email` is actually an e-mail address [\#349](https://github.com/transitland/transitland-datastore/issues/349)
- RSPs should only be created from trips actually used by routes associated with found operators [\#344](https://github.com/transitland/transitland-datastore/issues/344)
- Correctly fall back on missing shapes.txt [\#339](https://github.com/transitland/transitland-datastore/issues/339)
- Changeset Entity Imported From Feed [\#338](https://github.com/transitland/transitland-datastore/issues/338)
- Send an email when feed is imported and ready to go \(or fails\) [\#326](https://github.com/transitland/transitland-datastore/issues/326)
- Send an email when a user submits a feed [\#325](https://github.com/transitland/transitland-datastore/issues/325)
- enqueue a feed fetch after changeset application creates a new feed model [\#320](https://github.com/transitland/transitland-datastore/issues/320)
- handle GTFS feeds with `calendar\_dates.txt` but no `calendars.txt` [\#308](https://github.com/transitland/transitland-datastore/issues/308)
- send confirmation e-mail to User after they submit a changeset and after changeset is applied [\#281](https://github.com/transitland/transitland-datastore/issues/281)
- add User data model and associate with Changesets [\#258](https://github.com/transitland/transitland-datastore/issues/258)
- add Relation and RelationMember [\#17](https://github.com/transitland/transitland-datastore/issues/17)

**Merged pull requests:**

- admin reset isn't clearing out `User`s [\#387](https://github.com/transitland/transitland-datastore/pull/387) ([drewda](https://github.com/drewda))
- Fix Route geometry generated from RSPs [\#385](https://github.com/transitland/transitland-datastore/pull/385) ([irees](https://github.com/irees))
- update error messages [\#383](https://github.com/transitland/transitland-datastore/pull/383) ([meghanhade](https://github.com/meghanhade))
- Updated route stop pattern distances [\#382](https://github.com/transitland/transitland-datastore/pull/382) ([doublestranded](https://github.com/doublestranded))
- Find rsp refactor [\#381](https://github.com/transitland/transitland-datastore/pull/381) ([doublestranded](https://github.com/doublestranded))
- Preserve ChangePayloads by default [\#379](https://github.com/transitland/transitland-datastore/pull/379) ([irees](https://github.com/irees))
- Fix case where Feed.operators\_in\_feed gtfs\_agency\_id is nil [\#378](https://github.com/transitland/transitland-datastore/pull/378) ([irees](https://github.com/irees))
- Fetch and create FeedVersion when a new Feed is created [\#376](https://github.com/transitland/transitland-datastore/pull/376) ([irees](https://github.com/irees))
- Switch index type rsp trips [\#375](https://github.com/transitland/transitland-datastore/pull/375) ([doublestranded](https://github.com/doublestranded))
- production release 4.5 [\#372](https://github.com/transitland/transitland-datastore/pull/372) ([drewda](https://github.com/drewda))
- improve changeset notes [\#371](https://github.com/transitland/transitland-datastore/pull/371) ([drewda](https://github.com/drewda))
- Partial Station Hierarchy [\#369](https://github.com/transitland/transitland-datastore/pull/369) ([irees](https://github.com/irees))
- Increase FeedInfo cache expiration time and read from config [\#368](https://github.com/transitland/transitland-datastore/pull/368) ([irees](https://github.com/irees))
- Fix\#355 [\#366](https://github.com/transitland/transitland-datastore/pull/366) ([doublestranded](https://github.com/doublestranded))
- Update Caltrain sample feed gtfsAgencyId to 'CT' [\#365](https://github.com/transitland/transitland-datastore/pull/365) ([irees](https://github.com/irees))
- Remove duplicate RSP trips [\#363](https://github.com/transitland/transitland-datastore/pull/363) ([doublestranded](https://github.com/doublestranded))
- Failed FeedInfo should return request http response code in error [\#359](https://github.com/transitland/transitland-datastore/pull/359) ([irees](https://github.com/irees))
- Fix missing operator in feed [\#357](https://github.com/transitland/transitland-datastore/pull/357) ([irees](https://github.com/irees))
- Handle EntitiesImportedFromFeed relations in Changeset apply [\#354](https://github.com/transitland/transitland-datastore/pull/354) ([irees](https://github.com/irees))
- validate that `User.email` is actually an e-mail address [\#350](https://github.com/transitland/transitland-datastore/pull/350) ([drewda](https://github.com/drewda))
- putting the right e-mail notifications in the right places [\#348](https://github.com/transitland/transitland-datastore/pull/348) ([drewda](https://github.com/drewda))
- fixing SMTP/Mandrill configuration [\#346](https://github.com/transitland/transitland-datastore/pull/346) ([drewda](https://github.com/drewda))
- user controller now allows editing of all fields [\#343](https://github.com/transitland/transitland-datastore/pull/343) ([drewda](https://github.com/drewda))
- closes \#341 [\#342](https://github.com/transitland/transitland-datastore/pull/342) ([doublestranded](https://github.com/doublestranded))
- Update gtfs gem & resolve shape/calendar issues [\#340](https://github.com/transitland/transitland-datastore/pull/340) ([irees](https://github.com/irees))
- production release 4.4.2 [\#334](https://github.com/transitland/transitland-datastore/pull/334) ([drewda](https://github.com/drewda))
- add User model, associate with Changesets, set up e-mail notifications [\#304](https://github.com/transitland/transitland-datastore/pull/304) ([drewda](https://github.com/drewda))
- Route stop pattern [\#249](https://github.com/transitland/transitland-datastore/pull/249) ([doublestranded](https://github.com/doublestranded))

## [4.4.2](https://github.com/transitland/transitland-datastore/tree/4.4.2) (2016-01-26)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.4.1...4.4.2)

**Fixed bugs:**

- FeedFetcher \(or FeedInfo?\) worker may still be leaving behind temp files [\#311](https://github.com/transitland/transitland-datastore/issues/311)
- operator re-imported from multiple feed versions lists duplicate imported\_from\_feed\_onestop\_ids [\#302](https://github.com/transitland/transitland-datastore/issues/302)

**Closed issues:**

- SSP API: Raise error if missing Stop/Operator/Route [\#330](https://github.com/transitland/transitland-datastore/issues/330)
- Fix SSP controller operator\_onestop\_id [\#327](https://github.com/transitland/transitland-datastore/issues/327)
- if FeedFetcher has an exception, log the error [\#321](https://github.com/transitland/transitland-datastore/issues/321)
- FeedInfo better error messages for bad GTFS feeds [\#317](https://github.com/transitland/transitland-datastore/issues/317)
- ScheduleStopPair `service\_to\_date` scope + query parameter [\#309](https://github.com/transitland/transitland-datastore/issues/309)
- add changelog [\#299](https://github.com/transitland/transitland-datastore/issues/299)
- test Rubocop and HoundCI for style checking [\#297](https://github.com/transitland/transitland-datastore/issues/297)
- refactor Onestop ID class [\#287](https://github.com/transitland/transitland-datastore/issues/287)
- remove Changeset append API endpoint [\#271](https://github.com/transitland/transitland-datastore/issues/271)

**Merged pull requests:**

- Rails 4.2.5.1 and misc. gem updates [\#335](https://github.com/transitland/transitland-datastore/pull/335) ([drewda](https://github.com/drewda))
- SSP where\_service\_before\_date [\#333](https://github.com/transitland/transitland-datastore/pull/333) ([irees](https://github.com/irees))
- Add find\_by\_onestop\_ids, find\_by\_onestop\_ids! methods [\#331](https://github.com/transitland/transitland-datastore/pull/331) ([irees](https://github.com/irees))
- turning FeedInfo service's download methods into a new FeedFetch service [\#329](https://github.com/transitland/transitland-datastore/pull/329) ([drewda](https://github.com/drewda))
- Fix SSP controller operator\_onestop\_id [\#328](https://github.com/transitland/transitland-datastore/pull/328) ([irees](https://github.com/irees))
- Remove changeset append [\#324](https://github.com/transitland/transitland-datastore/pull/324) ([irees](https://github.com/irees))
- Improve feed info error handling [\#323](https://github.com/transitland/transitland-datastore/pull/323) ([irees](https://github.com/irees))
- if FeedFetcher has an exception, log the error [\#322](https://github.com/transitland/transitland-datastore/pull/322) ([drewda](https://github.com/drewda))
- Changeset/ChangePayload deletes [\#315](https://github.com/transitland/transitland-datastore/pull/315) ([drewda](https://github.com/drewda))
- allow user to fetch the latest version of one feed [\#314](https://github.com/transitland/transitland-datastore/pull/314) ([drewda](https://github.com/drewda))
- Gem updates [\#313](https://github.com/transitland/transitland-datastore/pull/313) ([drewda](https://github.com/drewda))
- trying agin to fix custom HoundCI config [\#307](https://github.com/transitland/transitland-datastore/pull/307) ([drewda](https://github.com/drewda))
- fix custom HoundCI config [\#306](https://github.com/transitland/transitland-datastore/pull/306) ([drewda](https://github.com/drewda))
- Major refactoring of OnestopId: [\#305](https://github.com/transitland/transitland-datastore/pull/305) ([doublestranded](https://github.com/doublestranded))
- fix for: operator re-imported from multiple feed versions lists duplicate `imported\_from\_feed\_onestop\_ids` [\#303](https://github.com/transitland/transitland-datastore/pull/303) ([drewda](https://github.com/drewda))
- adding CHANGELOG [\#300](https://github.com/transitland/transitland-datastore/pull/300) ([drewda](https://github.com/drewda))
- Rubocop and HoundCI style checking [\#298](https://github.com/transitland/transitland-datastore/pull/298) ([drewda](https://github.com/drewda))

## [4.4.1](https://github.com/transitland/transitland-datastore/tree/4.4.1) (2016-01-07)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.4.0...4.4.1)

**Fixed bugs:**

- Sidekiq process failing when some FeedEaterScheduleWorker jobs consume too much memory [\#291](https://github.com/transitland/transitland-datastore/issues/291)

**Merged pull requests:**

- updating ActiveModelSerializers [\#296](https://github.com/transitland/transitland-datastore/pull/296) ([drewda](https://github.com/drewda))
- reduce staging log level [\#295](https://github.com/transitland/transitland-datastore/pull/295) ([drewda](https://github.com/drewda))
- production release 4.4.1 [\#294](https://github.com/transitland/transitland-datastore/pull/294) ([drewda](https://github.com/drewda))
- update gems [\#293](https://github.com/transitland/transitland-datastore/pull/293) ([drewda](https://github.com/drewda))
- improve Sidekiq background job stability [\#292](https://github.com/transitland/transitland-datastore/pull/292) ([drewda](https://github.com/drewda))
- update gems [\#289](https://github.com/transitland/transitland-datastore/pull/289) ([drewda](https://github.com/drewda))
- update misc. gems [\#270](https://github.com/transitland/transitland-datastore/pull/270) ([drewda](https://github.com/drewda))

## [4.4.0](https://github.com/transitland/transitland-datastore/tree/4.4.0) (2015-12-23)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.3.2...4.4.0)

**Fixed bugs:**

- FeedVersion attachment temp files are lingering on worker servers [\#264](https://github.com/transitland/transitland-datastore/issues/264)

**Closed issues:**

- add vehicle\_type index to Route tables [\#268](https://github.com/transitland/transitland-datastore/issues/268)
- store vehicle type as integer on Route model [\#266](https://github.com/transitland/transitland-datastore/issues/266)
- allow SSP queries by multiple Onestop IDs [\#262](https://github.com/transitland/transitland-datastore/issues/262)
- format logs for Logstash/Kibana [\#254](https://github.com/transitland/transitland-datastore/issues/254)
- Add location\_type to API [\#246](https://github.com/transitland/transitland-datastore/issues/246)

**Merged pull requests:**

- add vehicle\_type index to Route tables [\#269](https://github.com/transitland/transitland-datastore/pull/269) ([drewda](https://github.com/drewda))
- store vehicle type as integer attribute on Route model [\#267](https://github.com/transitland/transitland-datastore/pull/267) ([drewda](https://github.com/drewda))
- fix for: FeedVersion attachment temp files are lingering on worker servers [\#265](https://github.com/transitland/transitland-datastore/pull/265) ([drewda](https://github.com/drewda))
- SSP API endpoint allows queries by multiple Onestop IDs [\#263](https://github.com/transitland/transitland-datastore/pull/263) ([drewda](https://github.com/drewda))
- production release 4.4.0 [\#261](https://github.com/transitland/transitland-datastore/pull/261) ([drewda](https://github.com/drewda))
- Use OJ for JSON serialization [\#259](https://github.com/transitland/transitland-datastore/pull/259) ([drewda](https://github.com/drewda))
- Logstash logs [\#255](https://github.com/transitland/transitland-datastore/pull/255) ([drewda](https://github.com/drewda))
- New route types [\#253](https://github.com/transitland/transitland-datastore/pull/253) ([doublestranded](https://github.com/doublestranded))

## [4.3.2](https://github.com/transitland/transitland-datastore/tree/4.3.2) (2015-12-18)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.3.1...4.3.2)

**Merged pull requests:**

- updating gems [\#252](https://github.com/transitland/transitland-datastore/pull/252) ([drewda](https://github.com/drewda))
- production release 4.3.2 [\#251](https://github.com/transitland/transitland-datastore/pull/251) ([drewda](https://github.com/drewda))
- reducing Sidekiq concurrency on prod [\#250](https://github.com/transitland/transitland-datastore/pull/250) ([drewda](https://github.com/drewda))
- adds very basic dockerfile [\#248](https://github.com/transitland/transitland-datastore/pull/248) ([baldur](https://github.com/baldur))
- upgrade rgeo and rgeo-geojson [\#247](https://github.com/transitland/transitland-datastore/pull/247) ([drewda](https://github.com/drewda))
- FeedInfo response 500 on errors [\#245](https://github.com/transitland/transitland-datastore/pull/245) ([irees](https://github.com/irees))
- Remove unnecessary Tempfile.new 'wb' flag. [\#244](https://github.com/transitland/transitland-datastore/pull/244) ([irees](https://github.com/irees))
- Change payload edit [\#243](https://github.com/transitland/transitland-datastore/pull/243) ([irees](https://github.com/irees))
- Feed fetch info [\#242](https://github.com/transitland/transitland-datastore/pull/242) ([irees](https://github.com/irees))

## [4.3.1](https://github.com/transitland/transitland-datastore/tree/4.3.1) (2015-12-02)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.3.0...4.3.1)

**Merged pull requests:**

- production release 4.3.1 [\#241](https://github.com/transitland/transitland-datastore/pull/241) ([drewda](https://github.com/drewda))
- only include pagination total if `?total=true` [\#240](https://github.com/transitland/transitland-datastore/pull/240) ([drewda](https://github.com/drewda))
- Bump gtfs rc7 [\#239](https://github.com/transitland/transitland-datastore/pull/239) ([irees](https://github.com/irees))
- Admin additions: PgHero for database analysis and styling improvements [\#238](https://github.com/transitland/transitland-datastore/pull/238) ([drewda](https://github.com/drewda))
- remove outdated references to old Feed Registry [\#237](https://github.com/transitland/transitland-datastore/pull/237) ([drewda](https://github.com/drewda))
- Remove partially-enforced Change Payload uniqueness constraint [\#236](https://github.com/transitland/transitland-datastore/pull/236) ([irees](https://github.com/irees))
- Pagination refactor [\#235](https://github.com/transitland/transitland-datastore/pull/235) ([irees](https://github.com/irees))
- dependency updates \(including Rails 4.2.5 and Sidekiq 4.0\) [\#234](https://github.com/transitland/transitland-datastore/pull/234) ([drewda](https://github.com/drewda))
- Stop conflation logger [\#233](https://github.com/transitland/transitland-datastore/pull/233) ([doublestranded](https://github.com/doublestranded))
- Updated to match blog post [\#232](https://github.com/transitland/transitland-datastore/pull/232) ([irees](https://github.com/irees))
- Routes by stops bounding box [\#231](https://github.com/transitland/transitland-datastore/pull/231) ([doublestranded](https://github.com/doublestranded))
- upgrade to Ruby 2.2.3 [\#187](https://github.com/transitland/transitland-datastore/pull/187) ([drewda](https://github.com/drewda))

## [4.3.0](https://github.com/transitland/transitland-datastore/tree/4.3.0) (2015-11-12)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.2.0...4.3.0)

**Merged pull requests:**

- production release 4.3.0 [\#230](https://github.com/transitland/transitland-datastore/pull/230) ([drewda](https://github.com/drewda))
- trying to fix crontab again [\#229](https://github.com/transitland/transitland-datastore/pull/229) ([drewda](https://github.com/drewda))
- SSP documentation updates [\#228](https://github.com/transitland/transitland-datastore/pull/228) ([irees](https://github.com/irees))
- Activate/deactive SSPs [\#226](https://github.com/transitland/transitland-datastore/pull/226) ([irees](https://github.com/irees))
- reduce Sidekiq concurrency on dev stack [\#225](https://github.com/transitland/transitland-datastore/pull/225) ([drewda](https://github.com/drewda))
- add indices on geometry columns [\#224](https://github.com/transitland/transitland-datastore/pull/224) ([drewda](https://github.com/drewda))
- fixing crontab on servers [\#223](https://github.com/transitland/transitland-datastore/pull/223) ([drewda](https://github.com/drewda))
- Auto conflating stops [\#222](https://github.com/transitland/transitland-datastore/pull/222) ([doublestranded](https://github.com/doublestranded))
- Fix BART initial convex hull [\#219](https://github.com/transitland/transitland-datastore/pull/219) ([irees](https://github.com/irees))
- Improve SSP performance by caching entity lookups [\#218](https://github.com/transitland/transitland-datastore/pull/218) ([irees](https://github.com/irees))
- Making tmp directory if not exists [\#217](https://github.com/transitland/transitland-datastore/pull/217) ([doublestranded](https://github.com/doublestranded))
- Update to sidekiq-unique-job broke unique: true [\#216](https://github.com/transitland/transitland-datastore/pull/216) ([irees](https://github.com/irees))

## [4.2.0](https://github.com/transitland/transitland-datastore/tree/4.2.0) (2015-11-04)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.1.1...4.2.0)

**Closed issues:**

- meta\["next"\] does echo all initial parameters [\#205](https://github.com/transitland/transitland-datastore/issues/205)

**Merged pull requests:**

- production release 4.2.0 [\#215](https://github.com/transitland/transitland-datastore/pull/215) ([drewda](https://github.com/drewda))
- Assorted code clean-up and maintenance [\#214](https://github.com/transitland/transitland-datastore/pull/214) ([drewda](https://github.com/drewda))
- Include origin\_departure\_between, operator\_onestop\_id, and trip in SSP pagination [\#213](https://github.com/transitland/transitland-datastore/pull/213) ([irees](https://github.com/irees))
- display most recent FeedVersionImport first [\#212](https://github.com/transitland/transitland-datastore/pull/212) ([drewda](https://github.com/drewda))
- Log ChangePayload failures and payloads [\#211](https://github.com/transitland/transitland-datastore/pull/211) ([irees](https://github.com/irees))
- add attribution text to Feed data model [\#210](https://github.com/transitland/transitland-datastore/pull/210) ([meghanhade](https://github.com/meghanhade))
- SSP accessibility labels [\#209](https://github.com/transitland/transitland-datastore/pull/209) ([irees](https://github.com/irees))
- Update ACTransit GTFS url [\#208](https://github.com/transitland/transitland-datastore/pull/208) ([irees](https://github.com/irees))
- Fallback order before pagination [\#207](https://github.com/transitland/transitland-datastore/pull/207) ([irees](https://github.com/irees))
- Bump GTFS lib to fix issue with VTA \(bad service\_days\_of\_week\) [\#206](https://github.com/transitland/transitland-datastore/pull/206) ([irees](https://github.com/irees))
- ScheduleStopPair controller origin\_departure\_between [\#204](https://github.com/transitland/transitland-datastore/pull/204) ([irees](https://github.com/irees))
- remove n+1 queries found using bullet gem [\#203](https://github.com/transitland/transitland-datastore/pull/203) ([drewda](https://github.com/drewda))
- Fix routes serving stops [\#202](https://github.com/transitland/transitland-datastore/pull/202) ([irees](https://github.com/irees))
- SSP JSON Schema fixes [\#201](https://github.com/transitland/transitland-datastore/pull/201) ([irees](https://github.com/irees))
- one FeedEaterScheduleWorker per Sidekiq process [\#200](https://github.com/transitland/transitland-datastore/pull/200) ([drewda](https://github.com/drewda))
- Don't add Operators to SSPs during migration [\#199](https://github.com/transitland/transitland-datastore/pull/199) ([irees](https://github.com/irees))
- JSON Schema for SSPs [\#198](https://github.com/transitland/transitland-datastore/pull/198) ([irees](https://github.com/irees))
- ScheduleStopPair add Operator and additional controller search parameters [\#196](https://github.com/transitland/transitland-datastore/pull/196) ([irees](https://github.com/irees))
- production release 4.1.1 [\#195](https://github.com/transitland/transitland-datastore/pull/195) ([drewda](https://github.com/drewda))
- Feedeater parallel schedule import [\#194](https://github.com/transitland/transitland-datastore/pull/194) ([irees](https://github.com/irees))
- Feed versions [\#141](https://github.com/transitland/transitland-datastore/pull/141) ([drewda](https://github.com/drewda))

## [4.1.1](https://github.com/transitland/transitland-datastore/tree/4.1.1) (2015-10-07)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.1.0...4.1.1)

**Merged pull requests:**

- updating temporary feed info [\#193](https://github.com/transitland/transitland-datastore/pull/193) ([drewda](https://github.com/drewda))
- cosmetic updates for locate service changes [\#191](https://github.com/transitland/transitland-datastore/pull/191) ([kevinkreiser](https://github.com/kevinkreiser))

## [4.1.0](https://github.com/transitland/transitland-datastore/tree/4.1.0) (2015-10-02)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.1.0.rc1...4.1.0)

**Merged pull requests:**

- Feed update bbox [\#192](https://github.com/transitland/transitland-datastore/pull/192) ([irees](https://github.com/irees))
- route changeset callbacks conflicting [\#190](https://github.com/transitland/transitland-datastore/pull/190) ([drewda](https://github.com/drewda))

## [4.1.0.rc1](https://github.com/transitland/transitland-datastore/tree/4.1.0.rc1) (2015-10-01)
[Full Changelog](https://github.com/transitland/transitland-datastore/compare/4.0.0...4.1.0.rc1)

**Closed issues:**

- API gives same results for different queries [\#164](https://github.com/transitland/transitland-datastore/issues/164)

**Merged pull requests:**

- upgrade Celluloid dependency [\#189](https://github.com/transitland/transitland-datastore/pull/189) ([drewda](https://github.com/drewda))
- Schedule stop pair interpolation [\#188](https://github.com/transitland/transitland-datastore/pull/188) ([irees](https://github.com/irees))
- DatastoreAdmin clears out OperatorInFeed tables [\#186](https://github.com/transitland/transitland-datastore/pull/186) ([drewda](https://github.com/drewda))
- Fix missing route shapes [\#185](https://github.com/transitland/transitland-datastore/pull/185) ([irees](https://github.com/irees))
- feed bounding box [\#184](https://github.com/transitland/transitland-datastore/pull/184) ([drewda](https://github.com/drewda))
- only one FeedEaterFeedWorker at a time [\#183](https://github.com/transitland/transitland-datastore/pull/183) ([drewda](https://github.com/drewda))
- conflate up to 100 stops in each Tyr request [\#182](https://github.com/transitland/transitland-datastore/pull/182) ([drewda](https://github.com/drewda))
- Rails 4.2.4 and gem upgrades [\#181](https://github.com/transitland/transitland-datastore/pull/181) ([drewda](https://github.com/drewda))
- Fix admin reset [\#180](https://github.com/transitland/transitland-datastore/pull/180) ([drewda](https://github.com/drewda))
- Refactor GTFS [\#179](https://github.com/transitland/transitland-datastore/pull/179) ([irees](https://github.com/irees))
- upgrade Google transitfeed validator [\#178](https://github.com/transitland/transitland-datastore/pull/178) ([drewda](https://github.com/drewda))
- Ruby-based FeedEater pipeline \(v4.0.0\) to production [\#177](https://github.com/transitland/transitland-datastore/pull/177) ([drewda](https://github.com/drewda))
- move Feed Registry from GitHub into Datastore [\#168](https://github.com/transitland/transitland-datastore/pull/168) ([drewda](https://github.com/drewda))

## [4.0.0](https://github.com/transitland/transitland-datastore/tree/4.0.0) (2015-09-21)
**Closed issues:**

- Invalid gemspec [\#128](https://github.com/transitland/transitland-datastore/issues/128)
- searching by OnestopID should be case insensitive [\#23](https://github.com/transitland/transitland-datastore/issues/23)
- apply/revert Changeset's [\#21](https://github.com/transitland/transitland-datastore/issues/21)
- have Rails seeds automatically import the two included GTFS feeds \(SFMTA and VTA\) [\#18](https://github.com/transitland/transitland-datastore/issues/18)
- add Operator and OperatorServingStop [\#16](https://github.com/transitland/transitland-datastore/issues/16)
- when importing from GTFS zips, create StopIdentifier's [\#15](https://github.com/transitland/transitland-datastore/issues/15)
- basic Changeset data model [\#13](https://github.com/transitland/transitland-datastore/issues/13)
- automatically generate and assign Onestop IDs [\#11](https://github.com/transitland/transitland-datastore/issues/11)
- serve stops as GeoJSON \(for slippy map consumption\) [\#10](https://github.com/transitland/transitland-datastore/issues/10)
- deploying: precompile assets [\#6](https://github.com/transitland/transitland-datastore/issues/6)
- deploying: run migrations [\#5](https://github.com/transitland/transitland-datastore/issues/5)
- import stops from GTFS zip [\#4](https://github.com/transitland/transitland-datastore/issues/4)

**Merged pull requests:**

- Feedeater integration tests [\#176](https://github.com/transitland/transitland-datastore/pull/176) ([irees](https://github.com/irees))
- "identifier" is misspelled in some places [\#175](https://github.com/transitland/transitland-datastore/pull/175) ([drewda](https://github.com/drewda))
- fix for: message on Changeset::Error hasn't been getting logged by FeedEater [\#174](https://github.com/transitland/transitland-datastore/pull/174) ([drewda](https://github.com/drewda))
- GTFS wrapper fix for PANYNJ PATH [\#173](https://github.com/transitland/transitland-datastore/pull/173) ([irees](https://github.com/irees))
- Correctly attach import\_log during exceptions [\#172](https://github.com/transitland/transitland-datastore/pull/172) ([irees](https://github.com/irees))
- FeedEater: add website to Operator [\#171](https://github.com/transitland/transitland-datastore/pull/171) ([irees](https://github.com/irees))
- Include timezones in Operator and Stop changesets. [\#170](https://github.com/transitland/transitland-datastore/pull/170) ([irees](https://github.com/irees))
- Feedimport add exception log [\#169](https://github.com/transitland/transitland-datastore/pull/169) ([irees](https://github.com/irees))
- Correctly calculate min/max service range from service\_added\_dates/service\_except\_dates [\#167](https://github.com/transitland/transitland-datastore/pull/167) ([irees](https://github.com/irees))
- limit Sidekiq to 10 concurrent jobs on staging and prod [\#166](https://github.com/transitland/transitland-datastore/pull/166) ([drewda](https://github.com/drewda))
- FeedEater remove python & improved FeedEater logging [\#165](https://github.com/transitland/transitland-datastore/pull/165) ([irees](https://github.com/irees))
- Feedeater filter service exceptions [\#163](https://github.com/transitland/transitland-datastore/pull/163) ([irees](https://github.com/irees))
- Use Addressable::Template to properly URL encode GTFS ID's [\#162](https://github.com/transitland/transitland-datastore/pull/162) ([irees](https://github.com/irees))
- Duplicate entity feeds [\#161](https://github.com/transitland/transitland-datastore/pull/161) ([irees](https://github.com/irees))
- FeedEater performance and bug fixes [\#160](https://github.com/transitland/transitland-datastore/pull/160) ([irees](https://github.com/irees))
- Feedeater fix schedule start date unset [\#159](https://github.com/transitland/transitland-datastore/pull/159) ([irees](https://github.com/irees))
- fix for: bbox query for stops returning errant results [\#158](https://github.com/transitland/transitland-datastore/pull/158) ([drewda](https://github.com/drewda))
- Add pry-rescue dependency [\#157](https://github.com/transitland/transitland-datastore/pull/157) ([irees](https://github.com/irees))
- Handle references to non-existent parent\_station [\#156](https://github.com/transitland/transitland-datastore/pull/156) ([irees](https://github.com/irees))
- Fix bug in GeohashHelpers.adjacent [\#155](https://github.com/transitland/transitland-datastore/pull/155) ([irees](https://github.com/irees))
- More carefully check and convert start\_date [\#154](https://github.com/transitland/transitland-datastore/pull/154) ([irees](https://github.com/irees))
- copy in license info from Feed Registry [\#153](https://github.com/transitland/transitland-datastore/pull/153) ([drewda](https://github.com/drewda))
- Onestop ID Creation [\#152](https://github.com/transitland/transitland-datastore/pull/152) ([irees](https://github.com/irees))
- entities can be from multiple feeds [\#151](https://github.com/transitland/transitland-datastore/pull/151) ([drewda](https://github.com/drewda))
- Truncate schedule\_stop\_pairs [\#150](https://github.com/transitland/transitland-datastore/pull/150) ([irees](https://github.com/irees))
- FeedEater Improvements for NYC MTA Convex Hull, MTA subway empty routes, VTA calendar dates, import levels [\#149](https://github.com/transitland/transitland-datastore/pull/149) ([irees](https://github.com/irees))
- fixing a temporary Gemfile issue [\#148](https://github.com/transitland/transitland-datastore/pull/148) ([drewda](https://github.com/drewda))
- Bug fix to trip\_chunks. Skip empty routes. [\#147](https://github.com/transitland/transitland-datastore/pull/147) ([irees](https://github.com/irees))
- associate entities \(Operator, Route, Stop\) and ScheduleStopPairs with Feed [\#146](https://github.com/transitland/transitland-datastore/pull/146) ([drewda](https://github.com/drewda))
- Feedeater ruby [\#145](https://github.com/transitland/transitland-datastore/pull/145) ([irees](https://github.com/irees))
- Datastore needs to read and store full operatorsInFeed array of hashes from Feed Registry [\#144](https://github.com/transitland/transitland-datastore/pull/144) ([drewda](https://github.com/drewda))
- upgrade rgeo dependency & provide convex hull class method [\#142](https://github.com/transitland/transitland-datastore/pull/142) ([drewda](https://github.com/drewda))
- Geohash Helper, ported from mapzen-geohash [\#139](https://github.com/transitland/transitland-datastore/pull/139) ([irees](https://github.com/irees))
- ScheduleStopPair endpoint should include all query params in next page URL [\#138](https://github.com/transitland/transitland-datastore/pull/138) ([drewda](https://github.com/drewda))
- Fix incorrect method name [\#137](https://github.com/transitland/transitland-datastore/pull/137) ([irees](https://github.com/irees))
- expand Feed and Operator data models to support feed report attributes [\#136](https://github.com/transitland/transitland-datastore/pull/136) ([drewda](https://github.com/drewda))
- Add timezone attributes [\#135](https://github.com/transitland/transitland-datastore/pull/135) ([irees](https://github.com/irees))
- updating gems [\#134](https://github.com/transitland/transitland-datastore/pull/134) ([drewda](https://github.com/drewda))
- admin interface Rails engine/component: adding descriptive information [\#133](https://github.com/transitland/transitland-datastore/pull/133) ([drewda](https://github.com/drewda))
- Updated since [\#132](https://github.com/transitland/transitland-datastore/pull/132) ([irees](https://github.com/irees))
- Schedule additions [\#131](https://github.com/transitland/transitland-datastore/pull/131) ([irees](https://github.com/irees))
- Schedules implementation [\#130](https://github.com/transitland/transitland-datastore/pull/130) ([irees](https://github.com/irees))
- production deploy: piecemeal FeedEater process with better logging [\#129](https://github.com/transitland/transitland-datastore/pull/129) ([drewda](https://github.com/drewda))
- Catch and log uncaught exceptions [\#127](https://github.com/transitland/transitland-datastore/pull/127) ([irees](https://github.com/irees))
- Sort change payloads by created\_at [\#126](https://github.com/transitland/transitland-datastore/pull/126) ([irees](https://github.com/irees))
- FeedEater logging/stability [\#125](https://github.com/transitland/transitland-datastore/pull/125) ([drewda](https://github.com/drewda))
- piecemeal changeset payloads & FeedEater that no longer requires long requests [\#123](https://github.com/transitland/transitland-datastore/pull/123) ([drewda](https://github.com/drewda))
- admin interface should also truncate the new ChangePayload table [\#122](https://github.com/transitland/transitland-datastore/pull/122) ([drewda](https://github.com/drewda))
- Bump transitland-python-client version to use new incremental upload feature [\#121](https://github.com/transitland/transitland-datastore/pull/121) ([irees](https://github.com/irees))
- Changeset refactor 2 [\#120](https://github.com/transitland/transitland-datastore/pull/120) ([irees](https://github.com/irees))
- Bump transitland-python-client version to 0.5.6. [\#119](https://github.com/transitland/transitland-datastore/pull/119) ([irees](https://github.com/irees))
- API pagination links should include any existing query parameters [\#118](https://github.com/transitland/transitland-datastore/pull/118) ([drewda](https://github.com/drewda))
- remove asset pipeline -- it's overkill for getting one CSS file into /admin [\#117](https://github.com/transitland/transitland-datastore/pull/117) ([drewda](https://github.com/drewda))
- nest CSS and JS assets under /admin/assets [\#116](https://github.com/transitland/transitland-datastore/pull/116) ([drewda](https://github.com/drewda))
- Changeset append [\#115](https://github.com/transitland/transitland-datastore/pull/115) ([irees](https://github.com/irees))
- adding an admin dashboard under /admin & expose a way for admins to reset Datastore [\#113](https://github.com/transitland/transitland-datastore/pull/113) ([drewda](https://github.com/drewda))
- Separate worker for GTFS artifacts [\#112](https://github.com/transitland/transitland-datastore/pull/112) ([irees](https://github.com/irees))
- Rails 4.2.3 and gem updates [\#110](https://github.com/transitland/transitland-datastore/pull/110) ([drewda](https://github.com/drewda))
- in dev, the DB connection pool is limited 5, so Sidekiq should run 5 threads [\#109](https://github.com/transitland/transitland-datastore/pull/109) ([drewda](https://github.com/drewda))
- Feedeater child jobs [\#108](https://github.com/transitland/transitland-datastore/pull/108) ([irees](https://github.com/irees))
- releasing identifier\_starts\_with query param [\#107](https://github.com/transitland/transitland-datastore/pull/107) ([drewda](https://github.com/drewda))
- routes endpoint should also serve out GeoJSON [\#106](https://github.com/transitland/transitland-datastore/pull/106) ([drewda](https://github.com/drewda))
- Identifier-starts-with queries [\#105](https://github.com/transitland/transitland-datastore/pull/105) ([drewda](https://github.com/drewda))
- production deploy [\#104](https://github.com/transitland/transitland-datastore/pull/104) ([drewda](https://github.com/drewda))
- wheelchair\_boarding is gtfs attribute [\#103](https://github.com/transitland/transitland-datastore/pull/103) ([irees](https://github.com/irees))
- S3 upload: it's actually ENV\['AWS\_ACCESS\_KEY\_ID'\] [\#102](https://github.com/transitland/transitland-datastore/pull/102) ([drewda](https://github.com/drewda))
- at end of FeedEater jobs, enqueue another async job to upload artifacts to S3 [\#101](https://github.com/transitland/transitland-datastore/pull/101) ([drewda](https://github.com/drewda))
- ConflateStopsWithOsmWorker should only get enqueued after DB transactions are complete [\#100](https://github.com/transitland/transitland-datastore/pull/100) ([drewda](https://github.com/drewda))
- Tyr service improvements [\#99](https://github.com/transitland/transitland-datastore/pull/99) ([drewda](https://github.com/drewda))
- Update transitland-python-client to include vehicle\_type in tags [\#98](https://github.com/transitland/transitland-datastore/pull/98) ([irees](https://github.com/irees))
- update deploy script to reflect commit 0b1a3ca [\#97](https://github.com/transitland/transitland-datastore/pull/97) ([drewda](https://github.com/drewda))
- deploying improvements \(and deploy config changes\) to production [\#96](https://github.com/transitland/transitland-datastore/pull/96) ([drewda](https://github.com/drewda))
- search by tag [\#95](https://github.com/transitland/transitland-datastore/pull/95) ([drewda](https://github.com/drewda))
- Feedeater fix 2 [\#94](https://github.com/transitland/transitland-datastore/pull/94) ([irees](https://github.com/irees))
- Set up circleci to deploy to production [\#93](https://github.com/transitland/transitland-datastore/pull/93) ([rmarianski](https://github.com/rmarianski))
- route JSON: include operator Onestop ID and name [\#92](https://github.com/transitland/transitland-datastore/pull/92) ([drewda](https://github.com/drewda))
- Feed imports log exceptions [\#91](https://github.com/transitland/transitland-datastore/pull/91) ([drewda](https://github.com/drewda))
- FeedEater webhook can take `feed\_onestop\_ids` as an optional parameter [\#90](https://github.com/transitland/transitland-datastore/pull/90) ([drewda](https://github.com/drewda))
- add Sentry for Rails exception tracking [\#89](https://github.com/transitland/transitland-datastore/pull/89) ([drewda](https://github.com/drewda))
- update transitland-ruby-client to get Git over HTTP [\#88](https://github.com/transitland/transitland-datastore/pull/88) ([drewda](https://github.com/drewda))
- TYR/Valhalla URL can now be configured by ENV\['TYR\_HOST'\] [\#87](https://github.com/transitland/transitland-datastore/pull/87) ([drewda](https://github.com/drewda))
- Feedeater improved changeset [\#86](https://github.com/transitland/transitland-datastore/pull/86) ([irees](https://github.com/irees))
- add Feed and FeedImport models & FeedEater now uses that Ruby code [\#84](https://github.com/transitland/transitland-datastore/pull/84) ([drewda](https://github.com/drewda))
- Feedeater fix validator [\#83](https://github.com/transitland/transitland-datastore/pull/83) ([irees](https://github.com/irees))
- standardize on `TYR\_AUTH\_TOKEN` as a env variable for both Rails and Python code [\#82](https://github.com/transitland/transitland-datastore/pull/82) ([drewda](https://github.com/drewda))
- reference transitland-ruby-client by version tag [\#81](https://github.com/transitland/transitland-datastore/pull/81) ([drewda](https://github.com/drewda))
- update schema.rb and annotations [\#80](https://github.com/transitland/transitland-datastore/pull/80) ([drewda](https://github.com/drewda))
- standardize on TRANSITLAND\_DATASTORE\_HOST env variable [\#79](https://github.com/transitland/transitland-datastore/pull/79) ([drewda](https://github.com/drewda))
- remove NewRelic and Skylight [\#78](https://github.com/transitland/transitland-datastore/pull/78) ([drewda](https://github.com/drewda))
- rake enqueue\_feed\_eater\_worker task can now take Onestop IDs for feeds [\#77](https://github.com/transitland/transitland-datastore/pull/77) ([drewda](https://github.com/drewda))
- JSON pagination fix [\#76](https://github.com/transitland/transitland-datastore/pull/76) ([drewda](https://github.com/drewda))
- Bug fix; did not update \_\_main\_\_ to use task [\#75](https://github.com/transitland/transitland-datastore/pull/75) ([irees](https://github.com/irees))
- Specify commits/tags for dependencies [\#73](https://github.com/transitland/transitland-datastore/pull/73) ([irees](https://github.com/irees))
- FeedEaterWorker: mock all Python calls [\#72](https://github.com/transitland/transitland-datastore/pull/72) ([drewda](https://github.com/drewda))
- Feedeater improvements [\#71](https://github.com/transitland/transitland-datastore/pull/71) ([irees](https://github.com/irees))
- when serializing Stop JSON, include RouteServingStop relationships [\#70](https://github.com/transitland/transitland-datastore/pull/70) ([drewda](https://github.com/drewda))
- TRANSITLAND\_DATASTORE\_AUTH\_TOKEN is now the standard [\#69](https://github.com/transitland/transitland-datastore/pull/69) ([drewda](https://github.com/drewda))
- for now FeedEaterWorker spec will skip system calls to Python code [\#68](https://github.com/transitland/transitland-datastore/pull/68) ([drewda](https://github.com/drewda))
- Use TRANSITLAND\_FEED\_DATA\_PATH for feedeater data [\#67](https://github.com/transitland/transitland-datastore/pull/67) ([irees](https://github.com/irees))
- Update transitland-ruby-client [\#66](https://github.com/transitland/transitland-datastore/pull/66) ([drewda](https://github.com/drewda))
- Python virtualenv [\#65](https://github.com/transitland/transitland-datastore/pull/65) ([irees](https://github.com/irees))
- API endpoints now allow filtering by `?onestop\_id=` [\#64](https://github.com/transitland/transitland-datastore/pull/64) ([drewda](https://github.com/drewda))
- FeedEater Implementation [\#63](https://github.com/transitland/transitland-datastore/pull/63) ([irees](https://github.com/irees))
- async job to conflate Stop's against OSM way IDs [\#62](https://github.com/transitland/transitland-datastore/pull/62) ([drewda](https://github.com/drewda))
- URI style identifiers [\#61](https://github.com/transitland/transitland-datastore/pull/61) ([drewda](https://github.com/drewda))
- Gem updates [\#60](https://github.com/transitland/transitland-datastore/pull/60) ([drewda](https://github.com/drewda))
- starting to move Spindle Server into Datastore [\#59](https://github.com/transitland/transitland-datastore/pull/59) ([drewda](https://github.com/drewda))
- Serializer performance [\#58](https://github.com/transitland/transitland-datastore/pull/58) ([drewda](https://github.com/drewda))
- File download options [\#57](https://github.com/transitland/transitland-datastore/pull/57) ([drewda](https://github.com/drewda))
- secure with an API token \(hard coded\) [\#56](https://github.com/transitland/transitland-datastore/pull/56) ([drewda](https://github.com/drewda))
- V1 polish [\#55](https://github.com/transitland/transitland-datastore/pull/55) ([drewda](https://github.com/drewda))
- removing New Relic and try rack-mini-profiler [\#53](https://github.com/transitland/transitland-datastore/pull/53) ([drewda](https://github.com/drewda))
- API: changing the name of keys on OperatorServingStop records [\#52](https://github.com/transitland/transitland-datastore/pull/52) ([drewda](https://github.com/drewda))
- Reduce size of API queries [\#51](https://github.com/transitland/transitland-datastore/pull/51) ([drewda](https://github.com/drewda))
- temporarily adding New Relic [\#50](https://github.com/transitland/transitland-datastore/pull/50) ([drewda](https://github.com/drewda))
- Serializer caching [\#49](https://github.com/transitland/transitland-datastore/pull/49) ([drewda](https://github.com/drewda))
- API: when listing OperatorsServingStop, include the operator name [\#48](https://github.com/transitland/transitland-datastore/pull/48) ([drewda](https://github.com/drewda))
- CORS headers to allow all access [\#47](https://github.com/transitland/transitland-datastore/pull/47) ([drewda](https://github.com/drewda))
- delete public files [\#46](https://github.com/transitland/transitland-datastore/pull/46) ([meghanhade](https://github.com/meghanhade))
- change popup text color [\#45](https://github.com/transitland/transitland-datastore/pull/45) ([meghanhade](https://github.com/meghanhade))
- disable zoom, disable fitbounds [\#44](https://github.com/transitland/transitland-datastore/pull/44) ([meghanhade](https://github.com/meghanhade))
- Playground [\#43](https://github.com/transitland/transitland-datastore/pull/43) ([meghanhade](https://github.com/meghanhade))
- API endpoints for `operatedBy` and `servedBy` queries [\#41](https://github.com/transitland/transitland-datastore/pull/41) ([drewda](https://github.com/drewda))
- API endpoints that allow searching by identifier should also search name fields in the same query [\#40](https://github.com/transitland/transitland-datastore/pull/40) ([drewda](https://github.com/drewda))
- API endpoints: allow the number per page to be specified [\#39](https://github.com/transitland/transitland-datastore/pull/39) ([drewda](https://github.com/drewda))
- allow for searching for routes by bbox [\#38](https://github.com/transitland/transitland-datastore/pull/38) ([drewda](https://github.com/drewda))
- Fixes for route changesets [\#37](https://github.com/transitland/transitland-datastore/pull/37) ([drewda](https://github.com/drewda))
- allow for `~` and `@` in the name component of a Onestop ID [\#36](https://github.com/transitland/transitland-datastore/pull/36) ([drewda](https://github.com/drewda))
- Route geometry [\#35](https://github.com/transitland/transitland-datastore/pull/35) ([drewda](https://github.com/drewda))
- Update gems and fix specs [\#34](https://github.com/transitland/transitland-datastore/pull/34) ([drewda](https://github.com/drewda))
- updating airborne gem and its dependencies [\#33](https://github.com/transitland/transitland-datastore/pull/33) ([drewda](https://github.com/drewda))
- Upgrade Rails and gems [\#32](https://github.com/transitland/transitland-datastore/pull/32) ([drewda](https://github.com/drewda))
- Operator route stop relationship R2 [\#31](https://github.com/transitland/transitland-datastore/pull/31) ([drewda](https://github.com/drewda))
- Operator route stop relationship r1 [\#30](https://github.com/transitland/transitland-datastore/pull/30) ([drewda](https://github.com/drewda))
- renaming the app to Transitland Datastore [\#28](https://github.com/transitland/transitland-datastore/pull/28) ([drewda](https://github.com/drewda))
- add Operator and OperatorServingStop [\#27](https://github.com/transitland/transitland-datastore/pull/27) ([drewda](https://github.com/drewda))
- constrain map zoom [\#26](https://github.com/transitland/transitland-datastore/pull/26) ([drewda](https://github.com/drewda))
- rake import\_from\_gtfs task should also be able to fetch from remote URL [\#25](https://github.com/transitland/transitland-datastore/pull/25) ([drewda](https://github.com/drewda))
- Add slippy map [\#24](https://github.com/transitland/transitland-datastore/pull/24) ([meghanhade](https://github.com/meghanhade))
- Update gems [\#22](https://github.com/transitland/transitland-datastore/pull/22) ([drewda](https://github.com/drewda))
- Changesets [\#20](https://github.com/transitland/transitland-datastore/pull/20) ([drewda](https://github.com/drewda))
- automatically generate and assign Onestop IDs [\#19](https://github.com/transitland/transitland-datastore/pull/19) ([drewda](https://github.com/drewda))
- waffle.io Badge [\#8](https://github.com/transitland/transitland-datastore/pull/8) ([waffle-iron](https://github.com/waffle-iron))
- deploy from circle [\#3](https://github.com/transitland/transitland-datastore/pull/3) ([heffergm](https://github.com/heffergm))
- improving pagination for JSON output [\#2](https://github.com/transitland/transitland-datastore/pull/2) ([drewda](https://github.com/drewda))
- API 1.0.0: Stop's and StopIdentifier's [\#1](https://github.com/transitland/transitland-datastore/pull/1) ([drewda](https://github.com/drewda))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*