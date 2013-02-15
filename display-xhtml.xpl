<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:mith="http://mith.umd.edu/sga/ns/xproc"
  name="TEI-GE-reading" type="mith:TEI-GE-reading">


  <p:input port="source"/>
  
  <p:input port="parameters" kind="parameter"/>
  
  <p:serialization port="html" method="xhtml"
    omit-xml-declaration="true" indent="false"/>
  
  <p:output primary="true" port="html">
    <p:pipe port="result" step="toHTML"/>
  </p:output>
  
  
  <p:import href="process-ms.xpl"/>
  
  <mith:TEI-GEtoLite name="GEtoLite"/>
 
  <!-- to HTML -->
  <p:xslt name="toHTML">
    <p:input port="stylesheet">
      <p:document href="xslt/toHTML.xsl"/>
    </p:input>
  </p:xslt>
  
</p:declare-step>
