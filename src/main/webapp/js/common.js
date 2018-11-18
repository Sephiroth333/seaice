/*201601114 by yll*/
$(function(){
    //倒计时
    (function(){
	    var timedate = new Date("November 9,2017");
	    var now = new Date();
	    var date = timedate.getTime() - now.getTime();
	    var time = Math.floor(date / (1000 * 60 * 60 * 24));
	    if (time >= 0) $("#interval").text(time);
    })();
});

$(function(){
	var wH= $(window).height();
	var dH = $("html").height();
	if(wH > dH){
		// alert()
		$('.footer').addClass('footerFixed');
	}else{
		$('.footer').removeClass('footerFixed');
	}

	$('.tablelist tbody tr:odd').addClass('odd');
});




//对Date的扩展，将 Date 转化为指定格式的String
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (mask) { 
	  var d = this;
	  var zeroize = function (value, length) {
	      if (!length) length = 2;
	      value = String(value);
	      for (var i = 0, zeros = ''; i < (length - value.length); i++) {
	        zeros += '0';
	      }
	      return zeros + value;
	    };
	  return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0){
	    switch ($0) {
	    case 'd':
	      return d.getDate();
	    case 'dd':
	      return zeroize(d.getDate());
	    case 'ddd':
	      return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
	    case 'dddd':
	      return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
	    case 'M':
	      return d.getMonth() + 1;
	    case 'MM':
	      return zeroize(d.getMonth() + 1);
	    case 'MMM':
	      return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
	    case 'MMMM':
	      return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
	    case 'yy':
	      return String(d.getFullYear()).substr(2);
	    case 'yyyy':
	      return d.getFullYear();
	    case 'h':
	      return d.getHours() % 12 || 12;
	    case 'hh':
	      return zeroize(d.getHours() % 12 || 12);
	    case 'H':
	      return d.getHours();
	    case 'HH':
	      return zeroize(d.getHours());
	    case 'm':
	      return d.getMinutes();
	    case 'mm':
	      return zeroize(d.getMinutes());
	    case 's':
	      return d.getSeconds();
	    case 'ss':
	      return zeroize(d.getSeconds());
	    case 'l':
	      return zeroize(d.getMilliseconds(), 3);
	    case 'L':
	      var m = d.getMilliseconds();
	      if (m > 99) m = Math.round(m / 10);
	      return zeroize(m);
	    case 'tt':
	      return d.getHours() < 12 ? 'am' : 'pm';
	    case 'TT':
	      return d.getHours() < 12 ? 'AM' : 'PM';
	    case 'Z':
	      return d.toUTCString().match(/[A-Z]+$/);
	      // Return quoted strings with the surrounding quotes removed
	    default:
	      return $0.substr(1, $0.length - 2);
	    }
	  });
	};
