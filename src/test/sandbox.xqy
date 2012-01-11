xquery version "1.0-ml" encoding "utf-8";

import module namespace impl = "http://www.marklogic.com/http" at
		"main/xquery/lib-ml.xqy"; 

import module namespace gsp = "http://www.w3.org/TR/sparql11-http-rdf-update/" at
		"main/xquery/lib-gsp.xqy"; 

import module namespace test = "http://www.w3.org/TR/sparql11-protocol/test" at 
		"test/resources/xquery/test.xqy"; 

declare namespace st 	= "http://www.w3.org/2007/SPARQL/protocol-types#";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

let $request as element() := 
	<request xmlns="http://www.w3.org/Protocols/rfc2616" method="post" href="http://localhost:3030/test/query?query={encode-for-uri('SELECT * {{?s ?p ?o}} LIMIT 10')}">
		<header name="accept" value="application/sparql-results+xml"/>
		<header name="user-agent" value="xqy-sparql-protocol-client/0.3"/>
		<header name="content-type" value="application/x-www-form-urlencoded"/>
		<header name="encoding" value="UTF-8"/>
	</request>
return
	impl:normalise-response(impl:http-request($request))
(:	impl:http-request($request):)