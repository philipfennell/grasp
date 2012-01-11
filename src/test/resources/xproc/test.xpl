<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
		xmlns:test="http://www.w3.org/ns/xproc/test" 
		version="1.0">
	
	<p:documentation>Test Library Steps</p:documentation>
	
	
	<p:declare-step name="validate-with-schematron" type="test:validate-with-schematron">
		<p:documentation>Extends the standard p:validate-with-schematron step by adding the result handling to return the passed result or the failed test report.</p:documentation>
		<p:input port="source" primary="true"/>
		<p:input port="parameters" kind="parameter"/>
		<p:input port="schema"/>
		<p:output port="result" primary="true"/>
		<p:output port="report" sequence="true"/>
		<p:option name="phase" select="'#ALL'"/>                      <!-- string -->
		<p:option name="assert-valid" select="'true'"/>  
		
		<p:validate-with-schematron name="validate">
			<p:input port="schema">
				<p:pipe port="schema" step="validate-with-schematron"/>
			</p:input>
			<p:input port="parameters">
				<p:pipe port="parameters" step="validate-with-schematron"/>
			</p:input>
			<p:with-option name="phase" select="$phase"/>
			<p:with-option name="assert-valid" select="$assert-valid"/>
		</p:validate-with-schematron>
		
		<test:result>
			<p:input port="test">
				<p:pipe port="source" step="validate-with-schematron"/>
			</p:input>
			<p:input port="report">
				<p:pipe port="report" step="validate"/>
			</p:input>
		</test:result>
	</p:declare-step>
	
	
	<p:declare-step name="result" type="test:result">
		<p:documentation>Returns the SVRL report if the test fails or the test result if the test is successful.</p:documentation>
		<p:input port="source" primary="true"/>
		<p:input port="test" primary="false"/>
		<p:input port="report" primary="false"/>
		<p:output port="result"/>
		
		<p:sink/>
	
		<p:choose>
			<p:xpath-context>
				<p:pipe port="report" step="result"/>
			</p:xpath-context>
			<p:when test="exists(/svrl:schematron-output/svrl:failed-assert)">
				<p:identity>
					<p:input port="source">
						<p:pipe port="report" step="result"/>
					</p:input>
				</p:identity>
			</p:when>
			<p:otherwise>
				<p:identity>
					<p:input port="source">
						<p:pipe port="test" step="result"/>
					</p:input>
				</p:identity>
			</p:otherwise>
		</p:choose>
	</p:declare-step>
</p:library>