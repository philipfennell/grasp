xquery version "1.0" encoding "utf-8";

module namespace test = "http://www.w3.org/TR/sparql11-protocol/test";

declare default function namespace "http://www.w3.org/2005/xpath-functions";


declare variable $test:SERVICE_URI as xs:string := "http://localhost:3030/"; 
declare variable $test:DATASET as xs:string 	:= "test"; 
declare variable $test:QUERY_ENDPOINT_URI as xs:string  := concat($test:SERVICE_URI, $test:DATASET, '/query'); 
declare variable $test:UPDATE_ENDPOINT_URI as xs:string := concat($test:SERVICE_URI, $test:DATASET, '/update'); 
