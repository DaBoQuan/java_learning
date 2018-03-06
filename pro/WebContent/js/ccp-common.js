	/* 
        * ���ʱ���,ʱ���ʽΪ ��-��-�� Сʱ:����:�� ���� ��/��/�� Сʱ�����ӣ��� 
        * ���У�������Ϊȫ��ʽ������ �� 2010-10-12 01:00:00 
        * ���ؾ���Ϊ���룬�֣�Сʱ����
        */

        function GetDateDiff(startTime, endTime, diffType) {
            //��xxxx-xx-xx��ʱ���ʽ��ת��Ϊ xxxx/xx/xx�ĸ�ʽ 
            startTime = startTime.replace(/\-/g, "/");
            endTime = endTime.replace(/\-/g, "/");

            //�������������ַ�ת��ΪСд
            diffType = diffType.toLowerCase();
            var sTime = new Date(startTime);      //��ʼʱ��
            var eTime = new Date(endTime);  //����ʱ��
            //��Ϊ����������
            var divNum = 1;
            switch (diffType) {
                case "second":
                    divNum = 1000;
                    break;
                case "minute":
                    divNum = 1000 * 60;
                    break;
                case "hour":
                    divNum = 1000 * 3600;
                    break;
                case "day":
                    divNum = 1000 * 3600 * 24;
                    break;
                default:
                    break;
            }
            return parseInt((eTime.getTime() - sTime.getTime()) / parseInt(divNum));
        }

		Number.prototype.add = function(arg){   
    var r1,r2,m;   
    try{r1=this.toString().split(".")[1].length}catch(e){r1=0}   
    try{r2=arg.toString().split(".")[1].length}catch(e){r2=0}   
    m=Math.pow(10,Math.max(r1,r2))   
    return (this*m+arg*m)/m   
}   
 
//����   
Number.prototype.sub = function (arg){   
    return this.add(-arg);   
}   
 
//�˷�   
Number.prototype.mul = function (arg)   
{   
    var m=0,s1=this.toString(),s2=arg.toString();   
    try{m+=s1.split(".")[1].length}catch(e){}   
    try{m+=s2.split(".")[1].length}catch(e){}   
    return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)   
}   
 
//����   
Number.prototype.div = function (arg){   
    var t1=0,t2=0,r1,r2;   
    try{t1=this.toString().split(".")[1].length}catch(e){}   
    try{t2=arg.toString().split(".")[1].length}catch(e){}   
    with(Math){   
        r1=Number(this.toString().replace(".",""))   
        r2=Number(arg.toString().replace(".",""))   
        return (r1/r2)*pow(10,t2-t1);   
    }   
}  