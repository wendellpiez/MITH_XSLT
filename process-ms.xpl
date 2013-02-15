<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:mith="http://mith.umd.edu/sga/ns/xproc"
  name="TEI-GEtoLite" type="mith:TEI-GEtoLite">
  
  <p:input port="source"/>
  
  <p:input port="parameters" kind="parameter"/>
  
  <p:output primary="false" port="step1">
    <p:pipe port="result" step="expand-chapters"/>
  </p:output>
  <p:output primary="false" port="step2">
    <p:pipe port="result" step="ws-cleanup"/>
  </p:output>
  <p:output primary="false" port="step3">
    <p:pipe port="result" step="text-emend"/>
  </p:output>
  <p:output primary="false" port="step4">
    <p:pipe port="result" step="flatten-surfaces"/>
  </p:output>
  <p:output primary="false" port="step5">
    <p:pipe port="result" step="p-promote"/>
  </p:output>
  <p:output primary="true" port="final">
    <p:pipe port="result" step="final-cleanup"/>
  </p:output>
  
  <p:option name="file-path" select="'../ms-pages'"/>
  
  <!-- Pull surface contents into div[@type='chapter'] based on
       ptr references -->
  <p:xslt name="expand-chapters">
    <p:input port="stylesheet">
      <p:document href="xslt/expand-chapters.xsl"/>
    </p:input>
    <p:with-param name="file-path" select="$file-path"/>
  </p:xslt>

  <!-- Whitespace cleanup -->
  <p:xslt name="ws-cleanup">
    <p:input port="stylesheet">
      <p:document href="xslt/ws-cleanup.xsl"/>
    </p:input>
  </p:xslt>
  
  <!-- Process additions and deletions -->
  <!-- Test this by generating two result files: running up to this step, and running through it; then diff them. -->
  <p:xslt name="text-emend">
    <p:input port="stylesheet">
      <!-- Current code in text-emend.xsl is rough and provisional -->
      <p:document href="xslt/text-emend.xsl"/>
    </p:input>
  </p:xslt>
  
  <!-- Flatten surfaces, inserting pb and keeping (only) contents of zone[@type='main'] -->
  <p:xslt name="flatten-surfaces">
    <p:input port="stylesheet">
      <p:document href="xslt/flatten-surfaces.xsl"/>
    </p:input>
  </p:xslt>
  
  <!-- Promote paragraphs -->
  <p:xslt name="p-promote">
    <p:input port="stylesheet">
      <p:document href="xslt/p-promote.xsl"/>
    </p:input>
  </p:xslt>
  
  <!-- Cleanup -->
  <p:xslt name="final-cleanup">
    <p:input port="stylesheet">
      <!-- To do: add any plumbing to final result
           (serialization options, schema pointers etc.) -->
      <p:document href="xslt/final-cleanup.xsl"/>
    </p:input>
  </p:xslt>
  
  <!--<p:identity/>-->
  
  
</p:declare-step>