<%@ page import="com.homework.model.StudentHomework" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: qwd
  Date: 2020/7/08
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userName = (String) request.getAttribute("userName");
%>
<html>
<head>
    <title>作业管理系统-教师</title>
    <% String path = request.getContextPath();%>
    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header header header-demo" summer>
        <ul class="layui-nav">
            <li class="layui-nav-item"><a href="">作业管理系统-教师</a></li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item"><a href="http://localhost:8080/user/home" target="_blank">注销</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree">
                <li class="layui-nav-item">
                    <a class="javascript:;" href="http://localhost:8080/teacher/enter?userName=<%=userName%>">批改作业</a>
                </li>

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="javascript:;" href="">发布作业</a>
                </li>
            </ul>
        </div>
    </div>


    <div class="layui-tab">
        <div class="layui-body layui-tab-content">
            <div class="layui-tab-item layui-show">
                <div class="layui-main">
                    <div id="LAY_preview">
                        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                            <legend>发布作业</legend>
                        </fieldset>

                        <div style="padding: 10px;">
                            <form class="layui-form">
                                <div class="layui-form-item">
                                    <fieldset class="layui-field-title" >
                                        <legend>作业标题</legend>
                                        <input type="text" class="layui-input"  required  lay-verify="required" autocomplete="off"
                                               id="HomeworkTitle" placeholder="请输入：作业题目">
                                    </fieldset>
                                </div>

                                <div class="layui-form-item layui-form-text">
                                    <fieldset class="layui-field-title">
                                        <legend>作业要求</legend>
                                        <textarea type="text" class="layui-textarea"  required lay-verify="required"  style="height: 300px;"
                                                  id="HomeworkContent" placeholder="请输入内容，现仅支持文本，200字内"></textarea>
                                    </fieldset>
                                </div>

                                <div class="layui-form-item layui-form-text">
                                    <fieldset class="layui-field-title">
                                        <legend>截止时间</legend>
                                        <input type="text" class="layui-input" id="Deadline" autocomplete="off" placeholder="单击选择截止日期">
                                    </fieldset>
                                </div>

                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button type="button" class="layui-btn" id="publish" style="width: 350px">发布</button>
                                        <button type="button" class="layui-btn" id="testList" style="width: 350px">选择文件</button>
                                        <button type="button" class="layui-btn" id="testListAction" style="width: 350px">开始上传</button>
                                    </div>
                                </div>
                                <div class="layui-upload-list">
                                    <table class="layui-table">
                                        <thead>
                                        <tr><th>文件名</th>
                                            <th>大小</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                        </tr></thead>
                                        <tbody id="demoList"></tbody>
                                    </table>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-footer footer footer-demo">
        <div class="layui-main">

        </div>
    </div>

    <div class="site-mobile-shade"></div>
</div>


<script src="<%=path%>/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','layer','laydate','element','upload'],function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var laydate = layui.laydate;
        var upload = layui.upload;
        var index;
        var element = layui.element;
        var userName = '<%=userName%>';

        laydate.render({
            elem : '#Deadline',
            trigger : 'click'
        });




        $("#publish").click(function () {
            var title = $("#HomeworkTitle").val();
            var requirement = $("#HomeworkContent").val();
            var deadline = $("#Deadline").val();

            if(title==""){
                layer.msg("请输入作业标题");
            }else{
                if(requirement==""){
                    layer.msg("请输入作业要求");
                }else{
                    if(deadline==""){
                        layer.msg("请输入截止日期");
                    }else{
                        var deadline_date = new Date(deadline.replace(/\-/g, "\/"));
                        var today = new Date();
                        if(deadline_date<=today){
                            layer.msg("截止日期设置错误!");
                        }else{
                            var date = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate();
                            $.ajax({
                                url:"http://localhost:8080/teacher/publish",
                                data:{
                                    'teacherName' : userName,
                                    'title' : title,
                                    'requirement' : requirement,
                                    'publishDate' : date,
                                    'deadline' : deadline
                                },
                                type : "POST",
                                success:function () {
                                    layer.msg("发布成功,即将跳转",{icon: 1});
                                    var command = "location.href='http://localhost:8080/teacher/enter?userName="+userName+"'";
                                    setTimeout(command,500);
                                }
                            });
                        }
                    }
                }
            }
        })

        var demoListView = $('#demoList')
            ,uploadListIns = upload.render({
            elem: '#testList'
            ,url: 'http://localhost:8080/data/teacherupload' //改成您自己的上传接口
            ,accept: 'file'
            ,exts: 'txt|rar|zip|doc|docx|pdf|xls|xlsx|jpg|png' //允许上传的文件类型
            ,multiple: true
            ,auto: false
            ,bindAction: '#testListAction'
            ,choose: function(obj){
                var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function(index, file, result){
                    var tr = $(['<tr id="upload-'+ index +'">'
                        ,'<td>'+ file.name +'</td>'
                        ,'<td>'+ (file.size/1024).toFixed(1) +'kb</td>'
                        ,'<td>等待上传</td>'
                        ,'<td>'
                        ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                        ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                        ,'</td>'
                        ,'</tr>'].join(''));

                    //单个重传
                    tr.find('.demo-reload').on('click', function(){
                        obj.upload(index, file);
                    });

                    //删除
                    tr.find('.demo-delete').on('click', function(){
                        delete files[index]; //删除对应的文件
                        tr.remove();
                        uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                    });

                    demoListView.append(tr);
                });
            }
            ,done: function(res, index, upload){
                if (res.code != 0) {
                    files.push({"fileName":res.filename,"fileUrl":res.fileUrl,"fileSize":res.fileSize});//,"fileUrl":res.fileUrl
                    var json = JSON.stringify(files);
                    //将上传的文件信息加入到集合中并转换成json字符串
                    $("#fileJson").attr("value",json);

                    var fileUrl = res.fileUrl;
                    var tr = demoListView.find('tr#upload-'+ index)
                        ,tds = tr.children();
                    tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                    tds.eq(3).html('<span>完成</span>');
                    tds.eq(4).html(''); //清空操作
                    return delete this.files[index]; //删除文件队列已经上传成功的文件
                }
                this.error(index, upload);
            }
            ,error: function(res,index, upload){
                    var tr = demoListView.find('tr#upload-' + index)
                        , tds = tr.children();
                    tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                    tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传

            }
        })
    })
</script>
</body>
</html>
