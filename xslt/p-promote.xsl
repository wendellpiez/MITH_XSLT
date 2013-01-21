<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="#all">

<!-- Paragraph promotion from milestone[@unit='tei:p']
-->

  <xsl:template match="div[@type='chapter']">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="@*"/>
      <xsl:copy-of select="head"/>
      <xsl:apply-templates select="." mode="p-promote"/>
    </xsl:copy>
  </xsl:template>

  <xsl:key name="element-by-generated-id" match="*" use="generate-id()"/>
  
  <xsl:template mode="p-promote" match="node()">
    <xsl:variable name="here" select="."/>
    <!-- grouping all the leaf nodes into sets representing paragraphs -->
    <xsl:for-each-group select="descendant::node()[empty(node())]"
      group-starting-with="milestone[@unit='tei:p']">
      <p>
        <xsl:call-template name="build">
          <xsl:with-param name="from" select="$here" tunnel="yes"/>
        </xsl:call-template>
      </p>
    </xsl:for-each-group>
  </xsl:template>
  
  <xsl:template name="build">
    <xsl:param name="to-copy" select="current-group()"/>
    <xsl:param name="level" select="1" as="xs:integer"/>
    <xsl:param name="from" select="." tunnel="yes"/>
    <xsl:for-each-group select="current-group()"
      group-adjacent="generate-id((ancestor::* except $from/ancestor-or-self::*)[$level])">
      <xsl:variable name="copying" select="key('element-by-generated-id',current-grouping-key())"/>
      <xsl:sequence select="current-group()[empty($copying)]"/>
      <xsl:for-each select="$copying">
        <xsl:copy>
          <xsl:copy-of select="@* except @xml:id"/>
          <!--<xsl:choose>
            <xsl:when
              test="$copying/descendant::node()[empty(node())][1] &lt;&lt; current-group()[1]">
              <!-\- if the element we are copying has content preceding the current group, we
                map @xml:id to @sameAs and annotate its @rend -\->
              <xsl:attribute name="rend"
                select="string-join((@rend,'continued'),' ')"/>
              <xsl:for-each select="@xml:id">
                <xsl:attribute name="sameAs" select="string-join((../@sameAs,concat('#',.)),' ')"/>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:copy-of select="@xml:id"/>
            </xsl:otherwise>
          </xsl:choose>-->
          <xsl:call-template name="build">
            <xsl:with-param name="level" select="$level + 1"/>
          </xsl:call-template>
        </xsl:copy>
      </xsl:for-each>
    </xsl:for-each-group>
  </xsl:template>
  
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>