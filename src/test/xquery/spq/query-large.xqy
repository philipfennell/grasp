xquery version "1.0-ml" encoding "utf-8";

import module namespace spq = "http://www.w3.org/TR/sparql11-protocol/" at
		"main/xquery/lib-spq.xqy"; 

import module namespace test = "http://www.w3.org/TR/sparql11-protocol/test" at 
		"test/resources/xquery/test.xqy"; 

declare default function namespace "http://www.w3.org/2005/xpath-functions";


let $padding as xs:string := 
	string-join((for $line in 1 to (($spq:MAX_REQUEST_URI_LENGTH idiv 10) + 1)
	return
		'#123456789&#10;'), '')
return
	spq:query(
		$test:QUERY_ENDPOINT_URI, 
		(),
		(),
		concat($padding,
		 'SELECT * 
		 {?s ?p ?o} 
		 LIMIT 10')
	)
