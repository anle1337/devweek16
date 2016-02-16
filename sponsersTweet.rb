sponsers = %w{galvanize codeanywhere concierge dji flowroute havenondemand ibm capitalone cortical devbootcamp equinix gupshup intuit kony magnet microsoft netapp redislabs theta sparkpost}
puts sponsers

a = $twitter.search("#galvanize", {:count => 1})
puts a


