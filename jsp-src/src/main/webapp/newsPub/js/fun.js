// 1. 动态显示时间和问候语
function showTime() {
    var Timer = new Date();
    var h = Timer.getHours();
    var m = Timer.getMinutes();
    var s = Timer.getSeconds();
    var d = Timer.getDate();
    var mm = Timer.getMonth() + 1;
    var y = Timer.getFullYear();
    var strShow = "" + y + "-" + mm + "-" + d + " " + h + ":" + m + ":" + s;
    
    if (h < 6)
        strShow += "  熬夜对身体不好哦,早点休息吧。";
    else if (h < 9)
        strShow += "  早上好!";
    else if (h < 12)
        strShow += "  上午好!";
    else if (h < 19)
        strShow += "  下午好!";
    else if (h < 24)
        strShow += "  晚上好!";
        
    var myspan = document.getElementById("myspan");
    if (myspan) {
        myspan.innerText = strShow;
    }
    setTimeout("showTime()", 1000);
}

// 2. 图片按钮提交表单功能
function submitFun() {
    var form1 = document.getElementById("formQ");
    form1.submit();
}

// 3. 密码长度校验功能
function checkvalid() {
    var obj = document.getElementById("password");
    var strmsg = obj.value;
    var strlg = strmsg.length;
    if (strlg > 15 || strlg < 6) {
        alert("密码长度需要在 6～15 之间!");
        obj.focus();
        return false;
    }
    return true;
}