<%@ Page Language="C#" Inherits="Bitrix.UI.BXPublicPage, Main"          Title="Наші контакти" %>
<script runat="server" id="@__bx_pagekeywords">
	public override void SetPageKeywords(System.Collections.Generic.IDictionary<string, string> keywords)
	{
		keywords[@"keywords"]=@"";
		keywords[@"description"]=@"";
	}
</script>



<asp:Content runat="server" ContentPlaceHolderID="bxcontent" > 
<div class="wrap-content"> 
  <div class="container"> 
    <h3>Контакти <img src="/img/cont_img.png"  /></h3>
   
<!--Co-->
 
    <div class="page"> 
      <div class="contacts"> 
        <div class="col-xs-12 col-md-6 col-lg-4 address-1"> 
          <h5>Юридічна адреса: </h5>
         Україна, 90202 Берегове, Сільвая 1</div>
       
        <div class="col-xs-12 col-md-6 col-lg-4 address-1"> 
          <h5>Фактична адреса: </h5>
         Україна, 90202 Берегове, Сечені 76</div>
       
        <div class="col-xs-12 col-md-6 col-lg-4 address-2"> 
          <h5>Телефон: </h5>
         +380 3141 42643</div>
       
        <div class="col-xs-12 col-md-6 col-lg-4 address-2"> 
          <h5>Телефон (відділ кадрів): </h5>
         +380 66 7193475</div>
       
        <div class="col-xs-12 col-md-6 col-lg-4 address-2"> 
          <h5>Телефон (відділ кадрів): </h5>
         +380 98 9900041</div>
       
        <div class="col-xs-12 col-md-6 col-lg-4 address-3"> 
          <h5>Графік роботи: </h5>
         ПН-ПТ з 8:00 до 17:00</div>
       
        <div class="col-xs-12 col-md-6 col-lg-4 address-3"> 
          <h5>Обідня перерва: </h5>
         Обід з 12:00 до 13:00</div>
       
        <div class="col-xs-12 col-md-6 col-lg-4 address-4"> 
          <h5>E-mail: </h5>
         <a href="mailto:newco@newcoberegovo.com.ua" > newco@newcoberegovo.com.ua</a></div>
       </div>
     
      <div class="row" style="margin-top: 30px;"> 
        <div> <iframe class="map" frameborder="0" scrolling="no" marginheight="0" src="https://maps.google.com.ua/maps?f=q&amp;source=s_q&amp;hl=ru&amp;geocode=&amp;q=%D0%91%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D0%B2%D0%BE,+%D0%97%D0%B0%D0%BA%D0%B0%D1%80%D0%BF%D0%B0%D1%82%D1%81%D0%BA%D0%B0%D1%8F+%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C&amp;aq=0&amp;oq=,thtujdj&amp;sll=48.235116,22.580286&amp;sspn=0.004352,0.010568&amp;ie=UTF8&amp;hq=&amp;hnear=%D0%91%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D0%B2%D0%BE,+%D0%97%D0%B0%D0%BA%D0%B0%D1%80%D0%BF%D0%B0%D1%82%D1%81%D0%BA%D0%B0%D1%8F+%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C&amp;t=m&amp;ll=48.30238,22.542572&amp;spn=0.319729,1.345825&amp;z=10&amp;output=embed"></iframe> 
          <br />
         </div>
       </div>
     
      <div class="row"> 
        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3"> <img class="col-xs-10 col-xs-offset-1" src="/img/flags/Hungary.png"  /> 
          <p>Угорщина - 5 км</p>
         </div>
       
        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3"> <img class="col-xs-10 col-xs-offset-1" src="/img/flags/Slovakia.png"  /> 
          <p>Словаччина -70 км</p>
         </div>
       
        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3"> <img class="col-xs-10 col-xs-offset-1" src="/img/flags/Romania.png"  /> 
          <p>Румунія - 70 км</p>
         </div>
       
        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3"> <img class="col-xs-10 col-xs-offset-1" src="/img/flags/Poland.png"  /> 
          <p>Польща - 110 км</p>
         </div>
       </div>
     </div>
   </div>
 </div>
 </asp:Content>