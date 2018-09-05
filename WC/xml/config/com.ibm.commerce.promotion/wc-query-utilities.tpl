<!--********************************************************************-->
<!--  Licensed Materials - Property of IBM                              -->
<!--                                                                    -->
<!--  WebSphere Commerce                                                -->
<!--                                                                    -->
<!--  (c) Copyright IBM Corp. 2013                                      -->
<!--                                                                    -->
<!--  US Government Users Restricted Rights - Use, duplication or       -->
<!--  disclosure restricted by GSA ADP Schedule Contract with IBM Corp. -->
<!--                                                                    -->
<!--********************************************************************-->
BEGIN_SYMBOL_DEFINITIONS

END_SYMBOL_DEFINITIONS

<!--==============================================================================-->
<!--  Get the promotion ID for a particular promotion.                            -->
<!--  @param PromotionName The administrative name of the promotion               -->
<!--==============================================================================-->
BEGIN_SQL_STATEMENT
  base_table=PX_PROMOAUTH
	name=IBM_Select_PromotionIdByAdministrativeName
	sql=SELECT PX_PROMOAUTH.PX_PROMOTION_ID FROM PX_PROMOAUTH, PX_PROMOTION 
	    WHERE PX_PROMOAUTH.ADMINSTVENAME  = ?PromotionName?
	    AND PX_PROMOAUTH.PX_PROMOTION_ID = PX_PROMOTION.PX_PROMOTION_ID
	    AND PX_PROMOTION.STOREENT_ID IN ($STOREPATH:promotions$)
	    AND PX_PROMOTION.STATUS IN (0,1,3)
END_SQL_STATEMENT      
