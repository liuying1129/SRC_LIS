	//设立"严格模式"的目的
    //1、消除Javascript语法的一些不合理、不严谨之处，减少一些怪异行为;
    //2、消除代码运行的一些不安全之处，保证代码运行的安全；
	//3、提高编译器效率，增加运行速度；
	//4、为未来新版本的Javascript做好铺垫
    "use strict";

$(document).ready(function() {

    let urls="http://localhost:8090/queryResult?";
    const params = new URLSearchParams(window.location.search);
    for (const [key, value] of params) {
        urls = urls+key+"="+value+"&";
    }

    $.ajax({
		//默认值: true。如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行
		async : true,
		//默认值:"GET".请求方式 ("POST"或 "GET")，注意：其它 HTTP请求方法，如 PUT和 DELETE也可以使用，但仅部分浏览器支持
		type : 'GET',
		//默认值: "application/x-www-form-urlencoded"。发送信息至服务器时内容编码类型
		//默认值适合大多数情况。如果你明确指定$.ajax()的 content-type,那么它必定会发送给服务器（即使没有数据要发送）
		//contentType : "application/x-www-form-urlencoded",//application/json
		url : urls,
		//预期服务器返回的数据类型。如果不指定，jQuery将自动根据 HTTP包 MIME信息来智能判断
		dataType : 'json',
		success : function(data) {

		    if (!data.success){
		        alert(JSON.stringify(data));
		        return;
		    }

            // 遍历JSON并创建HTML内容
            data.results.forEach(function(result) {
                // 创建患者信息容器
                let resultDiv = document.createElement('div');
                resultDiv.classList.add('result-div');
                // 构建患者信息
                const patientInfo ='姓名:<strong>'+result.patientname+'</strong> 性别:'+result.sex+' 年龄:'+result.age+' 申请科室：'+result.deptname+' 申请医生：'+result.check_doctor+' 申请时间：'+result.report_date+' 审核者：'+result.report_doctor+' 审核时间：'+result.Audit_Date;
                resultDiv.innerHTML += patientInfo;
                // 将患者信息容器添加到html body
                document.body.appendChild(resultDiv);

                // 创建检测结果详情容器
                let resultDetailDiv = document.createElement('div');
                resultDetailDiv.classList.add('result-detail-div');

                // Create a table element
                const table = document.createElement('table');

                // Create the table header row
                const headerRow = document.createElement('tr');
                const headers = ['组合项目名称', '子项目名称', '子项目英文名', '检验结果', '最小值', '最大值', '单位'];
                headers.forEach(function(header) {
                    const th = document.createElement('th');
                    th.textContent = header;
                    headerRow.appendChild(th);
                });
                table.appendChild(headerRow);

                // Create the table rows from the JSON data
                result.resultDetails.forEach(function(resultDetail) {

                    if((typeof resultDetail.itemvalue!='undefined')&&(typeof resultDetail.itemvalue.valueOf()=='string')&&(resultDetail.itemvalue.length>0)){
                        const row = document.createElement('tr');
                        const header_field_names = ['combin_Name', 'Name', 'english_name', 'itemvalue', 'Min_value', 'Max_value', 'Unit'];
                        header_field_names.forEach(function(header_field_name) {

                            let td = document.createElement('td');
                            if ((header_field_name === 'Min_value')||(header_field_name === 'Max_value')) {
                                td.innerHTML = resultDetail[header_field_name].replace(/[\r\n]+/g, '<br>');
                            } else {
                                td.textContent = resultDetail[header_field_name];
                            }

                            //超限结果标颜色 begin
                            if (header_field_name === 'itemvalue') {
                                if (resultDetail.ifValueAlarm === 1) {
                                    td.style.color = 'blue';
                                } else if (resultDetail.ifValueAlarm === 2) {
                                    td.style.color = 'red';
                                }
                            }
                            //超限结果标颜色 end

                            row.appendChild(td);
                        });

                        table.appendChild(row);
                    }
                });
                resultDetailDiv.appendChild(table);
                document.body.appendChild(resultDetailDiv);

                //生成图片 begin
                result.resultDetails.forEach(function(resultDetail) {

                    if((typeof resultDetail.Photo!='undefined')&&(typeof resultDetail.Photo.valueOf()=='string')&&(resultDetail.Photo.length>0)){

                        let img = document.createElement('img');
                        img.src = 'data:image/jpeg;base64,'+resultDetail.Photo;
                        img.alt = '哎呀，加载失败了';

                        resultDetailDiv.appendChild(img);
                    }
                });
                //生成图片 end

                //血常规直方图-绘点 begin
                result.resultDetails.forEach(function(resultDetail) {
                    if((typeof resultDetail.histogram!='undefined')&&(typeof resultDetail.histogram.valueOf()=='string')&&(resultDetail.histogram.length>0)){

                        const sl1 = resultDetail.histogram.split(" ");
                        //filter() 方法创建一个新的数组，新数组中的元素是通过检查指定数组中符合条件的所有元素
                        //filter() 不会对空数组进行检测
                        //filter() 不会改变原始数组
                        const filterResult = sl1.filter(function(item, index, array){
                                return (item.length > 0);
                            });
                        const option = {
                                title: {
                                    text: resultDetail.english_name,
                                    x: 'center'
                                },
                                xAxis: {
                                    type: 'category',
                                },
                                yAxis: {
                                    type: 'value',
                                    splitLine: {
                                        show: false
                                    }
                                },
                                series: [{
                                    data: filterResult,
                                    type: 'line'
                                }]
                        };

                        let chartDiv = document.createElement('div');
                        chartDiv.style.display = "inline-block"; //设置为内联块状元素.既可保持内联元素的行为(不独占一行),又能应用宽度和高度样式
                        chartDiv.style.width = "400px";
                        chartDiv.style.height = "250px";
                        chartDiv.style.marginTop = "10px";

                        let chart = echarts.init(chartDiv);
                        chart.setOption(option);

                        resultDetailDiv.appendChild(chartDiv);
                    }
                });
                //血常规直方图-绘点 end

                //血流变曲线 begin
                let X1=-1,Y1=-1,X1_MIN=-1,Y1_MIN=-1,X1_MAX=-1,Y1_MAX=-1,X2=-1,Y2=-1,X2_MIN=-1,Y2_MIN=-1,X2_MAX=-1,Y2_MAX=-1;
                let n=0;
                result.resultDetails.forEach(function(resultDetail) {
                    if((typeof resultDetail.Reserve8!='undefined')&&(typeof resultDetail.Reserve8.valueOf()=='number')){
                        n++;
                        if(n===1){
                            X1 = resultDetail.Reserve8;
                            Y1 = resultDetail.itemvalue;
                            X1_MIN = resultDetail.Reserve8;
                            Y1_MIN = resultDetail.Min_value;
                            X1_MAX = resultDetail.Reserve8;
                            Y1_MAX = resultDetail.Max_value;
                        }
                        if(n===2){
                            X2 = resultDetail.Reserve8;
                            Y2 = resultDetail.itemvalue;
                            X2_MIN = resultDetail.Reserve8;
                            Y2_MIN = resultDetail.Min_value;
                            X2_MAX = resultDetail.Reserve8;
                            Y2_MAX = resultDetail.Max_value;
                        }
                    }
                });

                if((!isNaN(X1))&&(!isNaN(Y1))&&(!isNaN(X1_MIN))&&(!isNaN(Y1_MIN))&&(!isNaN(X1_MAX))&&(!isNaN(Y1_MAX))&&(!isNaN(X2))&&(!isNaN(Y2))&&(!isNaN(X2_MIN))&&(!isNaN(Y2_MIN))&&(!isNaN(X2_MAX))&&(!isNaN(Y2_MAX))){

                    if((X1>=0)&&(Y1>=0)&&(X1_MIN>=0)&&(Y1_MIN>=0)&&(X1_MAX>=0)&&(Y1_MAX>=0)&&(X2>=0)&&(Y2>=0)&&(X2_MIN>=0)&&(Y2_MIN>=0)&&(X2_MAX>=0)&&(Y2_MAX>=0)){

                        const B=(Math.sqrt(Y1)-Math.sqrt(Y2))/(Math.sqrt(1/X1)-Math.sqrt(1/X2));
                        const A=Math.sqrt(Y1)-B*Math.sqrt(1/X1);

                        const B_MIN=(Math.sqrt(Y1_MIN)-Math.sqrt(Y2_MIN))/(Math.sqrt(1/X1_MIN)-Math.sqrt(1/X2_MIN));
                        const A_MIN=Math.sqrt(Y1_MIN)-B_MIN*Math.sqrt(1/X1_MIN);

                        const B_MAX=(Math.sqrt(Y1_MAX)-Math.sqrt(Y2_MAX))/(Math.sqrt(1/X1_MAX)-Math.sqrt(1/X2_MAX));
                        const A_MAX=Math.sqrt(Y1_MAX)-B_MAX*Math.sqrt(1/X1_MAX);

                        let Y=[];
                        let Y_MIN=[];
                        let Y_MAX=[];
                        let X=[];

                        for (let i = 1; i <= 200; i++) {
                              Y.push(Math.pow(A+B*Math.sqrt(1/i),2));
                              Y_MIN.push(Math.pow(A_MIN+B_MIN*Math.sqrt(1/i),2));
                              Y_MAX.push(Math.pow(A_MAX+B_MAX*Math.sqrt(1/i),2));
                              X.push(i-1);
                        }

                        const option = {

                                title: {
                                    text: '血液粘度特性曲线',
                                    x: 'center'
                                },
                                legend: {
                                    orient:'vertical',
                                    right:'10%',
                                    top:'15%'
                                },
                                xAxis: {
                                    name : '切变率(1/s)',
                                    nameLocation:'center',//默认值:end,end时文本过长会被截断
                                    nameGap:25,
                                    type: 'category',
                                    data:X
                                },
                                yAxis: {
                                    name : '粘度(mPa.s)',
                                    type: 'value',
                                    splitLine: {
                                        show: false
                                    }
                                },
                                series: [
                                    {
                                        name:'全血粘度曲线',
                                        type:'line',
                                        data:Y,
                                        itemStyle:{
                                            color:'red'
                                        }
                                    },
                                    {
                                        name:'参考范围(下限)',
                                        type:'line',
                                        data:Y_MIN,
                                        itemStyle:{
                                            color:'blue'
                                        },
                                        lineStyle:{
                                            type:'dashed'
                                        }
                                    },
                                    {
                                        name:'参考范围(上限)',
                                        type:'line',
                                        data:Y_MAX,
                                        itemStyle:{
                                            color:'blue'
                                        },
                                        lineStyle:{
                                            type:'dashed'
                                        }
                                    }
                                ]
                        };

                        let chartDiv = document.createElement('div');
                        chartDiv.style.display = "inline-block"; //设置为内联块状元素.既可保持内联元素的行为(不独占一行),又能应用宽度和高度样式
                        chartDiv.style.width = "600px";
                        chartDiv.style.height = "250px";
                        chartDiv.style.marginTop = "10px";

                        let chart = echarts.init(chartDiv);
                        chart.setOption(option);

                        resultDetailDiv.appendChild(chartDiv);
                    }
                }
                //血流变曲线 end
            });
        }
    });
});