# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Verb.create(
    name: 'is absorbed by',
    rdaw_id: 'P10145',
    desc: 'Relates a work to a work that incorporates another work.'
)

Verb.create(
    name: 'is absorbed in part by',
    rdaw_id: 'P10146',
    desc: 'Relates a work to a work that incorporates part of the content of another work.'
)

Verb.create(
    name: 'is continued by',
    rdaw_id: 'P10191',
    desc: 'Relates a work to a work whose content continues an earlier work.'
)

Verb.create(
    name: 'is continued in part by',
    rdaw_id: 'P10104',
    desc: 'Relates a work to a work part of whose content separated from an earlier work to form a new work.'
)
