$(
    function () {
        //// вставка имени автора
        $("a.insert-author-name").click(
            function () {
                var textarea = document.getElementById("MessageContent");
                textarea.value += "[b]" + this.attributes["data-authorName"].value + "[/b]" + ", ";
                textarea.focus();
                event.preventDefault();
            });
    });

function pmess_PrepareCodeBlockForQuote(str, codeBlock){
    if(typeof(Bitrix.ForumQuotationProcessors) == "undefined") return "[code]\r\n" + codeBlock + "[/code]";
    var r = null;
    for(var p in Bitrix.ForumQuotationProcessors)
        if((r = Bitrix.ForumQuotationProcessors[p](codeBlock))!= null) 
            break; 
             
    return "[code]\r\n" + (r ? r : codeBlock) + "[/code]";
}

function prepare_Quote(authorInfo, containerId, enableBBCode)
    {
        var dstTextArea = document.getElementById("MessageContent");

        var text = enableBBCode ? "[quote]" : "";
    
        if(authorInfo)
            text += authorInfo.toString() + ":\n";
        
        if(!enableBBCode)
		    text += "===========================\n";
    
        var selectedText = Bitrix.DocumentSelection.create().getSelectedText();
        if(selectedText.length == 0){
            var messageContainer = null;
            var messageId = parseInt(containerId.replace(/forum_post_text_/gi, ""));
            if(messageId > 0 && (messageContainer = document.getElementById(containerId))){
                var messageContainerHtml = messageContainer.innerHTML; 
			    messageContainerHtml = messageContainerHtml.replace(/\<br(\s)*(\/)*\>[\r\n]*/gi, "\r\n");
			
			    messageContainerHtml = messageContainerHtml.replace(/\<(\/?)(b|i|s|u)\>/gi, "[$1$2]");
			
			    messageContainerHtml = messageContainerHtml.replace(/\<script[^\>]*>[\r\n]*/gi, "\001").replace(/\<\/script[^\>]*>[\r\n]*/gi, "\002").replace(/\001([^\002]*)\002/gi, "");
			    messageContainerHtml = messageContainerHtml.replace(/\<noscript[^\>]*>[\r\n]*/gi, "\001").replace(/\<\/noscript[^\>]*>[\r\n]*/gi, "\002").replace(/\001([^\002]*)\002/gi, "");
			    // Quote & Code
			    messageContainerHtml = messageContainerHtml.replace(/\<table\s*class\s*\=\s*(\"|\')?forum-quote(\"|\')?([^>]*)\>\s*\<tbody\>\s*(\<tr\>\s*\<th\>\s*([^<]*)\s*\<\/th\>\s*\<\/tr\>\s*)?\s*\<tr\>\s*\<td\>/gi, "\001");
			    messageContainerHtml = messageContainerHtml.replace(/\<\/td\>\<\/tr\>\<\/tbody\>\<\/table\>/gi, "\003");                  
			    var i = 0;
			    while(i < 50 && (messageContainerHtml.search(/\002([^\002\003]*)\003/gi) >= 0 || messageContainerHtml.search(/\001([^\001\003]*)\003/gi) >= 0))
			    {
				    i++;
				    messageContainerHtml = messageContainerHtml.replace(/\001([^\001\003]*)\003/gi, "[quote]$1[/quote]");				
			    }
			    messageContainerHtml = messageContainerHtml.replace(/[\001\002\003]/gi, "");
			    messageContainerHtml = messageContainerHtml.replace(/\<div[^\>]*class\s*=\s*(?:\"|\')?forum-code-box(?:\"|\')?[^\>]*\>([\w\W]*?)\<\/div\><!--ForumCodeBoxEnd-->/ig, pmess_PrepareCodeBlockForQuote);				
			
			    // Hrefs 
			    messageContainerHtml = messageContainerHtml.replace(/\<a[^>]+href=[\"]([^\"]+)\"[^>]+\>([^<]+)\<\/a\>/gi, "[url=$1]$2[/url]");
			    messageContainerHtml = messageContainerHtml.replace(/\<a[^>]+href=[\']([^\']+)\'[^>]+\>([^<]+)\<\/a\>/gi, "[url=$1]$2[/url]");
			
                messageContainerHtml = messageContainerHtml.replace(/\<[^\>]+\>/gi, "");        
                selectedText = Bitrix.HttpUtility.htmlDecode(messageContainerHtml);
            }
        }
    
        if(selectedText.length == 0)
            return true;
        
        text += selectedText;
        text += enableBBCode ? "[/quote]" : "\n===========================\n";
    
        if(dstTextArea.value.length > 0)
            dstTextArea.value += "\n";
	    dstTextArea.value += text;
	    dstTextArea.focus();
	    return false;    
    }