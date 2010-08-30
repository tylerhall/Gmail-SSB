gmailSSBUnreadCount = function() {
	var mainFrame = document.querySelector("iframe#canvas_frame").contentDocument;
	var elInbox = mainFrame.querySelector("a[href$='#inbox']");
	var count = elInbox.innerHTML.match(/([0-9]+)/);
	return count[0];
};

// Code taken from the ever-awesome Mailplane.app (http://mailplaneapp.com/)
doc=window.document.getElementById("canvas_frame").contentDocument;
if(!doc.getElementById("rapportiveApplication")){
    head=doc.getElementsByTagName("head")[0];
    script=doc.createElement("script");
    script.type="text/javascript";
    script.src=window.location.protocol+"//rapportive.com/load/application?client=Gmail-SSB";
    script.setAttribute("id","rapportiveApplication");
    head.appendChild(script);
}