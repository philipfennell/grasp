xquery version "1.0-ml" encoding "utf-8";

import module namespace gsp = "http://www.w3.org/TR/sparql11-http-rdf-update/" at
		"main/xquery/lib-gsp.xqy"; 

import module namespace test = "http://www.w3.org/TR/sparql11-protocol/test" at 
		"test/resources/xquery/test.xqy"; 

declare namespace st 	= "http://www.w3.org/2007/SPARQL/protocol-types#";

declare default function namespace "http://www.w3.org/2005/xpath-functions";


(: Returns the request fragment. :)
gsp:submission(
	'put',
	concat($test:SERVICE_URI, 'test/data'), 
	(''),
	(),
	'application/rdf+xml',
	<rdf:Description xmlns:dc="http://purl.org/dc/elements/1.1/"
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
			rdf:about="http://example.org/book/book1">
		<dc:date>2001-11-04</dc:date>
		<dc:publisher rdf:resource="http://live.dbpedia.org/page/Bloomsbury_Publishing"/>
	</rdf:Description>
)
