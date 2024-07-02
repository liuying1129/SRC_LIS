	//设立"严格模式"的目的
    //1、消除Javascript语法的一些不合理、不严谨之处，减少一些怪异行为;
    //2、消除代码运行的一些不安全之处，保证代码运行的安全；
	//3、提高编译器效率，增加运行速度；
	//4、为未来新版本的Javascript做好铺垫
    "use strict";
    

$(document).ready(function() {

    var urls="http://localhost:8090/queryResult?";
    const params = new URLSearchParams(window.location.search);
    for (const [key, value] of params) {
        //console.log(key, value);
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

            // 获取结果容器
            var resultsContainer = document.getElementById('result-container');

            // 遍历JSON并创建HTML内容
            data.results.forEach(function(result) {
                // 创建结果容器
                var resultDiv = document.createElement('div');
                resultDiv.classList.add('result-div');

                // 构建患者信息
                var patientInfo ='姓名:<strong>'+result.patientname+'</strong> 性别:'+result.sex+' 年龄:'+result.age+' 申请科室：'+result.deptname+' 申请医生：'+result.check_doctor+' 申请时间：'+result.report_date+' 审核者：'+result.report_doctor+' 审核时间：'+result.Audit_Date;
                resultDiv.innerHTML += patientInfo;

                // 构建检测结果详情
                var resultDetailDiv = document.createElement('div');
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

                            const td = document.createElement('td');
                            td.textContent = resultDetail[header_field_name];

                            // 根据 ifValueAlarm 的值设置 itemvalue 单元格的颜色
                            if (header_field_name === 'itemvalue') {
                                const ifValueAlarm = resultDetail['ifValueAlarm'];

                                if (ifValueAlarm === 1) {
                                    td.style.color = 'blue';
                                } else if (ifValueAlarm === 2) {
                                    td.style.color = 'red';
                                }
                            }
                            //============================================

                            row.appendChild(td);
                        });

                        table.appendChild(row);
                    }
                });

                resultsContainer.appendChild(resultDiv);
                resultDetailDiv.appendChild(table);
                resultsContainer.appendChild(resultDetailDiv);

                //生成图片 begin
                result.resultDetails.forEach(function(resultDetail) {

                    if((typeof resultDetail.Photo!='undefined')&&(typeof resultDetail.Photo.valueOf()=='string')&&(resultDetail.Photo.length>0)){

                        var img = document.createElement('img');
                        img.src = 'data:image/jpeg;base64,'+resultDetail.Photo;
                        img.alt = '哎呀，加载失败了';

                        resultDetailDiv.appendChild(img);
                    }
                });
                //生成图片 end
            });
        }
    });
});