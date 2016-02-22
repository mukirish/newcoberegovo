<%@ Page Language="C#" AutoEventWireup="true" Inherits="Bitrix.UI.BXPublicPage, Main" Title="Контактная информация" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bxcontent" runat="server" > 
	
    <p>Обратитесь к нашим специалистам и получите профессиональную консультацию по услугам нашего банка.</p>
   		 		
    <p>Вы можете обратиться к нам по телефону, по электронной почте или договориться о встрече в нашем офисе. Будем рады помочь вам и ответить на все ваши вопросы. </p>
   		 		
    <h2>Телефоны</h2>
   			
    <ul> 				
      <li>Телефон/факс: 					
        <ul> 						
          <li><b>(495) 212-85-06</b></li>
        </ul>
     </li>		
     <li>Телефоны: 					
        <ul> 						
          <li><b>(495) 212-85-07</b></li>
         						
          <li><b>(495) 212-85-08</b>
        </li>
      </ul>
     </li>
    </ul>				 			
<h2>Наш офис в Москве</h2>  				 			
<bx:IncludeComponent 
	id="mapgoogle_view1" 
	runat="server" 
	componentname="bitrix:map.google.view" 
	template=".default" 
	MapWidthInPixels="600" 
	MapHeightInPixels="600" 
	MapControls="" 
	MapOptions="" 
	DraggableCursor="" 
	DraggingCursor="" 
	InitialState="{ mapType: &quot;roadmap&quot;, center: { lat: 55.75509594321108, lng: 37.60025749206543 }, zoom: 15, markers: [ { title: &quot;Наш московский офис&quot;, position: { lat: 55.75318806139659, lng: 37.60178098678589 } } ] }" 
/>

 </asp:Content>

