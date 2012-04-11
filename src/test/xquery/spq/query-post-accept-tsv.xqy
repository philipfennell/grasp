xquery version "1.0-ml" encoding "utf-8";

import module namespace spq = "http://www.w3.org/TR/sparql11-protocol/" at
		"main/xquery/lib-spq.xqy"; 

import module namespace test = "http://www.w3.org/TR/sparql11-protocol/test" at 
		"test/resources/xquery/test.xqy"; 

declare default function namespace "http://www.w3.org/2005/xpath-functions";

(:  :)
spq:query-post(
	$test:QUERY_ENDPOINT_URI, 
	(),
	(),
	'SELECT * {?s ?p ?o} LIMIT 10',
	'text/tab-separated-values'
)
