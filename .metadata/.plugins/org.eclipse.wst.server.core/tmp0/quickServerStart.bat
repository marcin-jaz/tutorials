@REM C:\IBM\WCDE_ENT70\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\quickServerStart.bat
@REM Generated: Tue Sep 04 14:20:05 CEST 2018

@setlocal
@echo off

@REM Bootstrap values ...
cd C:\IBM\WCDE_E~1\wasprofile\bin
call "C:\IBM\WCDE_E~1\wasprofile\bin\setupCmdLine.bat"
@REM For debugging the server process:
@REM set DEBUG=-Djava.compiler=NONE -Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=7777

@REM Environment Settings
SET PATH=%WAS_PATH%


@REM Launch Command
"C:\IBM\SDP\runtimes\base_v7/java/bin/java"  %DEBUG% "-Declipse.security" "-Dosgi.install.area=C:\IBM\SDP\runtimes\base_v7" "-Dosgi.configuration.area=C:\IBM\WCDE_E~1\wasprofile/configuration" "-Dosgi.framework.extensions=com.ibm.cds,com.ibm.ws.eclipse.adaptors" "-Xshareclasses:name=webspherev70,nonFatal" "-Dsun.reflect.inflationThreshold=250" "-Dcom.ibm.xtq.processor.overrideSecureProcessing=true" "-Dwas.debug.mode=true" "-Dcom.ibm.ws.classloader.j9enabled=true" "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=7777" "-Xbootclasspath/p:C:\IBM\SDP\runtimes\base_v7/lib/dertrjrt.jar;C:\IBM\SDP\runtimes\base_v7/java/jre/lib/ext/ibmorb.jar;C:\IBM\SDP\runtimes\base_v7/java/jre/lib/ext/ibmext.jar" "-classpath" "C:\IBM\WCDE_E~1\wasprofile/properties;C:\IBM\SDP\runtimes\base_v7/properties;C:\IBM\SDP\runtimes\base_v7/lib/startup.jar;C:\IBM\SDP\runtimes\base_v7/lib/bootstrap.jar;C:\IBM\SDP\runtimes\base_v7/lib/jsf-nls.jar;C:\IBM\SDP\runtimes\base_v7/lib/lmproxy.jar;C:\IBM\SDP\runtimes\base_v7/lib/urlprotocols.jar;C:\IBM\SDP\runtimes\base_v7/deploytool/itp/batchboot.jar;C:\IBM\SDP\runtimes\base_v7/deploytool/itp/batch2.jar;C:\IBM\SDP\runtimes\base_v7/java/lib/tools.jar" "-Dibm.websphere.internalClassAccessMode=allow" "-Xms1024m" "-Xmx1536m" "-Xquickstart" "-Xverify:none" "-Dws.ext.dirs=C:\IBM\SDP\runtimes\base_v7/java/lib;C:\IBM\WCDE_E~1\wasprofile/classes;C:\IBM\SDP\runtimes\base_v7/classes;C:\IBM\SDP\runtimes\base_v7/lib;C:\IBM\SDP\runtimes\base_v7/installedChannels;C:\IBM\SDP\runtimes\base_v7/lib/ext;C:\IBM\SDP\runtimes\base_v7/web/help;C:\IBM\SDP\runtimes\base_v7/deploytool/itp/plugins/com.ibm.etools.ejbdeploy/runtime" "-Dderby.system.home=C:\IBM\SDP\runtimes\base_v7/derby" "-Dcom.ibm.itp.location=C:\IBM\SDP\runtimes\base_v7/bin" "-Djava.util.logging.configureByServer=true" "-Duser.install.root=C:\IBM\WCDE_E~1\wasprofile" "-Djavax.management.builder.initial=com.ibm.ws.management.PlatformMBeanServerBuilder" "-Dwas.install.root=C:\IBM\SDP\runtimes\base_v7" "-Dpython.cachedir=C:\IBM\WCDE_E~1\wasprofile/temp/cachedir" "-Djava.util.logging.manager=com.ibm.ws.bootstrap.WsLogManager" "-Dserver.root=C:\IBM\WCDE_E~1\wasprofile" "-Dcom.ibm.security.jgss.debug=off" "-Dcom.ibm.security.krb5.Krb5Debug=off" "-Dcom.ibm.wca.logging.configFile=C:/IBM/WCDE_E~1/xml/loader/WCALoggerConfig.xml" "-Dcom.ibm.websphere.ejbcontainer.FbpkAlwaysReadOnly=true" "-Dcom.ibm.commerce.dynacache.decrypt=false" "-Dcom.ibm.servlet.file.esi.timeOut=0" "-Dcom.ibm.ws.cache.CacheConfig.filterLRUInvalidation=true" "-Dcom.ibm.ws.cache.CacheConfig.filterTimeOutInvalidation=true" "-Dcom.ibm.ws.cache.CacheConfig.cascadeCachespecProperties=true" "-Dcom.ibm.ws.cache.CacheConfig.disableTemplateInvalidation=true" "-Dcom.ibm.ws.cache.CacheConfig.disableStoreCookies=ALL" "-Dcom.ibm.ws.cache.CacheConfig.alwaysTriggerCommandInvalidations=true" "-Dcom.ibm.ws.use602RequiredAttrCompatibility=true" "-Dcom.ibm.ws.management.event.pull_notification_timeout=120000" "-Dsolr.solr.home=C:/IBM/WCDE_E~1/search/solr/home" "-Dsolr.allow.unsafe.resourceloading=true" "-Xquickstart" "-Xgcpolicy:gencon" "-Xscmx196m" "-Djava.security.auth.login.config=C:\IBM\WCDE_E~1\wasprofile/properties/wsjaas.conf" "-Djava.security.policy=C:\IBM\WCDE_E~1\wasprofile/properties/server.policy" "com.ibm.wsspi.bootstrap.WSPreLauncher" "-nosplash" "-application" "com.ibm.ws.bootstrap.WSLauncher" "com.ibm.ws.runtime.WsServer" "C:\IBM\WCDE_E~1\wasprofile\config" "localhost" "localhost" "server1"

@endlocal
