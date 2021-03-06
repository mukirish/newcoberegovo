﻿if(typeof(Bitrix) == "undefined"){
	var Bitrix = {};
}
Bitrix.YandexMapInitSettingsEditDialog = function Bitrix$YandexMapInitSettingsEditDialog() {
	this.Bitrix$Dialog();
	this._mapContainerEl = null;
	this._typeEl = null;
	this._centerLatEl = null;
	this._centerLngEl = null;
	this._settingsContainerEl = null;
	this._markerTable = null;
	this._markerStub = null;
	this._zoomEl = null;
	this._map = null;
	this._markerInfos = null; 
	this._markerChangeHandler = Bitrix.TypeUtility.createDelegate(this, this._handleMarkerChange);
	this._data = null;
}
Bitrix.TypeUtility.copyPrototype(Bitrix.YandexMapInitSettingsEditDialog, Bitrix.Dialog);
Bitrix.YandexMapInitSettingsEditDialog.prototype.initialize = function(id, name, title, options) {
	this.Bitrix$Dialog.prototype.initialize.call(this, id, name, Bitrix.TypeUtility.isNotEmptyString(title) ? title : this._getMessage("defaultTitle") , null, Bitrix.Dialog.buttonLayout.cancelOk, options);
	
	if(options && typeof(options) == "object" && "data" in options) this._data = Bitrix.YandexMapData.fromObject({ initialState: options.data });
	
	var content = new Array();
	var container = document.createElement("DIV");
	container.id = id + "_" + "container";
	container.className = this.getOption("_contentContainerClass");
	content.push(container);	
	
	this._mapContainerEl = document.createElement("DIV");
	this._mapContainerEl.className = this.getOption("_mapContainerClass");
	container.appendChild(this._mapContainerEl);
	
	var settingsC = this._settingsContainerEl = document.createElement("DIV");
	settingsC.className = this.getOption("_settingsContainerClass");
	container.appendChild(settingsC);
	
	var settingsMain = document.createElement("DIV");
	settingsC.appendChild(settingsMain);
	settingsMain.className = this.getOption("_settingsMainClass");
	var mainTbl = document.createElement("TABLE");
	settingsMain.appendChild(mainTbl);
	mainTbl.border = mainTbl.cellPadding = mainTbl.cellSpacing ="0";
	mainTbl.width = "100%";
	
	var typeEl = this._typeEl = document.createElement("SELECT"); 
	typeEl.className = this.getOption("_inputMapTypeClass");
	Bitrix.DomHelper.addToSelect(typeEl, [{ text: this._getMessage("mapTypeMap"), value: "map" }, { text: this._getMessage("mapTypeSatellite"), value: "satellite" }, { text: this._getMessage("mapTypeHybrid"), value:"hybrid" }]);
	Bitrix.DomHelper.selectOption(typeEl, Bitrix.YandexMapType.toString(this.getMapType()));
	this._constructInput(mainTbl, this._getMessage("mapType"),  typeEl);	
	typeEl.onchange = Bitrix.TypeUtility.createDelegate(this, this._handleMapTypeElChange);
	
	var latEl = this._centerLatEl = document.createElement("INPUT");
	latEl.type = "text";
	latEl.className = this.getOption("_inputCenterClass");
	
	var center = this.getCenter();
	
	latEl.value = center.getLatitude().toFixed(5).toString();
	this._constructInput(mainTbl, this._getMessage("latitude"),  latEl);	
	latEl.onchange = Bitrix.TypeUtility.createDelegate(this, this._centerElChange);
	
	var lngEl = this._centerLngEl = document.createElement("INPUT");
	lngEl.type = "text";
	lngEl.className = this.getOption("_inputCenterClass");	
	lngEl.value = center.getLongitude().toFixed(5).toString();
	this._constructInput(mainTbl, this._getMessage("longitude"),  lngEl);
	lngEl.onchange = Bitrix.TypeUtility.createDelegate(this, this._centerElChange);
	
	var zoomEl = this._zoomEl = document.createElement("INPUT");
	zoomEl.type = "text";
	zoomEl.className = this.getOption("_inputZoomClass");
	zoomEl.value = this.getZoom().toString();
	this._constructInput(mainTbl, this._getMessage("zoom"),  zoomEl);
	zoomEl.onchange = Bitrix.TypeUtility.createDelegate(this, this._zoomElChange);
	
	var settingsMarkers = document.createElement("DIV");
	settingsMarkers.className = this.getOption("_settingsMarkersClass");
	settingsC.appendChild(settingsMarkers);
	
	var markerSecCapContainer = document.createElement("DIV");
	settingsMarkers.appendChild(markerSecCapContainer);
	markerSecCapContainer.className = this.getOption("_settingsMarkerSecCaptionContainerClass");
	var markerSecCap = document.createElement("LABEL");
	markerSecCapContainer.appendChild(markerSecCap);
	markerSecCap.className = this.getOption("_settingsMarkerSecCaptionClass");
	markerSecCap.innerHTML = this._getMessage("markers") + ":";
	
	var markers = this.getMarkers();
	
	var markerStub = this._markerStub = document.createElement("DIV");
	settingsMarkers.appendChild(markerStub);
	markerStub.className = this.getOption("_settingsMarkerStub");
	markerStub.innerHTML = this._getMessage("markerHelp").replace("#AddMarkers1#", this.getId() + "_AddMarkers1").replace("#AddMarkers2#", this.getId() + "_AddMarkers2").replace("#Drag#", this.getId() + "_Drag");

	var markerTblWrapper = document.createElement("DIV");
	settingsMarkers.appendChild(markerTblWrapper);
	markerTblWrapper.className = this.getOption("_settingsMarkerSecContentWrapperClass");

	var markerTblCont = document.createElement("DIV");
	markerTblWrapper.appendChild(markerTblCont);
	markerTblCont.className = this.getOption("_settingsMarkerSecContentContainerClass");	
	
	var markerTbl = this._markerTable = document.createElement("TABLE");
	markerTblCont.appendChild(markerTbl);
	markerTbl.className = this.getOption("_settingsMarkerSecContentTableClass");
	markerTbl.border = markerTbl.cellPadding = markerTbl.cellSpacing ="0";
	markerTbl.width = "100%";
	
	if(markers.length == 0)
		markerTbl.style.display = "none";
	else {
		for(var i = 0; i < markers.length; i++) {
			var marker = markers[i];
			marker.addChangeListener(this._markerChangeHandler);
			this.getMarkerInfos().push({ marker: marker, ctrl: this._constructMarkerCtrl(marker) });
		}
	}
	this.setContent(content);
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._constructInput = function(table, titleText, inputEl) {
	var r = table.insertRow(-1);
	var labelC = r.insertCell(-1);
	var labelContainer = document.createElement("DIV");
	labelC.appendChild(labelContainer);
	labelContainer.className = this.getOption("_labelContainerClass");	
	var l = document.createElement("LABEL");
	labelContainer.appendChild(l);
	l.className = this.getOption("_labelClass");
	l.htmlFor = inputEl.id;
	l.innerHTML = titleText + ":";
	
	var containerC = r.insertCell(-1);
	containerC.align = "right";
	var contentContainer = document.createElement("DIV");
	containerC.appendChild(contentContainer);
	contentContainer.className = this.getOption("_inputContainerClass");	
	contentContainer.appendChild(inputEl);
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._constructMarkerCtrl = function(marker, index) {
	var r = this._markerTable.insertRow(index >= 0 ? index : -1);
	var infoC = r.insertCell(-1);
	infoC.className = this.getOption("_markerInfoContainerClass");
	var ttl = document.createElement("A");
	ttl.innerHTML = Bitrix.HttpUtility.htmlEncode(marker.getTitle().length > 0 ? marker.getTitle() : marker.getDefaultTitle());
	ttl.href = "";
	ttl.onclick = this._constructOpenMarkerEditorDelegate(marker);
	infoC.appendChild(ttl);	
	var btnC = r.insertCell(-1);
	btnC.className = this.getOption("_markerButtonContainerClass");
	var remBtn = document.createElement("DIV");
	btnC.appendChild(remBtn);
	remBtn.className = this.getOption("_markerRemoveButtonClass");
	remBtn.onclick = this._constructRemoveMarkerDelegate(marker);
	this._markerTable.style.display = "";
	this._markerStub.style.display = "none";
	return r;
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._constructOpenMarkerEditorDelegate = function(marker){
	var self = this;
	return function(){ self._map.openMarkerEditor(marker); return false; };
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._constructRemoveMarkerDelegate = function(marker){
	var self = this;
	return function(){ self._map.removeMarker(marker); return false; };
}
Bitrix.YandexMapInitSettingsEditDialog.prototype.construct = function() {
	if (this.isConstructed()) return;
	this.Bitrix$Dialog.prototype.construct.call(this);
	window.setTimeout(Bitrix.TypeUtility.createDelegate(this, this._constructMap), 300);
	this.addCloseListener(Bitrix.TypeUtility.createDelegate(this, this._handleSelfClose));
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._constructMap = function() {
	if(!this._mapContainerEl) throw "Could not find map container element.";
	var d = this.getData();
	d.setEntityId(this.getId());
	d.setMapControlTypes([Bitrix.YandexMapControlType.zoomCompact, Bitrix.YandexMapControlType.typeControl]);
	d.setMapOptions([Bitrix.YandexMapOption.enableScrollZoom, Bitrix.YandexMapOption.enableHotKeys]);
	d.setMarkupPanel(true);
	d.setSearchPanel(true);
	this._map = Bitrix.YandexMapManager.createEntity(d, this._mapContainerEl);
	this._map.construct();
	this._map.addCenterChangeListener(Bitrix.TypeUtility.createDelegate(this, this._handleCenterChange));
	this._map.addMapTypeChangeListener(Bitrix.TypeUtility.createDelegate(this, this._handleMapTypeChange));	
	this._map.addZoomChangeListener(Bitrix.TypeUtility.createDelegate(this, this._handleZoomChange));
	this._map.addMarkerChangeListener(Bitrix.TypeUtility.createDelegate(this, this._handleMarkerAddOrRemove));
	
	var addMarkers1 = document.getElementById(this.getId() + "_AddMarkers1");
	if(addMarkers1) addMarkers1.onclick = Bitrix.TypeUtility.createDelegate(this, this._startMarkerAdd);
	var addMarkers2 = document.getElementById(this.getId() + "_AddMarkers2");
	if(addMarkers2) addMarkers2.onclick = Bitrix.TypeUtility.createDelegate(this, this._startMarkerAdd);
	var drag = document.getElementById(this.getId() + "_Drag");
	if(drag) drag.onclick = Bitrix.TypeUtility.createDelegate(this, this._startDrag);	
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._getMessage = function(id) {
	return "BITRIX_YANDEX_MAPS_MSG" in window && id in window.BITRIX_YANDEX_MAPS_MSG ? window.BITRIX_YANDEX_MAPS_MSG[id] : id;
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._startMarkerAdd = function() {
	var m = this._map;
	if(m) m.startMarkerAdd();
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._startDrag = function() {
	var m = this._map;
	if(m) m.startDrag();
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._handleCenterChange = function(map) {
	if(!this.isConstructed()) return;
	var center = this.getCenter();
	this._centerLatEl.value = center.getLatitude().toFixed(5).toString();
	this._centerLngEl.value = center.getLongitude().toFixed(5).toString();
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._handleZoomChange = function(map) {
	if(!this.isConstructed()) return;
	this._zoomEl.value = this.getZoom().toString();
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._handleMapTypeChange = function(map) {
	if(!this.isConstructed()) return;
	Bitrix.DomHelper.selectOption(this._typeEl, Bitrix.YandexMapType.toString(this.getMapType()));
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._handleMapTypeElChange = function() {
	var arr = Bitrix.YandexMapType.fromString(this._typeEl.value);
	if(arr.length > 0) this._map.setMapType(arr[0]);
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._centerElChange = function() {
	var lat = parseFloat(this._centerLatEl.value);
	var lng = parseFloat(this._centerLngEl.value);
	if(!(isNaN(lat) || isNaN(lng))) this._map.setCenter(Bitrix.MapCoord.create(lat, lng));
} 
Bitrix.YandexMapInitSettingsEditDialog.prototype._zoomElChange = function() {
	var zoom = parseInt(this._zoomEl.value);
	if(!isNaN(zoom)) this._map.setZoom(zoom);
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._handleMarkerAddOrRemove = function(sender, args) {
	if(!this.isConstructed()) return;
	var marker = "marker" in args ? args.marker : null;
	var act = "action" in args ? args.action : null;
	if(!(marker && act)) return;
	var markersTbl = this._markerTable;
	if(act == Bitrix.YandexMapAction.add) {
		marker.addChangeListener(this._markerChangeHandler);
		this.getMarkerInfos().push({ marker: marker, ctrl: this._constructMarkerCtrl(marker) });
	}
	else if(act == Bitrix.YandexMapAction.remove) {
		var infos = this.getMarkerInfos();
		for(var i = 0; i < infos.length; i++) {
			var info = infos[i];
			if(info.marker != marker) continue;
			marker.removeChangeListener(this._markerChangeHandler);
			markersTbl.deleteRow(i);
			infos.splice(i, 1);
			if(infos.length == 0) {
				this._markerTable.style.display = "none";
				this._markerStub.style.display = "";			
			}
			break;
		}
	}
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._handleMarkerChange = function(sender) {
	if(!sender) return;
	var infos = this.getMarkerInfos();
	for(var i = 0; i < infos.length; i++) {
		var info = infos[i];
		if(info.marker != sender) continue;
		this._markerTable.deleteRow(i);
		info.ctrl = this._constructMarkerCtrl(sender, i);
		return;
	}		
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._getAdditionalContainerWrapperClasses = function(){ return this.getOption("_containerWrapperClass"); }
Bitrix.YandexMapInitSettingsEditDialog.prototype.getOption = function(name, defaultValue) {
	if(!Bitrix.TypeUtility.isNotEmptyString(name)) return defaultValue;
	if (this._options && name in this._options) return this._options[name];
	else if (name in Bitrix.YandexMapInitSettingsEditDialog.defaults) return Bitrix.YandexMapInitSettingsEditDialog.defaults[name];	
	else if (name in Bitrix.Dialog.defaults) return Bitrix.Dialog.defaults[name];
	else return defaultValue;
}
Bitrix.YandexMapInitSettingsEditDialog.prototype.getData = function() {
	return this._data ? this._data : (this._data = Bitrix.YandexMapData.create());
}
Bitrix.YandexMapInitSettingsEditDialog.prototype.getMapType = function() {
	return this.getData().getMapType();
}
Bitrix.YandexMapInitSettingsEditDialog.prototype.getCenter = function() {
	return this.getData().getCenter();
}
Bitrix.YandexMapInitSettingsEditDialog.prototype.getZoom = function() {
	return this.getData().getZoom();
}
Bitrix.YandexMapInitSettingsEditDialog.prototype.getMarkers = function() {
	return this.getData().getMarkers();
}
Bitrix.YandexMapInitSettingsEditDialog.prototype.getMarkerInfos = function() { return this._markerInfos ? this._markerInfos : (this._markerInfos = []); }
Bitrix.YandexMapInitSettingsEditDialog.prototype._handleSelfClose = function(e) {
}
Bitrix.YandexMapInitSettingsEditDialog.prototype._getChildElementId = function(parentId, id){ return (parentId ? parentId : this.getId()) + "_" + id; }
Bitrix.YandexMapInitSettingsEditDialog.prototype._getTypeInputId = function(){ return this._getChildElementId(null, "TypeInput"); }
Bitrix.YandexMapInitSettingsEditDialog.prototype._getCenterLatInputId = function(){ return this._getChildElementId(null, "CenterLatInput"); }
Bitrix.YandexMapInitSettingsEditDialog.prototype._getCenterLngInputId = function(){ return this._getChildElementId(null, "CenterLngInput"); }
Bitrix.YandexMapInitSettingsEditDialog.prototype._getZoomInputId = function(){ return this._getChildElementId(null, "ZoomInput"); }
Bitrix.YandexMapInitSettingsEditDialog.create = function(id, name, title, options){
	if(this._items && id in this._items) throw "Item '"+ id +"' already exists!";
	var self = new Bitrix.YandexMapInitSettingsEditDialog();
	self.initialize(id, name, title, options);
	Bitrix.Dialog._addItem(self);
	return self;
}
Bitrix.YandexMapInitSettingsEditDialog.defaults = {
	_containerWrapperClass:"bx-ymaps-set-dialog-container-wrapper",
	_contentContainerClass:"bx-ymaps-set-dialog-content-container",
	_mapContainerClass:"bx-ymaps-set-dialog-map-container",	
	_settingsContainerClass:"bx-ymaps-set-dialog-settings-container",
	_settingsMainClass:"bx-ymaps-set-dialog-settings-main",
	_settingsMarkersClass:"bx-ymaps-set-dialog-settings-markers",
	_settingsMarkerSecCaptionContainerClass:"bx-ymaps-set-marker-sec-caption-container",
	_settingsMarkerSecCaptionClass:"bx-ymaps-set-marker-sec-caption",
	_settingsMarkerStub:"bx-ymaps-set-marker-stub",
	_settingsContainer:"bx-ymaps-set-dialog-settings-container",
	_settingsMarkerSecContentWrapperClass: "bx-ymaps-set-marker-sec-content-wrapper",
	_settingsMarkerSecContentContainerClass: "bx-ymaps-set-marker-sec-content-container",
	_settingsMarkerSecContentTableClass: "bx-ymaps-set-marker-sec-content-tab",
	_labelClass:"bx-ymaps-set-ed-dialog-label",
	_labelContainerClass:"bx-ymaps-set-dialog-label-container",
	_inputContainerClass:"bx-ymaps-set-dialog-input-container",
	_inputMapTypeClass:"bx-ymaps-set-dialog-input-map-type",
	_inputCenterClass:"bx-ymaps-set-dialog-input-center",
	_inputZoomClass:"bx-ymaps-set-dialog-input-zoom",
	_markerContainerClass:"bx-ymaps-set-dialog-marker-container",
	_markerInfoContainerClass:"bx-ymaps-set-dialog-marker-info",
	_markerButtonContainerClass:"bx-ymaps-set-dialog-marker-buttons",
	_markerRemoveButtonClass:"bx-ymaps-set-dialog-marker-remove-button"
}
