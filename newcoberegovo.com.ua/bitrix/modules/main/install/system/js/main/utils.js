var jsUtils =
{
	arEvents: Array(),

	/*.net*/
	IsDisplayNone: function(element) {
		var e = (typeof (element) == 'string') ? document.getElementById(element) : element;
		return e.style.display == 'none';
	},
	ShowTable: function(table, show, def) {
		var elem = (typeof (table) == 'string') ? document.getElementById(table) : table;
		if (elem) {
			if (show)
				try {
				elem.style.display = 'table';
			}
			catch (e) {
				elem.style.display = def ? def : 'block';
			}
			else
				elem.style.display = 'none';
			elem.style.visibility = show ? 'visible' : 'hidden';
		}
	},

	ShowTableRow: function(tableRow, show, def) {
		var elem = (typeof (tableRow) == 'string') ? document.getElementById(tableRow) : tableRow;
		if (elem) {
			if (show)
				try {
				elem.style.display = 'table-row';
			}
			catch (e) {
				elem.style.display = def ? def : 'inline';
			}
			else
				elem.style.display = 'none';
			elem.style.visibility = show ? 'visible' : 'hidden';
		}
	},

	ShowTableCell: function(tableCell, show, def) {
		var elem = (typeof (tableCell) == 'string') ? document.getElementById(tableCell) : tableCell;
		if (elem) {
			if (show)
				try {
				elem.style.display = 'table-cell';
			}
			catch (e) {
				elem.style.display = def ? def : 'inline';
			}
			else
				elem.style.display = 'none';
			elem.style.visibility = show ? 'visible' : 'hidden';
		}
	},

	FindContainingBlock: function(obj) {
		while (obj != document.body) {
			obj = obj.parentNode;
			if (obj.tagName.toLowerCase() == 'div'
			&& (obj.style.position == 'absolute'
				|| obj.style.position == 'relative'
				|| obj.style.position == 'fixed'))
				return obj;
		}
		return obj;
	},

	Path: {
		_Normalize: function(path) {
			if (path == null)
				return '';

			path = jsUtils.trim(path).replace(/\\/g, '/');

			while (path.substring(0, 1) == '/')
				path = jsUtils.trim(path.substring(1));

			//			while (path.slice(-1) == '/')
			//				path = jsUtils.trim(path.substring(0, path.length - 1));

			return path;
		},

		Prepare: function(path) {
			path = jsUtils.Path._Normalize(path);

			if (path.substring(0, 2) != '~/' && path != '~')
				if (path != '')
				return '~/' + path
			else
				return '~';
			return path;
		},

		IsFull: function(path) {
			path = jsUtils.trim(path).replace(/\\/g, '/');
			return /^[a-z]+:/i.test(path);
		},

		ExtractExtension: function(path) {
			//path = jsUtils.Path.Prepare(path);
			if (path == null)
				return '';
			var startPos = path.lastIndexOf('/');
			startPos = (startPos == -1) ? 0 : (startPos + 1);
			var i = path.substring(startPos).lastIndexOf('.');
			if (i == -1 || i == path.length - 1)
				return '';
			return jsUtils.trim(path.substring(startPos + i + 1)).toLowerCase();
		},

		ToAbsolute: function(path) {
			path = jsUtils.Path.Prepare(path);
			return path.replace(/^~(\/|$)/, APPPath + '$1');
		},

		Combine: function() {
			if (arguments.length == 0)
				return '~';
			var collector = '';
			for (var i = 0; i < arguments.length; i++) {
				var part = (i == 0) ? jsUtils.Path.Prepare(arguments[i]) : jsUtils.Path._Normalize(arguments[i]);
				if (i != 0 && collector.slice(-1) != '/')
					collector += '/';
				collector += part;
			}
			return collector;
		},

		ToAbsoluteTheme: function(path) {
			return jsUtils.Path.ToAbsolute(jsUtils.Path.Combine('~/bitrix/themes/.default', path));
		},

		GetDirectory: function(path) {
			path = jsUtils.Path.Prepare(path);
			if (path == '' || path == "~")
				return '';

			var i = path.lastIndexOf("/");
			if (i < 0)
				return ''
			else
				return jsUtils.trim(path.substring(0, i));
		}
	},
	/*.net*/

	addEvent: function(el, evname, func, capture) {
		if (el.attachEvent) // IE
			el.attachEvent("on" + evname, func);
		else if (el.addEventListener) // Gecko / W3C
			el.addEventListener(evname, func, false);
		else
			el["on" + evname] = func;
		this.arEvents[this.arEvents.length] = { 'element': el, 'event': evname, 'fn': func };
	},

	removeEvent: function(el, evname, func) {
		if (el.detachEvent) // IE
			el.detachEvent("on" + evname, func);
		else if (el.removeEventListener) // Gecko / W3C
			el.removeEventListener(evname, func, false);
		else
			el["on" + evname] = null;
	},

	removeAllEvents: function(el) {
		var i;
		for (i = 0; i < this.arEvents.length; i++) {
			if (this.arEvents[i] && (el == false || el == this.arEvents[i].element)) {
				jsUtils.removeEvent(this.arEvents[i].element, this.arEvents[i].event, this.arEvents[i].fn);
				this.arEvents[i] = null;
			}
		}
		if (el == false)
			this.arEvents.length = 0;
	},

	IsDoctype: function() {
		if (document.compatMode)
			return (document.compatMode == "CSS1Compat");

		if (document.documentElement && document.documentElement.clientHeight)
			return true;

		return false;
	},

	GetRealPos: function(el) {
		if (!el || !el.offsetParent)
			return false;

		var res = Array();
		res["left"] = el.offsetLeft;
		res["top"] = el.offsetTop;
		var objParent = el.offsetParent;

		while (objParent && objParent.tagName != "BODY") {
			res["left"] += objParent.offsetLeft;
			res["top"] += objParent.offsetTop;
			objParent = objParent.offsetParent;
		}
		res["right"] = res["left"] + el.offsetWidth;
		res["bottom"] = res["top"] + el.offsetHeight;

		return res;
	},

	FindChildObject: function(obj, tag_name, class_name, recursive) {
		if (!obj)
			return null;
		var tag = tag_name.toUpperCase();
		var cl = (class_name ? class_name.toLowerCase() : null);
		var n = obj.childNodes.length;
		for (var j = 0; j < n; j++) {
			var child = obj.childNodes[j];
			if (child.tagName && child.tagName.toUpperCase() == tag)
				if (!class_name || child.className.toLowerCase() == cl)
				return child;
			if (recursive == true) {
				var deepChild;
				if ((deepChild = jsUtils.FindChildObject(child, tag_name, class_name, true)))
					return deepChild;
			}
		}
		return null;
	},

	FindParentObject: function(obj, tag_name, class_name) {
		if (!obj)
			return null;
		var o = obj;
		var tag = tag_name.toUpperCase();
		var cl = (class_name ? class_name.toLowerCase() : null);
		while (o.parentNode) {
			var parent = o.parentNode;
			if (parent.tagName && parent.tagName.toUpperCase() == tag)
				if (!class_name || parent.className.toLowerCase() == cl)
				return parent;
			o = parent;
		}
		return null;
	},

	FindNextSibling: function(obj, tag_name) {
		if (!obj)
			return null;
		var o = obj;
		var tag = tag_name.toUpperCase();
		while (o.nextSibling) {
			var sibling = o.nextSibling;
			if (sibling.tagName && sibling.tagName.toUpperCase() == tag)
				return sibling;
			o = sibling;
		}
		return null;
	},

	FindPreviousSibling: function(obj, tag_name) {
		if (!obj)
			return null;
		var o = obj;
		var tag = tag_name.toUpperCase();
		while (o.previousSibling) {
			var sibling = o.previousSibling;
			if (sibling.tagName && sibling.tagName.toUpperCase() == tag)
				return sibling;
			o = sibling;
		}
		return null;
	},

	bOpera: navigator.userAgent.toLowerCase().indexOf('opera') != -1,

	bIsIE: /*@cc_on!@*/false,

	IsIE: function() {
		return this.bIsIE;
	},

	bIEDocumentMode: null,
	IEDocumentMode: function() {
		return this.bIEDocumentMode != null ? this.bIEDocumentMode : (this.bIEDocumentMode = /*@cc_on!@*/false && document.documentMode ? document.documentMode : -1);
	},

	bIsIEPre8: null,
	IsIEPre8: function() {
		return this.bIsIEPre8 != null ? this.bIsIEPre8 : (this.IsIE() && this.IEDocumentMode() < 8);
	},

	IsOpera: function() {
		return this.bOpera;
	},

	IsSafari: function() {
		var userAgent = navigator.userAgent.toLowerCase();
		return (/webkit/.test(userAgent));
	},

	IsEditor: function() {
		var userAgent = navigator.userAgent.toLowerCase();
		var version = (userAgent.match(/.+(msie)[\/: ]([\d.]+)/) || [])[2];
		var safari = /webkit/.test(userAgent);

		if (this.IsOpera() || (document.all && !document.compatMode && version < 5.5) || safari)
			return false;

		return true;
	},

	ToggleDiv: function(div) {
		var style = document.getElementById(div).style;
		if (style.display != "none")
			style.display = "none";
		else
			style.display = "block";
		return (style.display != "none");
	},

	urlencode: function(s) {
		return escape(s).replace(new RegExp('\\+', 'g'), '%2B');
	},

	OpenWindow: function(url, width, height) {
		var w = screen.width, h = screen.height;
		if (this.IsOpera()) {
			w = document.body.offsetWidth;
			h = document.body.offsetHeight;
		}
		window.open(url, '', 'status=no,scrollbars=yes,resizable=yes,width=' + width + ',height=' + height + ',top=' + Math.floor((h - height) / 2 - 14) + ',left=' + Math.floor((w - width) / 2 - 5));
	},

	SetPageTitle: function(s) {
		document.title = dotNetVars.titlePrefix + s;
		var h1 = document.getElementsByTagName("H1");
		if (h1)
			h1[0].innerHTML = s;
	},

	LoadPageToDiv: function(url, div_id) {
		var div = document.getElementById(div_id);
		if (!div)
			return;
		CHttpRequest.Action = function(result) {
			CloseWaitWindow();
			document.getElementById(div_id).innerHTML = result;
		}
		ShowWaitWindow();
		CHttpRequest.Send(url);
	},

	trim: function(s) {
		if (typeof s == 'string' || typeof s == 'object' && s.constructor == String) {
			var r, re;

			re = /^[\s\r\n]+/g;
			r = s.replace(re, "");
			re = /[\s\r\n]+$/g;
			r = r.replace(re, "");
			return r;
		}
		else
			return s;
	},

	Redirect: function(args, url) {
		var e = null, bShift = false;
		if (args.length > 0)
			e = args[0];
		if (!e)
			e = window.event;
		if (e)
			bShift = e.shiftKey;

		if (bShift)
			window.open(url);
		else {
			ShowWaitWindow();
			window.location = url;
		}
	},

	False: function() { return false; },

	AlignToPos: function(pos, w, h) {
		var x = pos["left"], y = pos["bottom"];

		var body = document.body;
		if ((body.clientWidth + body.scrollLeft) - (pos["left"] + w) < 0) {
			if (pos["right"] - w >= 0)
				x = pos["right"] - w;
			else
				x = body.scrollLeft;
		}

		if ((body.clientHeight + body.scrollTop) - (pos["bottom"] + h) < 0) {
			if (pos["top"] - h >= 0)
				y = pos["top"] - h;
			else
				y = body.scrollTop;
		}

		return { 'left': x, 'top': y };
	},

	// evaluate js string in window scope
	EvalGlobal: function(script) {
		try {
			if (window.execScript)
				window.execScript(script, 'javascript');
			else if (jsUtils.IsSafari())
				window.setTimeout(script, 0);
			else
				window.eval(script);
		} catch (e) { /*alert("Error! jsUtils.EvalGlobal");*/ }
	},

	GetStyleValue: function(el, styleProp) {
		var res;
		if (el.currentStyle)
			res = el.currentStyle[styleProp];
		else if (window.getComputedStyle)
			res = document.defaultView.getComputedStyle(el, null).getPropertyValue(styleProp);
		if (!res)
			res = '';
		return res;
	},

	GetWindowInnerSize: function(pDoc) {
		var width, height;
		if (!pDoc)
			pDoc = document;

		if (self.innerHeight) // all except Explorer
		{
			width = self.innerWidth;
			height = self.innerHeight;
		}
		else if (pDoc.documentElement && pDoc.documentElement.clientHeight) // Explorer 6 Strict Mode
		{
			width = pDoc.documentElement.clientWidth;
			height = pDoc.documentElement.clientHeight;
		}
		else if (pDoc.body) // other Explorers
		{
			width = pDoc.body.clientWidth;
			height = pDoc.body.clientHeight;
		}
		return { innerWidth: width, innerHeight: height };
	},

	GetWindowScrollPos: function(pDoc) {
		var left, top;
		if (!pDoc)
			pDoc = document;

		if (self.pageYOffset) // all except Explorer
		{
			left = self.pageXOffset;
			top = self.pageYOffset;
		}
		else if (pDoc.documentElement && pDoc.documentElement.scrollTop) // Explorer 6 Strict
		{
			left = document.documentElement.scrollLeft;
			top = document.documentElement.scrollTop;
		}
		else if (pDoc.body) // all other Explorers
		{
			left = pDoc.body.scrollLeft;
			top = pDoc.body.scrollTop;
		}
		return { scrollLeft: left, scrollTop: top };
	},

	GetWindowScrollSize: function(pDoc) {
		var width, height;
		if (!pDoc)
			pDoc = document;

		if ((pDoc.compatMode && pDoc.compatMode == "CSS1Compat")) {
			width = pDoc.documentElement.scrollWidth;
			height = pDoc.documentElement.scrollHeight;
		}
		else {
			if (pDoc.body.scrollHeight > pDoc.body.offsetHeight)
				height = pDoc.body.scrollHeight;
			else
				height = pDoc.body.offsetHeight;

			if (pDoc.body.scrollWidth > pDoc.body.offsetWidth ||
				(pDoc.compatMode && pDoc.compatMode == "BackCompat") ||
				(pDoc.documentElement && !pDoc.documentElement.clientWidth)
			)
				width = pDoc.body.scrollWidth;
			else
				width = pDoc.body.offsetWidth;
		}
		return { scrollWidth: width, scrollHeight: height };
	},

	GetWindowSize: function() {
		var innerSize = jsUtils.GetWindowInnerSize();
		var scrollPos = jsUtils.GetWindowScrollPos();
		var scrollSize = jsUtils.GetWindowScrollSize();

		return {
			innerWidth: innerSize.innerWidth, innerHeight: innerSize.innerHeight,
			scrollLeft: scrollPos.scrollLeft, scrollTop: scrollPos.scrollTop,
			scrollWidth: scrollSize.scrollWidth, scrollHeight: scrollSize.scrollHeight
		};
	},


	arCustomEvents: {},

	addCustomEvent: function(eventName, eventHandler, arParams, handlerContextObject) {
		if (!this.arCustomEvents[eventName])
			this.arCustomEvents[eventName] = [];

		if (!arParams)
			arParams = [];
		if (!handlerContextObject)
			handlerContextObject = false;

		this.arCustomEvents[eventName].push(
			{
				handler: eventHandler,
				arParams: arParams,
				obj: handlerContextObject
			}
		);
	},

	removeCustomEvent: function(eventName, eventHandler) {
		if (!this.arCustomEvents[eventName])
			return;

		var l = this.arCustomEvents[eventName].length;
		if (l == 1) {
			delete this.arCustomEvents[eventName];
			return;
		}

		for (var i = 0; i < l; i++) {
			if (!this.arCustomEvents[eventName][i])
				continue;
			if (this.arCustomEvents[eventName][i].handler == eventHandler) {
				delete this.arCustomEvents[eventName][i];
				return;
			}
		}
	},

	onCustomEvent: function(eventName, arEventParams) {
		if (!this.arCustomEvents[eventName])
			return;

		if (!arEventParams)
			arEventParams = [];

		var h;
		for (var i = 0, l = this.arCustomEvents[eventName].length; i < l; i++) {
			h = this.arCustomEvents[eventName][i];
			if (!h || !h.handler)
				continue;

			if (h.obj)
				h.handler.call(h.obj, h.arParams, arEventParams);
			else
				h.handler(h.arParams, arEventParams);
		}
	},

	loadJSFile: function(arJs, oCallBack, pDoc) {
		if (!pDoc)
			pDoc = document;
		if (typeof arJs == 'string')
			arJs = [arJs];
		var callback = function() {
			if (!oCallBack)
				return;
			if (typeof oCallBack == 'function')
				return oCallBack();
			if (typeof oCallBack != 'object' || !oCallBack.func)
				return;
			var p = oCallBack.params || {};
			if (oCallBack.obj)
				oCallBack.func.apply(oCallBack.obj, p);
			else
				oCallBack.func(p);
		};
		var load_js = function(ind) {
			if (ind >= arJs.length)
				return callback();
			var oSript = pDoc.body.appendChild(pDoc.createElement('script'));
			oSript.src = arJs[ind];
			var bLoaded = false;
			oSript.onload = oSript.onreadystatechange = function() {
				if (!bLoaded && (!oSript.readyState || oSript.readyState == "loaded" || oSript.readyState == "complete")) {
					bLoaded = true;
					setTimeout(function() { load_js(++ind); }, 50);
				}
			};
		};
		load_js(0);
	},

	loadCSSFile: function(arCSS, pDoc, pWin) {
		if (typeof arCSS == 'string') {
			var bSingle = true;
			arCSS = [arCSS];
		}
		var i, l = arCSS.length, pLnk = [];
		if (l == 0)
			return;
		if (!pDoc)
			pDoc = document;
		if (!pWin)
			pWin = window;
		if (!pWin.bxhead) {
			var heads = pDoc.getElementsByTagName('HEAD');
			pWin.bxhead = heads[0];
		}
		if (!window.bxhead)
			return;
		for (i = 0; i < l; i++) {
			var lnk = document.createElement('LINK');
			lnk.href = arCSS[i];
			lnk.rel = 'stylesheet';
			lnk.type = 'text/css';
			pWin.bxhead.appendChild(lnk);
			pLnk.push(lnk);
		}
		if (bSingle)
			return lnk;
		return pLnk;
	},

	appendBXHint: function(node, html) {
		if (!node || !node.parentNode || !html)
			return;
		var oBXHint = new BXHint(html);
		node.parentNode.insertBefore(oBXHint.oIcon, node);
		node.parentNode.removeChild(node);
		oBXHint.oIcon.style.marginLeft = "5px";
	},

	PreventDefault: function(e) {
		if (!e) e = window.event;
		if (e.stopPropagation) {
			e.preventDefault();
			e.stopPropagation();
		}
		else {
			e.cancelBubble = true;
			e.returnValue = false;
		}
		return false;
	},

	CreateElement: function(tag, arAttr, arStyles, pDoc) {
		if (!pDoc)
			pDoc = document;
		var pEl = pDoc.createElement(tag), p;
		if (arAttr) {
			for (p in arAttr) {
				if (p == 'className' || p == 'class') {
					pEl.setAttribute('class', arAttr[p]);
					if (jsUtils.IsIE())
						pEl.setAttribute('className', arAttr[p]);
					continue;
				}

				if (arAttr[p] != undefined && arAttr[p] != null)
					pEl.setAttribute(p, arAttr[p]);
			}
		}
		if (arStyles) {
			for (p in arStyles)
				pEl.style[p] = arStyles[p];
		}
		return pEl;
	},

	in_array: function(needle, haystack) {
		for (var i = 0; i < haystack.length; i++) {
			if (haystack[i] == needle)
				return true;
		}
		return false;
	}
}

/************************************************/

function JCFloatDiv()
{
	var _this = this;
	this.floatDiv = null;
	this.x = this.y = 0;

	this.Show = function(div, left, top, dxShadow, restrictDrag, showSubFrame)
	{
		if (showSubFrame !== false)
			showSubFrame = true;
		var zIndex = parseInt(div.style.zIndex);
		if(zIndex <= 0 || isNaN(zIndex))
			zIndex = 100;

		div.style.zIndex = zIndex;

		if (left < 0)
			left = 0;

		if (top < 0)
			top = 0;

		div.style.left = parseInt(left) + "px";
		div.style.top = parseInt(top) + "px";

		if(jsUtils.IsIE() && showSubFrame)
		{
			var frame = document.getElementById(div.id+"_frame");
			if(!frame)
			{
				frame = document.createElement("IFRAME");
				frame.src = "javascript:''";
				frame.id = div.id+"_frame";
				frame.style.position = 'absolute';
				frame.style.zIndex = zIndex-1;
				document.body.appendChild(frame);
			}
			frame.style.width = div.offsetWidth + "px";
			frame.style.height = div.offsetHeight + "px";
			frame.style.left = div.style.left;
			frame.style.top = div.style.top;
			frame.style.visibility = 'visible';
		}

		/*Restrict drag*/
		div.restrictDrag = restrictDrag || false;

		/*shadow*/
		if(isNaN(dxShadow))
			dxShadow = 5;

		if(dxShadow > 0)
		{
			var img = document.getElementById(div.id+'_shadow');
			if(!img)
			{
				if(jsUtils.IsIE())
				{
		 			img = document.createElement("DIV");
		 			/*.net*/ img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + jsUtils.Path.ToAbsolute('~/bitrix/themes/' + dotNetVars.ADMIN_THEME_ID + '/images/shadow.png') + "',sizingMethod='scale')";
				}
				else
				{
		 			img = document.createElement("IMG");
					/*.net*/ img.src = jsUtils.Path.ToAbsolute('~/bitrix/themes/' + dotNetVars.ADMIN_THEME_ID + '/images/shadow.png');
				}
				img.id = div.id+'_shadow';
				img.style.position = 'absolute';
				img.style.zIndex = zIndex-2;
				img.style.left = '-1000px';
				img.style.top = '-1000px';
				img.style.lineHeight = 'normal';
				document.body.appendChild(img);
			}
			img.style.width = div.offsetWidth+'px';
			img.style.height = div.offsetHeight+'px';
			img.style.left = parseInt(div.style.left)+dxShadow+'px';
			img.style.top = parseInt(div.style.top)+dxShadow+'px';
			img.style.visibility = 'visible';
		}
		div.dxShadow = dxShadow;
	}

	this.Close = function(div)
	{
		if(!div)
			return;
		var sh = document.getElementById(div.id+"_shadow");
		if(sh)
			sh.style.visibility = 'hidden';

		var frame = document.getElementById(div.id+"_frame");
		if(frame)
			frame.style.visibility = 'hidden';
	}

	this.Move = function(div, x, y)
	{
		if(!div)
			return;

		var dxShadow = div.dxShadow;
		var left = parseInt(div.style.left)+x;
		var top = parseInt(div.style.top)+y;

		if (div.restrictDrag)
		{
			//Left side
			if (left < 0)
				left = 0;

			//Right side
			if ( (document.compatMode && document.compatMode == "CSS1Compat"))
				windowWidth = document.documentElement.scrollWidth;
			else
			{
				if (document.body.scrollWidth > document.body.offsetWidth ||
					(document.compatMode && document.compatMode == "BackCompat") ||
					(document.documentElement && !document.documentElement.clientWidth)
				)
					windowWidth = document.body.scrollWidth;
				else
					windowWidth = document.body.offsetWidth;
			}

			var floatWidth = div.offsetWidth;
			if (left > (windowWidth - floatWidth - dxShadow))
				left = windowWidth - floatWidth - dxShadow;

			//Top side
			if (top < 0)
				top = 0;
		}

		div.style.left = left+'px';
		div.style.top = top+'px';

		this.AdjustShadow(div);
	}

	this.HideShadow = function(div)
	{
		var sh = document.getElementById(div.id + "_shadow");
		sh.style.visibility = 'hidden';
	}

	this.UnhideShadow = function(div)
	{
		var sh = document.getElementById(div.id + "_shadow");
		sh.style.visibility = 'visible';
	}

	this.AdjustShadow = function(div)
	{
		var sh = document.getElementById(div.id + "_shadow");
		if(sh && sh.style.visibility != 'hidden')
		{
			var dxShadow = div.dxShadow;

			sh.style.width = div.offsetWidth+'px';
			sh.style.height = div.offsetHeight+'px';
			sh.style.left = parseInt(div.style.left)+dxShadow+'px';
			sh.style.top = parseInt(div.style.top)+dxShadow+'px';
		}

		var frame = document.getElementById(div.id+"_frame");
		if(frame)
		{
			frame.style.width = div.offsetWidth + "px";
			frame.style.height = div.offsetHeight + "px";
			frame.style.left = div.style.left;
			frame.style.top = div.style.top;
		}
	}

	this.StartDrag = function(e, div)
	{
		try
		{
			if(window.event)
			{
				window.event.cancelBubble = true;
				window.event.returnValue = false;
			}
			else
			{
				e.preventDefault();
			}
		}
		catch(e){}

		if(!e)
			e = window.event;
		this.x = e.clientX + document.body.scrollLeft;
		this.y = e.clientY + document.body.scrollTop;
		this.floatDiv = div;

		jsUtils.addEvent(document, "mousemove", this.MoveDrag);
		document.onmouseup = this.StopDrag;
		if(document.body.setCapture)
			document.body.setCapture();

		var b = document.body;
		b.ondrag = jsUtils.False;
		b.onselectstart = jsUtils.False;
		b.style.MozUserSelect = _this.floatDiv.style.MozUserSelect = 'none';
		b.style.cursor = 'move';
	}

	this.StopDrag = function(e)
	{
		if(document.body.releaseCapture)
			document.body.releaseCapture();

		jsUtils.removeEvent(document, "mousemove", _this.MoveDrag);
		document.onmouseup = null;

		this.floatDiv = null;

		var b = document.body;
		b.ondrag = null;
		b.onselectstart = null;
		b.style.MozUserSelect = _this.floatDiv.style.MozUserSelect = '';
		b.style.cursor = '';
	}

	this.MoveDrag = function(e)
	{
		try
		{
			if(window.event)
			{
				window.event.cancelBubble = true;
				window.event.returnValue = false;
			}
			else
			{
				e.preventDefault();
			}
		}
		catch(e){}

		var x = e.clientX + document.body.scrollLeft;
		var y = e.clientY + document.body.scrollTop;

		if(_this.x == x && _this.y == y)
			return;

		_this.Move(_this.floatDiv, (x - _this.x), (y - _this.y));
		_this.x = x;
		_this.y = y;
	}
}
var jsFloatDiv = new JCFloatDiv();

/************************************************/

var BXHint = function(innerHTML, element, addParams)
{
	this.oDivOver = false;
	this.timeOutID = null;
	this.oIcon = null;
	this.freeze = false;
	this.x = 0;
	this.y = 0;
	this.time = 700;

	if (!innerHTML)
		innerHTML = "";
	this.Create(innerHTML, element, addParams);
}

BXHint.prototype.Create = function(innerHTML, element, addParams)
{
	var
		_this = this,
		width = 0,
		height = 0,
		className = null,
		type = "icon";
	this.bWidth = true;

	if (addParams)
	{
		if (addParams.width === false)
			this.bWidth = false;
		else if (addParams.width)
			width = addParams.width;

		if (addParams.height)
			height = addParams.height;

		if (addParams.className)
			className = addParams.className;

		if (addParams.type && (addParams.type == "link" || addParams.type == "icon"))
			type = addParams.type;
		if (addParams.time > 0)
			this.time = addParams.time;
	}

	if (element)
		type = "element";

	if (type == "icon")
	{
		var element = document.createElement("IMG");
		/*.net*/ element.src = (addParams && addParams.iconSrc) ? addParams.iconSrc : jsUtils.Path.ToAbsolute("~/bitrix/themes/" + dotNetVars.ADMIN_THEME_ID + "/public/popup/hint.gif");
		element.ondrag = jsUtils.False;
	}
	else if (type == "link")
	{
		var element = document.createElement("A");
		element.href = "";
		element.onclick = function(e){return false;}
		element.innerHTML = "[?]";
	}

	this.element = element;
	if (type == "element")
	{
		jsUtils.addEvent(
			element,
			"mouseover",
			function (event)
			{
				if (!event)
					event = window.event;
				_this.GetMouseXY(event);
				_this.timeOutID = setTimeout(function () {_this.Show(innerHTML,width,height,className) }, 750);
			}
		);

		jsUtils.addEvent(
			element,
			"mouseout",
			function(event)
			{
				if (_this.timeOutID)
					clearTimeout(_this.timeOutID);
				_this.SmartHide(_this);
			}
		);
	}
	else
	{
		this.oIcon = element;
		element.onmouseover = function(event) {if (!event) event = window.event; _this.GetMouseXY(event); _this.Show(innerHTML,width,height,className)};
		element.onmouseout = function() {_this.SmartHide(_this);};
	}
}

BXHint.prototype.IsFrozen = function()
{
	return this.freeze;
}

BXHint.prototype.Freeze = function()
{
	this.freeze = true;
	this.Hide();
}

BXHint.prototype.UnFreeze = function()
{
	this.freeze = false;
}

BXHint.prototype.GetMouseXY = function(event)
{
	if (event.pageX || event.pageY)
	{
		this.x = event.pageX;
		this.y = event.pageY;
	}
	else if (event.clientX || event.clientY)
	{
		this.x = event.clientX + (document.documentElement.scrollLeft || document.body.scrollLeft) - document.documentElement.clientLeft;
		this.y = event.clientY + (document.documentElement.scrollTop || document.body.scrollTop) - document.documentElement.clientTop;
	}
}

BXHint.prototype.Show = function(innerHTML, width, height, className)
{
	//Delete previous hint
	var old = document.getElementById("__BXHint_div");
	if (old)
		this.Hide();

	if (this.freeze)
		return;

	var _this = this;
	var oDiv = document.body.appendChild(document.createElement("DIV"));
	oDiv.onmouseover = function(){_this.oDivOver = true};
	oDiv.onmouseout = function(){_this.oDivOver = false; _this.SmartHide(_this);}
	oDiv.id = "__BXHint_div";
	oDiv.className = (className) ? className : "bxhint";
	oDiv.style.position = 'absolute';
	if (width && this.bWidth)
		oDiv.style.width = width + "px";

	if (height)
		oDiv.style.height = height + "px";
	oDiv.innerHTML = innerHTML;

	var w = oDiv.offsetWidth;
	var h = oDiv.offsetHeight;
	if (this.bWidth)
	{
		if (!width && w>200)
			w = Math.round(Math.sqrt(1.618*w*h));
		oDiv.style.width = w + "px";
		h = oDiv.offsetHeight;
	}

	var pos = {left : this.x + 10, right : this.x + w, top : this.y, bottom : this.y + h};

	pos = this.AlignToPos(pos, w, h);

	oDiv.style.zIndex = 2100;

	jsFloatDiv.Show(oDiv, pos.left, pos.top,3);

	oDiv.ondrag = jsUtils.False;
	oDiv.onselectstart = jsUtils.False;
	oDiv.style.MozUserSelect = 'none';
	oDiv = null;
}

BXHint.prototype.AlignToPos = function(pos, w, h)
{
	var body = document.body;
	if((body.clientWidth + body.scrollLeft) < (pos.left + w))
		pos.left = (pos.left - w >= 0) ? (pos.left - w) : body.scrollLeft;

	if((body.clientHeight + body.scrollTop) - (pos["bottom"]) < 0)
		pos.top = (pos.top - h >= 0) ? (pos.top - h) : body.scrollTop;

	return pos;
}

BXHint.prototype.Hide = function()
{
	var oDiv = document.getElementById("__BXHint_div");

	if (!oDiv)
		return;

	jsFloatDiv.Close(oDiv);
	oDiv.parentNode.removeChild(oDiv);
	oDiv = null;
}

BXHint.prototype.SmartHide = function(_this)
{
	setTimeout(function ()
		{
			if (!_this.oDivOver)
				_this.Hide();
		}, 100
	);
}

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded(); 