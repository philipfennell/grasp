<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
		xmlns:p="http://www.w3.org/ns/xproc" 
		xmlns:test="http://www.marklogic.com/test"
		name="tests"
		version="1.0">
	
	<p:output port="result">
		<p:pipe port="result" step="build"/>
	</p:output>
	
	<p:serialization port="result" encoding="utf-8" indent="true" 
			media-type="application/xml" method="xml" omit-xml-declaration="false"/>
	
	<p:import href="library-1.0.xpl"/>
	
	<p:directory-list path="../../xproc" include-filter=".*\.xpl" exclude-filter="tests.xpl"/>
	
	<p:xslt name="build">
		<p:documentation>Aggregates the 'tests' pipeline from individual test pipelines.</p:documentation>
		<p:input port="stylesheet">
			<p:document href="../xslt/build-test-pipeline.xsl"/>
		</p:input>
		<p:input port="parameters">
			<p:empty/>
		</p:input>
	</p:xslt>
	
	<p:xslt name="documentation">
		<p:documentation>Extracts and aggregates the documentation from each test pipeline.</p:documentation>
		<p:input port="stylesheet">
			<p:document href="../xslt/document-tests.xsl"/>
		</p:input>
		<p:input port="parameters">
			<p:empty/>
		</p:input>
	</p:xslt>
	
	<p:store encoding="UTF-8" href="../../results/tests.xhtml" indent="true" media-type="application/xhtml+xml" method="xml"/>
	
</p:declare-step>