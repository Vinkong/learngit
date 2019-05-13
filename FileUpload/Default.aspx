<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
   <script src="jquery-3.4.1.min.js"></script>
    <script src="jquery.form.js"></script>
 
    <style>

        .hidden{display:none;}
.upload-fileWrap {
    margin: 3px 0 0 -2px;
    position: relative;
}
.upload-input-file {
    position: absolute;
    left: 2px;
    top: 0;
    display: inline-block;
    width: 88px;
    height: 34px;
    line-height: 34px;
    opacity: 0;
    cursor: pointer;
    z-index: 2;
}
.upload-file-result {
    color: #a1acc6;
    font-size: 14px;
}
/*进度条*/
.progressWrap {
    position: absolute;
    right: 20px;
    top: 56px;
    width: 200px;
    height: 10px;
}
.progress {
    width: 100%;
    height: 20px;
    background: #0f1529;
    -webkit-border-radius: 20px;
    -moz-border-radius: 20px;
    border-radius: 20px;
    overflow: hidden;
}
.progress-bar {
    height: 20px;
    background: url("blue.jpg") repeat-x;
}
.progress-bar span {
    position: absolute;
    color: #58637e;
    font-size: 12px;
    line-height: 18px;
}
.progress-bar span.progress-bar-status {
    left: 50%;
    top: -23px;
    margin-left: -15px;
    color: #1cc3b0;
}
.upload-file-stateWrap {
    position: relative;
    width: 100%;
    height: auto;
}
.upload-file-stateWrap .progress {
    width: 60%;
}
.upload-file-stateWrap span.progress-bar-status {
    top: inherit;
    bottom: -3px;
    left: 60%;
    margin-left: 5px;
}


    </style>
    <script>
      

        function addfile() {
            var progress = $(".progress-bar"),
            status = $(".progress-bar-status"),
            percentVal = '0%';
            //上传步骤 
            var addvediofile = "";
            var filePath =$('#upload-input-file').val();
            var startIndex = filePath.lastIndexOf(".");
            if (startIndex != -1)
                addvediofile = filePath.substring(startIndex + 1, filePath.length).toLowerCase();
            else
                type = "";
            if (addvediofile != "mp4" && addvediofile != "rmvb" && addvediofile != "avi" && addvediofile != "ts") {

                alert("文件格式不对");
                $('#upload-input-file').val("");//介绍视频
                return;
            }

            var size = 0;
            size = $("#upload-input-file")[0].files[0].size; //byte
            size = size / 1024;//kb
            size = (size / 1024).toFixed(3);//mb
            if (size > 100) {

                alert("文件超过100M,无法上传");
                return;
            }
            $("#myupload").ajaxSubmit({
                url: './ashx/Handler.ashx',
                type: "post",
               beforeSend: function () {
                    $(".progress").removeClass("hidden");
                    progress.width(percentVal);
                    status.html(percentVal);
                     },
                uploadProgress: function (event, position, total, percentComplete) {
                    percentVal = percentComplete + '%';
                    progress.width(percentVal);
                    status.html(percentVal);
                    console.log(percentVal, position, total);
                },
                success: function (result) {
                    //alert(result);
                    percentVal = '100%';

                    progress.width(percentVal);
                    status.html(percentVal);
                    ////获取上传文件信息 
                    alert("上传成功");
                    
                    //uploadFileResult.push(result);
                    //// console.log(uploadFileResult); 
                    $(".upload-file-result").html(result);
                    $("#upload-input-file").val('');
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(errorThrown);
                    $(".upload-file-result").empty();
                }
            });
      




        }
          

 
    </script>
</head>
<body>
   <div class="upload-fileWrap">

    <form id='myupload' name='myupload'  enctype='multipart/form-data'>
        <input id="upload-input-file" class="" name="file" type="file"  data-value-update="input"/>
   
        <input type="button" onclick="addfile();"  value="提交"/>
   
    </form>
    <div class="upload-file-stateWrap">
        <div style="margin-top:100px;">  <span class="upload-file-result"></span>            </div>
      
        <div class="progress hidden">
            <div class="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
                <span class="progress-bar-status">0%</span>
            </div>
        </div>
    </div>
</div>

</body>
</html>
