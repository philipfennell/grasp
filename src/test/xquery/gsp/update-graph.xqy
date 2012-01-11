xquery version "1.0-ml" encoding "utf-8";

import module namespace gsp = "http://www.w3.org/TR/sparql11-http-rdf-update/" at
		"main/xquery/lib-gsp.xqy"; 

import module namespace test = "http://www.w3.org/TR/sparql11-protocol/test" at 
		"test/resources/xquery/test.xqy"; 

declare namespace st 	= "http://www.w3.org/2007/SPARQL/protocol-types#";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

(: Merges the passed graph into the default graph. :)
gsp:update-graph(
	concat($test:SERVICE_URI, 'test/data'), 
	(''),
	(),
	<rdf:RDF xmlns:dc="http://purl.org/dc/elements/1.1/"
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
			xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#">
		<rdf:Description rdf:about="http://example.org/book/book3">
			<dc:creator rdf:nodeID="A0"/>
			<dc:title>Harry Potter and the Prisoner Of Azkaban</dc:title>
		</rdf:Description>
		<rdf:Description rdf:nodeID="A1">
			<vcard:Given>Joanna</vcard:Given>
			<vcard:Family>Rowling</vcard:Family>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book7">
			<dc:creator>J.K. Rowling</dc:creator>
			<dc:title>Harry Potter and the Deathly Hallows</dc:title>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book2">
			<dc:creator rdf:nodeID="A0"/>
			<dc:title>Harry Potter and the Chamber of Secrets</dc:title>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book5">
			<dc:creator>J.K. Rowling</dc:creator>
			<dc:title>Harry Potter and the Order of the Phoenix</dc:title>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book4">
			<dc:title>Harry Potter and the Goblet of Fire</dc:title>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book6">
			<dc:creator>J.K. Rowling</dc:creator>
			<dc:title>Harry Potter and the Half-Blood Prince</dc:title>
		</rdf:Description>
		<rdf:Description rdf:about="http://example.org/book/book1">
			<dc:creator>J.K. Rowling</dc:creator>
			<dc:title>Harry Potter and the Philosopher's Stone</dc:title>
		</rdf:Description>
		<rdf:Description rdf:nodeID="A0">
			<vcard:N rdf:nodeID="A1"/>
			<vcard:FN>J.K. Rowling</vcard:FN>
		</rdf:Description>
	</rdf:RDF>
)
