xquery version "1.0-ml" encoding "utf-8";

import module namespace gsp = "http://www.w3.org/TR/sparql11-http-rdf-update/" at
		"main/xquery/lib-gsp.xqy"; 

import module namespace test = "http://www.w3.org/TR/sparql11-protocol/test" at 
		"test/resources/xquery/test.xqy"; 

declare namespace st 	= "http://www.w3.org/2007/SPARQL/protocol-types#";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

let $response as element() := 
<response status="200" xmlns="http://www.w3.org/Protocols/rfc2616">
	<header name="server" value="Apache-Coyote/1.1"/>
	<header name="vary" value="Accept"/>
	<header name="content-disposition" value="attachment; filename=statements.rdf"/>
	<header name="content-type" value="application/rdf+xml;charset=UTF-8"/>
	<header name="content-language" value="en-US"/>
	<header name="date" value="Tue, 10 Apr 2012 10:30:02 GMT"/>
	<header name="connection" value="close"/>
	<body content-type="application/rdf+xml">
		<rdf:RDF xmlns:dc="http://purl.org/dc/elements/1.1/"
			xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
			xmlns:psys="http://proton.semanticweb.org/protonsys#"
			xmlns:owl="http://www.w3.org/2002/07/owl#"
			xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
			xmlns:pext="http://proton.semanticweb.org/protonext#"/>
	</body>
</response>
return
	gsp:data($response) instance of element()
