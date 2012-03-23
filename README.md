#Graph Store and SPARQL Protocol (grasp)

The name grasp comes from combing **GRA**ph **S**tore **P**rotocol plus **A**nd **S**parql **P**rotocol 
but also implies that you use the XQuery and XProc libraries here-in to get a 
hold of (grasp) RDF Graphs from a triple store and/or results from running 
SPARQL queries againts a Graph Store.

The libraries provide means of managing and querying Graph Stores using the 
W3C's Graph Store HTTP and SPARQL protocols respectively.

* http://www.w3.org/TR/sparql11-http-rdf-update/
* http://www.w3.org/TR/sparql11-protocol/

Both these specifications are currently (2012-01-11) working drafts so are 
liable to change.


There are two XQuery library modules:

* `src/main/xquery/lib-gsp.xqy` - Graph Store Protocol 
* `src/main/xquery/lib-spq.xqy` - SPARQL Protocol

that both have a dependency upon:

`src/main/xquery/lib-ml.xqy` - MarkLogic specific utility functions.


There is also the XProc library that defines a set of pipeline steps for 
managing a Graph Store using that implements the Graph Store Protocol.

`src/main/xproc/lib-gsp.xpl`


All the libraries support accessing the defaul graph in the Graph Store and 
have been tested against Jena's Fuseki SPARQL server.

http://openjena.org/wiki/Fuseki


There are a series of tests in:

* `src/test/xproc/gsp`
* `src/test/xquery/gsp`
* `src/test/xquery/spq`

which I tend to run manually, or as a group, in the oXygen XML IDE. For the 
XQuery tests you'll need to set-up a XDBC server who's 'root' points to the 
'src' directory of your working copy of this repository. These test will give 
you some examples of how to use the libraries.


All comments observations and criticisms welcome.

Errors and ommissions excepted.