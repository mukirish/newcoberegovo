<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main"        Title="Наші контакти" %>
<script runat="server" id="@__bx_pagekeywords">
	public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
	{
		keywords[@"keywords"]=@"";
		keywords[@"description"]=@"";
	}
</script>



<asp:Content runat="server" ContentPlaceHolderID="bxcontent" > 
<div class="newCo_h1"> 
  <h1>контакти</h1>
 <img src="/bitrix/templates/newco_first/img/cont_img.png"  /> </div>
 
<div class="clear"></div>
 
<div class="shadow"></div>
 
<div class="maps_top"> 
  <div class="contacts1 first_c"><img src="/bitrix/templates/newco_first/img/adr.png"  /> 
    <p>Юридічна адреса - Україна, 90202 Берегове, Сільвая 1</p>
   
    <p>Фактична адреса - Україна, 90202 Берегове, Сечені 76</p>
   </div>
 
  <div class="contacts1 con2"> 
    <p><img src="/bitrix/templates/newco_first/img/tele.png"  /> +380 3141 42643</p>
   
    <p><img id="bxid_750881" src="http://nyunt02.nyuko.ua/bitrix/templates/newco_first/img/tele.png"  />+380 66 7193475</p>
   
    <p><img id="bxid_291372" src="http://nyunt02.nyuko.ua/bitrix/templates/newco_first/img/tele.png"  />+380 98 9900041</p>
   
    <p><img src="/bitrix/templates/newco_first/img/mail2.png"  /><a href="mailto:newco@newcoberegovo.com.ua" >newco@newcoberegovo.com.ua</a></p>
   
    <p><img src="/bitrix/templates/newco_first/img/skype.png"  />newcoberegovoLLC</p>
   </div>
 
  <div class="contacts1 last_c"> <img src="/bitrix/templates/newco_first/img/time2.png"  />ПН-ПТ з 8:00 до 17:00 </div>

  <div class="contacts1 last_c"><img src="/bitrix/templates/newco_first/img/time2.png"  />Обід з 12:00 до 13:00</div>
 
  <div class="clear"></div>
 </div>
 <iframe width="980" height="350" src="https://maps.google.com.ua/maps?f=q&amp;source=s_q&amp;hl=ru&amp;geocode=&amp;q=%D0%91%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D0%B2%D0%BE,+%D0%97%D0%B0%D0%BA%D0%B0%D1%80%D0%BF%D0%B0%D1%82%D1%81%D0%BA%D0%B0%D1%8F+%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C&amp;aq=0&amp;oq=,thtujdj&amp;sll=48.235116,22.580286&amp;sspn=0.004352,0.010568&amp;ie=UTF8&amp;hq=&amp;hnear=%D0%91%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D0%B2%D0%BE,+%D0%97%D0%B0%D0%BA%D0%B0%D1%80%D0%BF%D0%B0%D1%82%D1%81%D0%BA%D0%B0%D1%8F+%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C&amp;t=m&amp;ll=48.30238,22.542572&amp;spn=0.319729,1.345825&amp;z=10&amp;output=embed" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe> 
<br />
 </asp:Content>