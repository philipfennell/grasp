xquery version "1.0" encoding "utf-8";

(:
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 :     http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :)
 
(:~
 : This library provides functions for querying RDF Graph Stores
 : that implement the W3C's SPARQL Protocol:
 : <http://www.w3.org/TR/sparql11-protocol/>
 : @author Philip A. R. Fennell
 :)

module namespace spq = "http://www.w3.org/TR/sparql11-protocol/";

import module namespace impl = "http://www.marklogic.com/http" at
		"lib-ml.xqy"; 

declare namespace http	= "http://www.w3.org/Protocols/rfc2616"; 
declare namespace sr 	= "http://www.w3.org/2005/sparql-results#"; 

declare default function namespace "http://www.w3.org/2005/xpath-functions";

(:~ Request encodings. :)
declare variable $SPARQL_RESULTS_XML	as xs:string := "application/sparql-results+xml";
declare variable $SPARQL_RESULTS_JSON	as xs:string := "application/sparql-results+json";
declare variable $RDF_XML 				as xs:string := "application/rdf+xml";
declare variable $TSV 					as xs:string := "text/tab-separated-values";
declare variable $CSV 					as xs:string := "text/csv";

(:~ User-agent string. :) 
declare variable $USER_AGENT	as xs:string := "xqy-sparql-protocol-client/0.4";

(:~ Maximum request URI length. :)
declare variable $MAX_REQUEST_URI_LENGTH as xs:integer := 256;


(:~
 : Extracts the content of the response body or throws an error if the response
 : XML fragment indicates an error response from the Graph Store. 
 : @param $response the HTTP response fragment.
 : @return either an XML fragment or a string depending upon the response 
 : content-type.
 : @throws GSP002 - Graph Store Reports an Error.
 :)
declare function spq:data($response as element(http:response))
	as item()*
{
	(: 
	 : If the response status code is less than 400 then assume all is well, 
	 : otherwise throw an exception with the response message in it. 
	 :)
	if (number($response/@status) lt 400) then 
		typeswitch ($response/http:body/(* | text())) 
		case $body as text() 
		return 
			string($response/http:body/text())
		default 
		return
			$response/http:body/*
	else
		error(
			xs:QName('SPQ002'), 
			'SPARQL Endpoint Reports an Error.',
			string($response/http:body/text())
		)
};


(:~
 : The HTTP binding for query operation. If the requests length is greater than 
 : the predefined threshold the POST is used instead of GET.
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $query the SPARQL query to be sent.
 : @param $mediaType the Media MIME-Type for the HTTP accept header.
 : @return 
 :)
declare function spq:query($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string, $mediaType as xs:string) 
	as element(http:response)
{
	let $requestURI as xs:string := string(spq:submission('POST', $endPointURI, 
			$defaultGraphURIs, $namedGraphURIs, $query, $mediaType)/@href)
	return
		if (string-length($requestURI) gt $MAX_REQUEST_URI_LENGTH) then 
			spq:query-post($endPointURI, $defaultGraphURIs, $namedGraphURIs,
				$query, $mediaType)
		else
			spq:query-get($endPointURI, $defaultGraphURIs, $namedGraphURIs,
				$query, $mediaType)
};


(:~
 : The HTTP binding for query operation. Assumes the default Accept header
 : for the SPARQL XML Results format. If the requests length is greater than 
 : the predefined threshold the POST is used instead of GET.
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $query the SPARQL query to be sent.
 : @return the query response wrapped in an query-result element that carries 
 : the response content type.
 :)
declare function spq:query($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string) 
	as element(http:response)
{
	spq:query($endPointURI, $defaultGraphURIs, $namedGraphURIs, $query, 
			$SPARQL_RESULTS_XML)
};


(:~
 : The HTTP GET binding for query operation. Assumes the default Accept header
 : for the SPARQL XML Results format.
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $query the SPARQL query to be sent.
 : @return the query response wrapped in an query-result element that carries 
 : the response content type.
 :)
declare function spq:query-get($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string) 
						as element(http:response)
{
	spq:query-get($endPointURI, $defaultGraphURIs, $namedGraphURIs, $query, 
			$SPARQL_RESULTS_XML)
};


(:~
 : The HTTP GET binding for query operation. 
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $query the SPARQL query to be sent.
 : @param $mediaType the Media MIME-Type for the HTTP accept header.
 : @return the query response wrapped in an query-result element that carries 
 : the response content type.
 :)
declare function spq:query-get($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string, $mediaType as xs:string) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request( 
					spq:submission('GET', $endPointURI, $defaultGraphURIs, 
							$namedGraphURIs, $query, $mediaType))
	)
};


(:~
 : The HTTP GET binding for query operation. Assumes the default Accept header
 : for the SPARQL XML Results format.
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $query the SPARQL query to be sent.
 : @return the query response wrapped in an query-result element that carries 
 : the response content type.
 :)
declare function spq:query-post($endPointURI as xs:string,
		$defaultGraphURIs as xs:string*, 
				$namedGraphURIs as xs:string*, $query as xs:string) 
						as element(http:response)
{
	spq:query-post($endPointURI, $defaultGraphURIs, $namedGraphURIs,
			$query, $SPARQL_RESULTS_XML)
};


(:~
 : The HTTP GET binding for query operation. Assumes the default Accept header
 : for the SPARQL XML Results format.
 : @param $endPointURI the URL of the target SPARQL end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $query the SPARQL query to be sent.
 : @param $mediaType the Media MIME-Type for the HTTP accept header.
 : @return the query response wrapped in an query-result element that carries 
 : the response content type.
 :)
declare function spq:query-post($endPointURI as xs:string,
		$defaultGraphURIs as xs:string*, $namedGraphURIs as xs:string*, 
				$query as xs:string, $mediaType as xs:string) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request( 
					spq:submission('POST', $endPointURI, $defaultGraphURIs, 
							$namedGraphURIs, $query, $mediaType))
	)
};


(:~
 : Builds an XML fragment that carries the request details.
 : @param $method HTTP method (GET|POST)
 : @param $endPointURI the URL of the target Graph Store end-point. 
 : @param $defaultGraphURIs the default graph URIs.
 : @param $namedGraphURIs the named graph URIs.
 : @param $query An RDF graph.
 : @param $mediaType Media MIME-Type for the HTTP accpet header.
 : @return the HTTP request XML fragment.
 :)
declare function (: private :) spq:submission($method as xs:string, $endpoitURI as xs:string, $defaultGraphURIs as xs:string*, 
		$namedGraphURIs as xs:string*, $query as item()?, $mediaType as xs:string) as 
				element(http:request) 
{
	let $queryParam as xs:string := concat('query=', encode-for-uri($query))
	let $defaultGraphUriParams as xs:string* := for $uri in $defaultGraphURIs return concat('default-graph-uri=', encode-for-uri($uri))
	let $namedGraphUriParams as xs:string* := for $uri in $namedGraphURIs return concat('named-graph-uri=', encode-for-uri($uri))
	let $requestParams as xs:string := 
			concat('?', string-join(($queryParam, $defaultGraphUriParams, $namedGraphUriParams), '&amp;'))
	return
		<request xmlns="http://www.w3.org/Protocols/rfc2616" method="{$method}" 
				href="{concat($endpoitURI, if (exists($requestParams)) then $requestParams else '')}">
			<header name="accept" value="{$mediaType}"/>
			<header name="user-agent" value="{$USER_AGENT}"/>
			<header name="content-type" value="application/x-www-form-urlencoded"/>
			<header name="encoding" value="UTF-8"/>
		</request>
};
