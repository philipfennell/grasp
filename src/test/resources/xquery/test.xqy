xquery version "1.0" encoding "utf-8";

module namespace test = "http://www.w3.org/TR/sparql11-protocol/test";

import module namespace store = "http://www.w3.org/TR/sparql11-protocol/test/store" 
	at "apache-fuseki-endpoints.xqy";

declare default function namespace "http://www.w3.org/2005/xpath-functions";


declare variable $test:SERVICE_URI as xs:string 		:= $store:SERVICE_URI; 
declare variable $test:DATASET as xs:string 			:= $store:DATASET; 
declare variable $test:DATA_ENDPOINT_URI as xs:string  	:= $store:DATA_ENDPOINT_URI; 
declare variable $test:QUERY_ENDPOINT_URI as xs:string  := $store:QUERY_ENDPOINT_URI; 
declare variable $test:UPDATE_ENDPOINT_URI as xs:string := $store:UPDATE_ENDPOINT_URI; 
