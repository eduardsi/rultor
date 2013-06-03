<?xml version="1.0"?>
<!--
 * Copyright (c) 2009-2013, fazend.com
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met: 1) Redistributions of source code must retain the above
 * copyright notice, this list of conditions and the following
 * disclaimer. 2) Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided
 * with the distribution. 3) Neither the name of the fazend.com nor
 * the names of its contributors may be used to endorse or promote
 * products derived from this software without specific prior written
 * permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
 * NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" version="2.0" exclude-result-prefixes="xs">
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:apply-templates select="page"/>
    </xsl:template>
    <xsl:template match="page">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <meta name="description" content="Lightweight Integration Platform as a Service"/>
                <meta name="keywords" content="IPaaS, continuous integration, continuous delivery"/>
                <meta name="author" content="fazend.com"/>
                <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet"/>
                <link href="//netdna.bootstrapcdn.com/font-awesome/3.1.1/css/font-awesome.css" rel="stylesheet" />
                <link rel="stylesheet" type="text/css" media="all">
                    <xsl:attribute name="href">
                        <xsl:text>/css/screen.css?</xsl:text>
                        <xsl:value-of select="/page/version/revision"/>
                    </xsl:attribute>
                </link>
                <link rel="icon" type="image/gif">
                    <xsl:attribute name="href">
                        <xsl:text>http://img.fazend.com/favicon.ico?</xsl:text>
                        <xsl:value-of select="/page/version/revision"/>
                    </xsl:attribute>
                </link>
                <xsl:call-template name="head"/>
                <script type="text/javascript"><![CDATA[
                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', 'UA-1963507-10']);
                _gaq.push(['_trackPageview']);
                (function() {
                    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                })();
                ]]></script>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            </head>
            <body>
                <xsl:apply-templates select="version"/>
                <div class="container-fluid">
                    <xsl:apply-templates select="flash"/>
                    <xsl:choose>
                        <xsl:when test="/page/identity">
                            <xsl:apply-templates select="identity"/>
                            <xsl:call-template name="content"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="login"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:call-template name="bottom"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="millis">
        <xsl:param name="millis" as="xs:integer"/>
        <xsl:choose>
            <xsl:when test="$millis &gt; 1000">
                <xsl:value-of select="format-number($millis div 1000, '0.0')"/>
                <xsl:text>s</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="format-number($millis, '#')"/>
                <xsl:text>ms</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="version">
        <div id="version">
            <xsl:value-of select="name"/>
            <xsl:text> </xsl:text>
            <a title="see commit in Github">
                <xsl:attribute name="href">
                    <xsl:text>https://github.com/yegor256/bibrarian/commit/</xsl:text>
                    <xsl:value-of select="revision"/>
                </xsl:attribute>
                <i class="icon-github"><xsl:comment>github icon</xsl:comment></i>
            </a>
            <xsl:text> </xsl:text>
            <xsl:value-of select="revision"/>
            <xsl:text> </xsl:text>
            <xsl:call-template name="millis">
                <xsl:with-param name="millis" select="/page/millis"/>
            </xsl:call-template>
        </div>
    </xsl:template>
    <xsl:template match="flash">
        <div>
            <xsl:attribute name="class">
                <xsl:text>alert </xsl:text>
                <xsl:choose>
                    <xsl:when test="level = 'INFO'">
                        <xsl:text>alert-success</xsl:text>
                    </xsl:when>
                    <xsl:when test="level = 'WARNING'">
                        <xsl:text>alert-info</xsl:text>
                    </xsl:when>
                    <xsl:when test="level = 'ERROR'">
                        <xsl:text>alert-error</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="message"/>
        </div>
    </xsl:template>
    <xsl:template match="identity">
        <p>
            <img style="width: 25px; height: 25px;">
                <xsl:attribute name="src">
                    <xsl:value-of select="photo"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:value-of select="name"/>
                </xsl:attribute>
            </img>
            <xsl:text> </xsl:text>
            <xsl:value-of select="name"/>
            <img style="margin-left: 0.5em;" alt="account type">
                <xsl:attribute name="src">
                    <xsl:text>http://img.fazend.com/icons/</xsl:text>
                    <xsl:choose>
                        <xsl:when test="starts-with(urn, 'urn:facebook:')">
                            <xsl:text>facebook</xsl:text>
                        </xsl:when>
                        <xsl:when test="starts-with(urn, 'urn:google:')">
                            <xsl:text>google</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:text>-small.png</xsl:text>
                </xsl:attribute>
            </img>
            <xsl:text> </xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="/page/links/link[@rel='auth-logout']/@href"/>
                </xsl:attribute>
                <xsl:text>logout</xsl:text>
            </a>
        </p>
    </xsl:template>
    <xsl:template name="login">
        <p>
            <xsl:text>To start, login using one of your accounts at: </xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="/page/links/link[@rel='auth-facebook']/@href"/>
                </xsl:attribute>
                <i class="icon-facebook-sign icon-2x"><xsl:comment>facebook sign</xsl:comment></i>
            </a>
            <xsl:text> </xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="/page/links/link[@rel='auth-google']/@href"/>
                </xsl:attribute>
                <i class="icon-google-plus-sign icon-2x"><xsl:comment>google plus sign</xsl:comment></i>
            </a>
        </p>
    </xsl:template>
    <xsl:template name="bottom">
        <div id="bottom">
            <xsl:text>fazend.com is an open source project, hosted at </xsl:text>
            <a href="https://github.com/yegor256/fazend">
                <xsl:text>github</xsl:text>
            </a>
            <xsl:text>. The service is absolutely free of charge, since it is sponsored by </xsl:text>
            <a href="http://www.tpc2.com/">
                <xsl:text>tpc2.com</xsl:text>
            </a>
            <xsl:text>. See also terms of use, privacy policy and license agreement at </xsl:text>
            <a href="/misc/LICENSE.txt">
                <xsl:text>LICENSE.txt</xsl:text>
            </a>
            <xsl:text>.</xsl:text>
            <xsl:text> This website is using </xsl:text>
            <a href="http://www.rexsl.com/">
                <xsl:text>ReXSL</xsl:text>
            </a>
            <xsl:text>, Java RESTful development framework.</xsl:text>
        </div>
    </xsl:template>
</xsl:stylesheet>
