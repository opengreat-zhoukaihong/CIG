
	self.onError=null;	     
        lastScrollY = 2;
	NS = (document.layers) ? 1 : 0;
	IE = (document.all) ? 1: 0;
	function ieMove() {
	       diffY = document.body.scrollTop;
	       if(diffY != lastScrollY) {
	                percent = .1 * (diffY - lastScrollY);
	                if(percent > 0) percent = Math.ceil(percent);
	                else percent = Math.floor(percent);	                     
		             if(!(document.all.scrollMenu==null)){
		             document.all.scrollMenu.style.pixelTop += percent;
		             }
  	                       lastScrollY = lastScrollY + percent;
	    }
	}
	function nsMove(){
	diffY = self.pageYOffset;
	if(diffY != lastScrollY) {
	                percent = .1 * (diffY - lastScrollY);
	                if(percent > 0) percent = Math.ceil(percent);
	                else percent = Math.floor(percent);
	                     if(!(document.scrollMenu==null)){
	                     document.scrollMenu.top += percent;
	                     } 
	                      lastScrollY = lastScrollY + percent;
	     }
	}                                       
	if(IE) action=window.setInterval("ieMove()",1);
	if(NS) action=window.setInterval("nsMove()",1);
	