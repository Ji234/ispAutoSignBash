#/bin/bash
date1=$(date +%Y年%m月%d日)
x=$(curl -s -c 001.txt https://xsswzx.cdu.edu.cn/ispstu/com_user/weblogin.asp | grep -Po '\;([0-9]{4})' | grep -Po '([0-9]{4})') #查找验证码
sleep 1
curl  -s -b 001.txt -c 002.txt -d "username=&userpwd=&code="$x"&login=login&checkcode=1&rank=0&action=login&m5=1"  https://xsswzx.cdu.edu.cn/ispstu/com_user/weblogin.asp >/dev/null #学号密码等自己修改 001.txt保存cookie
id=$( curl -s -b 002.txt https://xsswzx.cdu.edu.cn/ispstu/com_user/webindex.asp | grep -Po "[0-9a-f]{40}[0-9a-f]*" | uniq) #查找id后来发现没有用
result=$(curl -s -b 001.txt -c 002.txt "https://xsswzx.cdu.edu.cn/ispstu/com_user/projecthealth_addx.asp?id=&id2="$date1"&adds=四川省成都市龙泉驿区十陵街道灵龙路30号月楿广场&addsxy=104.184478,30.652437")  #adds表示地址 addsxy表示经纬度

if [[ $result =~ "成功" || $result =~ "存在" ]]
then
	echo "成功" 
	echo "成功" > log
	
else 
	echo "失败" 
	echo "失败" > log
fi
