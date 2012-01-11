xquery version "1.0-ml" encoding "utf-8";

import module namespace gsp = "http://www.w3.org/TR/sparql11-http-rdf-update/" at
		"main/xquery/lib-gsp.xqy"; 

import module namespace test = "http://www.w3.org/TR/sparql11-protocol/test" at 
		"test/resources/xquery/test.xqy"; 

declare namespace st 	= "http://www.w3.org/2007/SPARQL/protocol-types#";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

(: Returns the default graph as RDF/XML. :)
gsp:retrieve-graph(
	concat($test:SERVICE_URI, 'test/data'), 
	(''),
	(),
	'application/rdf+xml'
)
