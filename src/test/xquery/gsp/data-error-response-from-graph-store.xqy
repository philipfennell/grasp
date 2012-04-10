xquery version "1.0-ml" encoding "utf-8";

import module namespace gsp = "http://www.w3.org/TR/sparql11-http-rdf-update/" at
		"main/xquery/lib-gsp.xqy"; 

import module namespace test = "http://www.w3.org/TR/sparql11-protocol/test" at 
		"test/resources/xquery/test.xqy"; 

declare namespace st 	= "http://www.w3.org/2007/SPARQL/protocol-types#";
declare namespace error = "http://marklogic.com/xdmp/error";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

let $response as element() := 
<response status="406" xmlns="http://www.w3.org/Protocols/rfc2616">
	<header name="server" value="Apache-Coyote/1.1"/>
	<header name="vary" value="Accept"/>
	<header name="content-disposition" value="attachment; filename=statements.nt"/>
	<header name="content-type" value="text/plain;charset=US-ASCII"/>
	<header name="content-language" value="en-US"/>
	<header name="date" value="Tue, 10 Apr 2012 10:32:38 GMT"/>
	<header name="connection" value="close"/>
	<body content-type="text/plain">No acceptable file format found.</body>
</response>
let $result as item() :=
	try {
		gsp:data($response)
	} catch($error) {
		$error
	} 
return
	$result instance of element(error:error)