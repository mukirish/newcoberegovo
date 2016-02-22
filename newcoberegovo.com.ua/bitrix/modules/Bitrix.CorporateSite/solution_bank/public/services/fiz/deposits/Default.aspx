<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Банковские вклады и депозиты частным лицам" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bxcontent" runat="server" > 
 									 	
<p>В нашем Банке вы можете самостоятельно выбрать выгодные условия вкладов для размещения денежных средств:</p>
 	
<ul> 		
  <li>Определяйте проценты по вкладам и срок вклада в зависимости от суммы вклада.</li>
 		
  <li>Положите деньги на пополняемые вклады и депозиты, и снимайте денежные средства в любое удобное время.</li>
 		
  <li>Снимайте часть денег в любой момент.</li>
 		
  <li>Увеличивайте вклад, прибавляя проценты к сберегаемой сумме.</li>
 	</ul>
 	 	
<p>В <b>&laquo;Банке&raquo;</b> вы можете открыть процентные вклады и депозиты в рублях и валюте, а также воспользоваться дополнительными услугами, которые позволят вам с удобством распоряжаться деньгами и экономить время.</p>
 	 	
<h2>Банковские вклады</h2>
 	 	
<p>Для Вас предлагаются накопительные вклады под высокий процент для физических лиц и выгодные процентные депозиты. Выберите доходные краткосрочные вклады на год или на длительный период, валютные и рублевые депозиты.</p>
 <bx:IncludeComponent 
	 id="IncludeComponent1" 
	 runat="server" 
	 componentname="bitrix:catalogue.element.list" 
	 template="deposits" 
	 IBlockTypeId="" 
	 IBlockId="<%$ Options:Bitrix.BankSite:DepositsIblockId,int %>" 
	 SectionId="" 
	 SectionCode="" 
	 FilterByElementCustomProperty="False" 
	 ElementCustomPropertyFilterSettings="p:o:0:{};" 
	 SortBy="ID" 
	 SortOrder="Desc" 
	 ShowSubElements="True" 
	 ShowAllElementsOnIndex="True" 
	 ActiveFilter="Active" 
	 ActiveDateFilter="All" 
	 Properties="RATE;FILL;MINSUM;PERCENTCALC;FOREIGNCUR" 
	 AddAdminPanelButtons="False" 
	 SetPageTitle="False" 
	 SectionElementListUrl="list.aspx?section_id=#SECTION_ID#" 
	 ElementDetailUrl="<%$ Options:Bitrix.BankSite:DepositsDetailUrl%>" 
	 PagingAllow="True" 
	 PagingMode="direct" 
	 PagingTemplate="catalog" 
	 PagingShowOne="False" 
	 PagingAllowAll="False" 
	 PagingRecordsPerPage="10" 
	 PagingTitle="Страницы" 
	 PagingPosition="both" 
	 PagingMaxPages="10" 
	 PagingMinRecordsInverse="1" 
	 PagingPageID="<%$ Request:page %>" 
	 PagingShowAll="<%$ Request:showall %>" 
	 PagingIndexTemplate="" 
	 PagingPageTemplate="?page=#pageid#" 
	 PagingShowAllTemplate="?showall=y" 
	 CacheMode="None" 
	 CacheDuration="30" 
 />
 	
<h2>Дополнительные услуги</h2>
 	 	
<table class="data-table" cellspacing="0"> 
	<tr>
		<th valign="top">Услуга</td> 
		<th valign="top">Описание</td>
	</tr>
	<tr class="alt-row">
		<td valign="top">«Депозитный Тайм-Аут»
		</td>
		<td valign="top">
			Частичное снятие суммы денежного депозитного вклада на срок до 14 дней, с возможностью
			восстановления вклада и сохранения всех начисленных ранее процентов.
		</td>
	</tr>
	<tr>
		<td valign="top">
			Аренда сейфовых ячеек
		</td>
		<td valign="top">
			Скидка предоставляется всем вкладчикам: 10% в дополнительных офисах Москвы и 30%
			в филиалах Банка.
		</td>
	</tr>
	<tr class="alt-row">
		<td valign="top">
			Доходная карта
		</td>
		<td valign="top">
			Карта VISA Classic или MasterCard Standard с ежемесячным начислением процентов (5%
			годовых по рублям, 3,5% годовых по валюте) на среднемесячный остаток. Комиссия за
			годовое обслуживание карты составляет 30 долларов США/20 евро/750 рублей для основной
			карты и 20 долларов США/15 евро/550 рублей для дополнительной карты.
		</td>
	</tr>
	<tr>
		<td valign="top">
			Будь в курсе
		</td>
		<td valign="top">
			Интернет-сервис с возможностью получения информационных услуг и проведения операций
			по вкладам и депозитным счетам, открытым в Банке, через Интернет.
		</td>
	</tr>
	<tr class="alt-row">
		<td valign="top">
			Надежный Депозит
		</td>
		<td valign="top">
			Страхование вкладов.
		</td>
	</tr>
</table> 
 
<p> Банк гарантирует Клиенту возврат вклада и выплату процентов. Все вклады «Банка» застрахованы в порядке, размерах и на условиях, которые установлены Федеральным законом «О страховании вкладов физических лиц в банках Российской Федерации».</p> 
<p>Для консультации по вкладам, пожалуйста, обратитесь в круглосуточную службу поддержки клиентов по телефонам:<b> (495) 777-5-888 </b>или <b>8-800-200-9-008</b> (звонок по России бесплатный). </p> 
 </asp:Content>
