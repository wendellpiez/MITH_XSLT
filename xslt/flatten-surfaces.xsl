<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">

  <!-- Flattens surfaces, inserting pb and removing superstructures
     (only the contents of the main zones are included) -->

  <xsl:template match="node() | @*">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="surface">
    <pb>
      <xsl:comment>
      <xsl:text> Starting surface[@xml:id=' </xsl:text>
      <xsl:value-of select="@xml:id"/>
      <xsl:text>']</xsl:text>
    </xsl:comment>
    </pb>
    <xsl:apply-templates select="zone[@type='main']"/>
  </xsl:template>

  <xsl:template match="zone">
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
