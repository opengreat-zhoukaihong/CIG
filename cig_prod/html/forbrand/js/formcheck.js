function isNumber(str)
{
	if(str.length<1)
		return true
	var strnum = parseFloat(str)
	if(isNaN(strnum))
		return false
	else
		return true

}

function isValidChar(str)
{
	var strlen = str.length
	var ch
	for(i=0;i<strlen;i++)
	{
		ch = str.charAt(i)
		if(!((ch<='9'&&ch>='0')||(ch<='Z'&&ch>='A')||(ch<='z'&&ch>='a')||ch=='_'))
			return false
	}
	return true
}

function checkPasswd(pwd1,pwd2)
{
	if(pwd1.value==pwd2.value)
		return true
	else
		return false
}

function checkEmail(mail)
{
	var str = mail.value
	var strindex = str.indexOf("@")
	if(strindex==-1||strindex!=str.lastIndexOf("@"))
		return false
	str = str.substr(strindex)
	if(str.indexOf(".")==-1)
		return false

	return true
}

function reStr(strToReplace)
{
	var str = strToReplace.value
	strToReplace.value = str.replace("'","''")
}

function noSpace(strToChk)
{
	if(strToChk.indexOf(" ")<0&&strToChk.indexOf("¡¡")<0)
		return true
	return false
}


