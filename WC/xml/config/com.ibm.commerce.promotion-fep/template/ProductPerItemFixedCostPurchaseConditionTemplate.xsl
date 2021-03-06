<?xml version="1.0" encoding="UTF-8"?>

<!--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- handles purchase condition -->
	<xsl:template name="PurchaseConditionTemplate" match="/">
		<PurchaseCondition impl="com.ibm.commerce.marketing.promotion.condition.PurchaseCondition">
			<Pattern impl="com.ibm.commerce.marketing.promotion.condition.Pattern">
				<Constraint impl="com.ibm.commerce.marketing.promotion.condition.Constraint">
					<WeightedRange impl="com.ibm.commerce.marketing.promotion.condition.WeightedRange">
						<LowerBound>1</LowerBound>
						<UpperBound>1</UpperBound>
						<Weight>1</Weight>
					</WeightedRange>
					<FilterChain impl="com.ibm.commerce.marketing.promotion.condition.FilterChain">
						<Filter impl="com.ibm.commerce.marketing.promotion.condition.MultiSKUFilter">
							<xsl:for-each select="PromotionData/Elements/PurchaseCondition/IncludeCatalogEntryIdentifier">
								<IncludeCatEntryKey>
									<xsl:call-template name="CatalogEntryKeyTemplate">
										<xsl:with-param name="dn" select="Data/DN" />
										<xsl:with-param name="sku" select="Data/SKU" />
									</xsl:call-template>
								</IncludeCatEntryKey>
							</xsl:for-each>
							<xsl:for-each select="PromotionData/Elements/PurchaseCondition/ExcludeCatalogEntryIdentifier">
								<ExcludeCatEntryKey>
									<xsl:call-template name="CatalogEntryKeyTemplate">
										<xsl:with-param name="dn" select="Data/DN" />
										<xsl:with-param name="sku" select="Data/SKU" />
									</xsl:call-template>
								</ExcludeCatEntryKey>
							</xsl:for-each>
						</Filter>
						<xsl:choose>
							<xsl:when test="PromotionData/Elements/PurchaseCondition/CatalogEntryAttributeRule">
							<!-- Only populate when there are attributes -->
								<Filter
									impl="com.ibm.commerce.marketing.promotion.condition.CatalogEntryAttributeFilter">
									<AssociatedLanguage><xsl:value-of select="PromotionData/Elements/PurchaseCondition/Data/Language" /></AssociatedLanguage>
									<xsl:choose>
										<xsl:when test="PromotionData/Elements/PurchaseCondition/Data/CatalogEntryAttributeRuleCaseSensitive">
											<CaseSensitive><xsl:value-of select="PromotionData/Elements/PurchaseCondition/Data/CatalogEntryAttributeRuleCaseSensitive" /></CaseSensitive>
										</xsl:when>
										<xsl:otherwise>
											<CaseSensitive>false</CaseSensitive>
										</xsl:otherwise> 
									</xsl:choose>
									<SupportAttributeWithNoAssociatedLanguage>true</SupportAttributeWithNoAssociatedLanguage>
									<xsl:for-each select="PromotionData/Elements/PurchaseCondition/CatalogEntryAttributeRule">
										<xsl:call-template name="CatalogEntryAttributeRuleTemplate">
											<xsl:with-param name="attributeRule" select="." />
										</xsl:call-template>	
									</xsl:for-each>					
								</Filter>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="PromotionData/Elements/PurchaseCondition/IncludePaymentTypeIdentifier">
								<xsl:choose>
									<xsl:when test="PromotionData/Elements/PurchaseCondition/IncludePaymentTypeIdentifier/Data/PaymentType != 'Any'">
										<Filter impl="com.ibm.commerce.marketing.promotion.condition.PaymentTypeFilter">
											<IncludePaymentType>
												<PaymentMethodName><xsl:value-of select="PromotionData/Elements/PurchaseCondition/IncludePaymentTypeIdentifier/Data/PaymentType" /></PaymentMethodName>
											</IncludePaymentType>
										</Filter>
									</xsl:when>
								</xsl:choose>						
							</xsl:when>
						</xsl:choose>	
						<Filter impl="com.ibm.commerce.marketing.promotion.condition.ItemSortingFilter">
							<SortingMethod>PriceLowToHigh</SortingMethod>        	
						</Filter>													
					</FilterChain>
				</Constraint>
			</Pattern>
			<Distribution impl="com.ibm.commerce.marketing.promotion.reward.PatternQuantityVolumeDistribution">
				<xsl:for-each select="PromotionData/Elements/PurchaseCondition/DiscountRange">
					<xsl:choose>
						<xsl:when test="position()=last()">
							<xsl:call-template name="DistributionRangeTemplate">
								<xsl:with-param name="lowerBound" select="Data/LowerBound" />
								<xsl:with-param name="upperBound">-1</xsl:with-param>
								<xsl:with-param name="fixedPrice" select="Data/FixedPrice" />
								<xsl:with-param name="currency" select="parent::*/Data/Currency" />
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="DistributionRangeTemplate">
								<xsl:with-param name="lowerBound" select="Data/LowerBound" />
								<xsl:with-param name="upperBound" select="following-sibling::*/Data/LowerBound" />
								<xsl:with-param name="fixedPrice" select="Data/FixedPrice" />
								<xsl:with-param name="currency" select="parent::*/Data/Currency" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<PatternFilter impl="com.ibm.commerce.marketing.promotion.condition.DummyPatternFilter"></PatternFilter>
			</Distribution>
		</PurchaseCondition>
	</xsl:template>
	<!-- handles DistributionRange -->
	<xsl:template name="DistributionRangeTemplate">
		<xsl:param name="lowerBound">0</xsl:param>
		<xsl:param name="upperBound">-1</xsl:param>
		<xsl:param name="fixedPrice" />
		<xsl:param name="currency" />
		<Range impl="com.ibm.commerce.marketing.promotion.reward.DistributionRange">
			<LowerBound><xsl:value-of select="$lowerBound" /></LowerBound>
			<UpperBound><xsl:value-of select="$upperBound" /></UpperBound>
			<LowerBoundIncluded>true</LowerBoundIncluded>
			<UpperBoundIncluded>false</UpperBoundIncluded>
			<RewardChoice>
				<Reward impl="com.ibm.commerce.marketing.promotion.reward.DefaultReward">
					<AdjustmentFunction impl="com.ibm.commerce.marketing.promotion.reward.AdjustmentFunction">
						<FilterChain impl="com.ibm.commerce.marketing.promotion.condition.FilterChain">
							<Filter impl="com.ibm.commerce.marketing.promotion.condition.DummyFilter"></Filter>
						</FilterChain>
						<Adjustment impl="com.ibm.commerce.marketing.promotion.reward.FixedCostAdjustment">
							<Currency><xsl:value-of select="$currency" /></Currency>
							<FixedCost><xsl:value-of select="$fixedPrice" /></FixedCost>
							<AdjustmentType>IndividualAffectedItems</AdjustmentType>
							<AdjustmentComparison>1</AdjustmentComparison>
						</Adjustment>
					</AdjustmentFunction>
				</Reward>
			</RewardChoice>
		</Range>
	</xsl:template>
	<!-- handles CatalogEntryKey -->
	<xsl:template name="CatalogEntryKeyTemplate">
		<xsl:param name="dn" />
		<xsl:param name="sku" />
		<CatalogEntryKey>
			<DN><xsl:value-of select="$dn" /></DN>
			<SKU><xsl:value-of select="$sku" /></SKU>
		</CatalogEntryKey>
	</xsl:template>
	<!-- handles CatalogEntryAttributeRule  -->
	<xsl:template name="CatalogEntryAttributeRuleTemplate">
		<xsl:param name="attributeRule" />
		<AttributeRule>
			<Name><xsl:value-of select="Data/Name" /></Name>
			<DataType><xsl:value-of select="Data/DataType" /></DataType>
			<MatchingType><xsl:value-of select="Data/MatchingType" /></MatchingType>
			<xsl:for-each select="Data/Value">
				<Value><xsl:value-of select="." /></Value>
			</xsl:for-each>
		</AttributeRule>
	</xsl:template>			
</xsl:transform>
