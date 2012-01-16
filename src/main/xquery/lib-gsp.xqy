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
 : This library provides functions for accessing and managing RDF Graph Stores
 : that implement the W3C's Graph Store HTTP Protocol:
 : <http://www.w3.org/TR/sparql11-http-rdf-update/>
 : @author Philip A. R. Fennell
 :)

module namespace gsp = "http://www.w3.org/TR/sparql11-http-rdf-update/";

import module namespace impl = "http://www.marklogic.com/http" at
		"lib-ml.xqy"; 

declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare namespace http = "http://www.w3.org/Protocols/rfc2616"; 

(:~ User-agent string. :) 
declare variable $USER_AGENT	as xs:string := "xqy-graph-store-http-protocol-client/0.1";

(:~ MIME-Types. :)
declare variable $RDF_XML 		as xs:string := "application/rdf+xml";
declare variable $NTRIPLES 		as xs:string := "text/plain";
declare variable $TURTLE 		as xs:string := "text/turtle";


(:~
 : Retrieve a graph's metainformation. 
 : @param $endPointURI the URL of the target Graph Store end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:retrieve-metainfo($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, 
				$namedGraphURIs as xs:string*) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('HEAD', $endPointURI, 
					$defaultGraphURIs, $namedGraphURIs, $RDF_XML, ())))
};


(:~
 : Retrieve the default graph as application/rdf+xml serialisation.
 : @param $endPointURI the URL of the target Graph Store end-point.
 : @return an http:response element contains HTTP metainfo and response body.
 :)
declare function gsp:retrieve-default-graph($endPointURI as xs:string) 
						as element(http:response)
{
	gsp:retrieve-graph($endPointURI, (''), (), $RDF_XML)
};


(:~
 : Retrieve a graph as application/rdf+xml serialisation.
 : @param $endPointURI the URL of the target Graph Store end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @return an http:response element contains HTTP metainfo and response body.
 :)
declare function gsp:retrieve-graph($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, 
				$namedGraphURIs as xs:string*) 
						as element(http:response)
{
	gsp:retrieve-graph($endPointURI, $defaultGraphURIs, $namedGraphURIs, 
			$RDF_XML)
};


(:~
 : Retrieve a graph specifiying the required serialisation. 
 : @param $endPointURI the URL of the target Graph Store end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $mediaType the content-type that will be acceptable to the client.
 : @return an http:response element contains HTTP metainfo and response body.
 :)
declare function gsp:retrieve-graph($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, 
				$namedGraphURIs as xs:string*, $mediaType as xs:string) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('GET', $endPointURI, 
					$defaultGraphURIs, $namedGraphURIs, $mediaType, ())))
};


(:~
 : Merge Graph - merges current graph with submitted graph. 
 : @param $endPointURI the URL of the target Graph Store end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:merge-graph($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, 
				$namedGraphURIs as xs:string*, $graph as item()) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('POST', $endPointURI, 
					$defaultGraphURIs, $namedGraphURIs, $RDF_XML, $graph)))
};


(:~
 : Update Graph - replaces current graph with submitted graph. 
 : @param $endPointURI the URL of the target Graph Store end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:update-graph($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, 
				$namedGraphURIs as xs:string*, $graph as item()) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('PUT', $endPointURI, 
					$defaultGraphURIs, $namedGraphURIs, $RDF_XML, $graph)))
};


(:~
 : Delete a graph. 
 : @param $endPointURI the URL of the target Graph Store end-point.
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @return an http:response element contains HTTP metainfo.
 :)
declare function gsp:delete-graph($endPointURI as xs:string, 
		$defaultGraphURIs as xs:string*, 
				$namedGraphURIs as xs:string*) 
						as element(http:response)
{
	impl:normalise-response(
			impl:http-request(gsp:submission('DELETE', $endPointURI, 
					$defaultGraphURIs, $namedGraphURIs, $RDF_XML, ())))
};


(:~
 : Builds an XML fragment that carries the request details.
 : @param $method HTTP method (HEAD|GET|POST|PUT|DELETE)
 : @param $endPointURI the URL of the target Graph Store end-point. 
 : @param $defaultGraphURIs the default graph URIs
 : @param $namedGraphURIs the named graph URIs
 : @param $mediaType Media MIME-Type for the HTTP accpet header
 : @param $body An RDF graph.
 : @return the HTTP request XML fragment.
 :)
declare function gsp:submission($method as xs:string, $endpoitURI as xs:string, $defaultGraphURIs as xs:string*, 
		$namedGraphURIs as xs:string*, $mediaType as xs:string, $body as item()?) as 
				element(http:request) 
{
	let $defaultGraphUriParams as xs:string* := for $uri in $defaultGraphURIs return concat('default=', $uri)
	let $namedGraphUriParams as xs:string* := for $uri in $namedGraphURIs return concat('graph=', $uri)
	let $requestParams as xs:string := concat('?', string-join(($defaultGraphUriParams, $namedGraphUriParams), '&amp;'))
	return
		<request xmlns="http://www.w3.org/Protocols/rfc2616" method="{$method}" 
				href="{concat($endpoitURI, if (exists($requestParams)) then $requestParams else '')}">
			<header name="accept" value="{$mediaType}"/>
			<header name="user-agent" value="{$USER_AGENT}"/>
			<header name="content-type" value="{$RDF_XML}"/>
			<header name="encoding" value="UTF-8"/>
			{
				if (exists($body)) then  
					<body xmlns="http://www.w3.org/Protocols/rfc2616" content-type="{$RDF_XML}">{$body}</body>
				else
					()
			}
		</request>
}; 
