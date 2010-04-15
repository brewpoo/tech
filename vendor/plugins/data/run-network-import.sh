#!/bin/sh
script/runner vendor/plugins/data/import.rb assigned_subnets vendor/plugins/data/assigned_subnets.csv
script/runner vendor/plugins/data/import.rb networks vendor/plugins/data/networks.csv
script/runner vendor/plugins/data/import.rb hosts vendor/plugins/data/hosts.csv
script/runner vendor/plugins/data/import.rb interfaces vendor/plugins/data/interfaces.csv
script/runner vendor/plugins/data/import.rb scopes vendor/plugins/data/scopes.csv
script/runner vendor/plugins/data/import.rb schema vendor/plugins/data/schema.csv
script/runner vendor/plugins/data/import.rb virtualhosts vendor/plugins/data/virtualhosts.csv
script/runner vendor/plugins/data/import.rb virtualinterfaces vendor/plugins/data/interfaces.csv
script/runner vendor/plugins/data/import.rb circuits vendor/plugins/data/circuits.csv
script/runner vendor/plugins/data/import.rb pplines vendor/plugins/data/pplines.csv
script/runner vendor/plugins/data/import.rb diallines vendor/plugins/data/diallines.csv
script/runner vendor/plugins/data/import.rb mplines vendor/plugins/data/mplines.csv
script/runner vendor/plugins/data/import.rb mpdlcis vendor/plugins/data/mpdlcis.csv
script/runner vendor/plugins/data/import.rb mppvcs vendor/plugins/data/mppvcs.csv
script/runner vendor/plugins/data/import.rb vlans vendor/plugins/data/vlans.csv

