<!-- 具体一个项目侧栏id下所有成果，不含子目录下的成果 -->
<!-- office下载模式，dwg下载模式 -->
<!DOCTYPE html>

<head>
  <link rel="stylesheet" type="text/css" href="/static/css/bootstrap.min.css" />
  <script type="text/javascript" src="/static/js/jquery-3.3.1.min.js"></script>
  <script type="text/javascript" src="/static/js/bootstrap.min.js"></script>
  <!-- <script src="/static/js/bootstrap-treeview.js"></script> -->
  <link rel="stylesheet" type="text/css" href="/static/css/bootstrap-table.min.css" />
  <script type="text/javascript" src="/static/js/jquery.tablesorter.min.js"></script>
  <script type="text/javascript" src="/static/js/bootstrap-table.min.js"></script>
  <script type="text/javascript" src="/static/js/bootstrap-table-zh-CN.min.js"></script>
  <script type="text/javascript" src="/static/js/bootstrap-table-export.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/static/font-awesome-4.7.0/css/font-awesome.min.css" />
  <script src="/static/js/tableExport.js"></script>
  <script type="text/javascript" src="/static/js/moment.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/static/css/webuploader.css">
  <script type="text/javascript" src="/static/js/webuploader.min.js"></script>
  <script type="text/javascript" src="/static/js/jquery-ui.min.js"></script>
  <script type="text/javascript" src="/static/js/clipboard.min.js"></script>
  <link rel="stylesheet" href="/static/froala/css/froala_editor.css">
  <link rel="stylesheet" href="/static/froala/css/froala_style.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/code_view.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/draggable.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/colors.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/emoticons.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/image_manager.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/image.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/line_breaker.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/table.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/char_counter.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/video.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/fullscreen.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/file.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/quick_insert.css">
  <link rel="stylesheet" href="/static/froala/css/plugins/help.css">
  <!-- <link rel="stylesheet" href="/static/froala/css/third_party/spell_checker.css"> -->
  <link rel="stylesheet" href="/static/froala/css/plugins/special_characters.css">
  <link rel="stylesheet" href="/static/froala/js/codemirror.min.css">
  <link rel="stylesheet" href="/static/froala/css/themes/red.css">
  <style type="text/css">
  #modalDialog .modal-header {
    cursor: move;
  }

  #modalDialog1 .modal-header {
    cursor: move;
  }

  #modalDialog2 .modal-header {
    cursor: move;
  }

  #modalDialog3 .modal-header {
    cursor: move;
  }

  #modalDialog4 .modal-header {
    cursor: move;
  }

  #modalDialog5 .modal-header {
    cursor: move;
  }

  #modalDialog6 .modal-header {
    cursor: move;
  }

  #modalDialog7 .modal-header {
    cursor: move;
  }

  #modalDialog8 .modal-header {
    cursor: move;
  }

  #modalDialog9 .modal-header {
    cursor: move;
  }

  #modalDialog10 .modal-header {
    cursor: move;
  }

  #modalDialog11 .modal-header {
    cursor: move;
  }

  /*#modalNewDwg .modal-header {cursor: move;}*/
  /*#modalFlow .modal-header {cursor: move;}*/
  /*body {
          text-align: center;
      }*/
  div#editor {
    width: 81%;
    margin: auto;
    text-align: left;
  }

  .ss {
    background-color: red;
  }

  div#modalTable2 {
    /*.modal .fade .in*/
    z-index: 3;
  }

  /*.form-horizontal .control-label{
        padding-left:10px; 
      }
      .form-horizontal .form-group{
        float: left;
        width: 50%;
      }*/
  h3 .share-icon {
    width: 30px;
    height: 30px
  }
  </style>
</head>

<body>
  <div class="col-lg-12">
    <!-- <h3>成果列表</h3> -->
    <div id="toolbar1" class="btn-group">

      <button type="button" data-name="addButton2" id="addButton2" class="btn btn-default"> <i class="fa fa-plus-square" title="文章模式">添加</i></button>
      <button type="button" data-name="deleteButton" id="deleteButton" class="btn btn-default"><i class="fa fa-trash">删除</i></button>
    </div>
    <!--data-click-to-select="true" -->
    <table id="table0"></table>
    <script type="text/javascript">
    $(function() {
      // 初始化【未接受】工作流表格showToggle:'true',
      $("#table0").bootstrapTable({
        url: '/article/getlist/{{.Id}}',
        method: 'get',
        search: 'true',
        showRefresh: 'true',

        showColumns: 'true',
        toolbar: '#toolbar1',
        pagination: 'true',
        sidePagination: "server",
        queryParamsType: '',
        //请求服务器数据时，你可以通过重写参数的方式添加一些额外的参数，例如 toolbar 中的参数 如果 queryParamsType = 'limit' ,返回参数必须包含
        // limit, offset, search, sort, order 否则, 需要包含: 
        // pageSize, pageNumber, searchText, sortName, sortOrder. 
        // 返回false将会终止请求。
        pageSize: 15,
        pageNumber: 1,
        pageList: [15, 50, 100],
        uniqueId: "id",
        // singleSelect:"true",
        clickToSelect: "true",
        showExport: "true",
        queryParams: function queryParams(params) { //设置查询参数
          var param = {
            limit: params.pageSize, //每页多少条数据
            pageNo: params.pageNumber, // 页码
            searchText: $(".search .form-control").val()
          };
          //搜索框功能
          //当查询条件中包含中文时，get请求默认会使用ISO-8859-1编码请求参数，在服务端需要对其解码
          // if (null != searchText) {
          //   try {
          //     searchText = new String(searchText.getBytes("ISO-8859-1"), "UTF-8");
          //   } catch (Exception e) {
          //     e.printStackTrace();
          //   }
          // }
          console.log(param)
          return param;
        },
        columns: [
          {
            title: '选择',
            // radio: 'true',
            checkbox: 'true',
            width: '10',
            align: "center",
            valign: "middle",
          },
          {
            field: 'Id',
            title: 'ID',
            align: "center",
            valign: "middle"
          },
          {
            field: 'Subtext',
            title: '标题',
            align: "center",
            valign: "middle"
          },
          {
            field: 'id',
            title: '文章',
            formatter: setArticle,
            events: actionEvents,
            align: "center",
            valign: "middle"
          },
          {
            field: 'Created',
            title: '建立时间',
            formatter: localDateFormatter,
            visible: "false",
            align: "center",
            valign: "middle"
          },
          {
            field: 'Updated',
            title: '更新时间',
            formatter: localDateFormatter,
            visible: "false",
            align: "center",
            valign: "middle"
          },
        ]
      });
    });

    function index1(value, row, index) {
      return index + 1
    }

    function localDateFormatter(value) {
      return moment(value, 'YYYY-MM-DD').format('YYYY-MM-DD');
    }

    function RelevFormatter(value) {
      if (value) {
        if (value.length == 1) { //'<a href="/project/product/article/'
          var array = value[0].Relevancy.split(",")
          var relevarray = new Array()
          for (i = 0; i < array.length; i++) {
            // relevarray[i]=array[i];
            relevarray[i] = '<a href="javascript:gototree(' + value[i].ProjectId + ')" title="查看" >' + value[i].Relevancy + '</a>';
          }
          return relevarray.join(",");
          // articleUrl= '<a href="'+value[0].Link+'/'+value[0].Id+'" title="查看" target="_blank"><i class="fa fa-file-text-o"></i></a>';
          // return articleUrl;
        } else if (value.length == 0) {

        } else if (value.length > 1) {
          var relevarray = new Array()
          for (i = 0; i < value.length; i++) {
            // relevarray[i]=value[i].Relevancy;
            relevarray[i] = '<a href="javascript:gototree(' + value[i].ProjectId + ')" title="查看" >' + value[i].Relevancy + '</a>';
          }
          return relevarray.join(",");
          // articleUrl= "<a class='article' href='javascript:void(0)' title='查看文章列表'><i class='fa fa-list-ol'></i></a>";
          // return articleUrl;
        }
      }
    }

    // 关联成果跳转到对应的树状目录下
    function gototree(e) {
      // $(window.parent.document).find("input:radio").attr("checked","true");
      // $('#objId', parent.document);
      // 格式：$("#父页面元素id" , parent.document);
      parent.gototree(e); // pClick 为父页面 js 方法
      // window.parent.document.getElementById("父窗口元素ID");
      // window.parent.document.getElementById("iframepage").src="/project/{{.Id}}/"+e;
      // var findCheckableNodess = function() {
      //   return $('#tree',parent.document).treeview('findNodes', [e, 'id']);
      // }; 
      // var checkableNodes = findCheckableNodess();
      //   $('#tree',parent.document).treeview('toggleNodeSelected', [ checkableNodes, { silent: true } ]);
      //   $('#tree',parent.document).treeview('toggleNodeExpanded', [ checkableNodes, { silent: true } ]);
      //   $('#tree',parent.document).treeview('revealNode', [ checkableNodes, { silent: true } ]);
    }

    function setCode(value, row, index) {
      return "<a href='/project/product/attachment/" + row.Id + "'>" + value + "</a>";
    }

    function setLable(value, row, index) {
      // alert(value);
      if (value) { //注意这里如果value未定义则出错，一定要加这个判断。
        var array = value.split(",")
        var labelarray = new Array()
        for (i = 0; i < array.length; i++) {
          labelarray[i] = "<a href='/project/product/keysearch?keyword=" + array[i] + "'>" + array[i] + "</a>";
        }
        return labelarray.join(",");
      }
    }

    function setCodetest(value, row, index) {
      //保留，数组和字符串以及循环的处理
      // array=value.split(",")
      // var labelarray = new Array() 
      // for (i=0;i<value.length;i++)//value是数组"Code":[数组"SL0001-510-08","SL0001-510-08"],
      // {
      //   labelarray[i]="<a href='/project/product/attachment/"+value[i]+"'>" + value[i] + "</a>";
      // }
      // if (value.match(",")!=null){
      if (value) {
        array = value.split(",")
        var labelarray = new Array()
        for (i = 0; i < array.length; i++) {
          labelarray[i] = "<a href='/project/product/attachment/" + array[i] + "'>" + array[i] + "</a>";
        }
        return labelarray.join(",");
      }
    }

    function setTitle(value, row, index) {
      return "<a href='/project/product/" + row.Id + "'>" + value + "</a>";
    }

    function setArticle(value, row, index) {
      articleUrl = '<a href="' + row.Link + '/' + row.Id + '" title="查看" target="_blank"><i class="fa fa-file-text-o"></i></a>';
      return articleUrl;
    }

    function setAttachment(value, row, index) {
      if (value) {
        if (value.length == 1) {
          // var ext =/\.[^\.]+/.exec(value[0].Title);//有问题
          var filename = value[0].Title;
          var index = filename.lastIndexOf(".");
          var ext = filename.substring(index);
          // alert(ext);
          if (ext == ".dwg") {
            attachUrl = '<a href="/downloadattachment?id=' + value[0].Id + '" title="下载" target="_blank"><i class="fa fa-codepen fa-lg" style="color:Black;"></i></a>';
          } else if (ext == ".doc" || ext == ".docx") {
            attachUrl = '<a href="/downloadattachment?id=' + value[0].Id + '" title="下载" target="_blank"><i class="fa fa-file-word-o fa-lg"></i></a>';
          } else if (ext == ".xls" || ext == ".xlsx") {
            attachUrl = '<a href="/downloadattachment?id=' + value[0].Id + '" title="下载" target="_blank"><i class="fa fa-file-excel-o fa-lg" style="color:LimeGreen;"></i></a>';
          } else if (ext == ".ppt" || ext == ".pptx") {
            attachUrl = '<a href="/downloadattachment?id=' + value[0].Id + '" title="下载" target="_blank"><i class="fa fa-file-powerpoint-o fa-lg" style="color:Red;"></i></a>';
          } else {
            attachUrl = '<a href="/downloadattachment?id=' + value[0].Id + '" title="下载" target="_blank"><i class="fa fa-paperclip"></i></a>';
          }
          return attachUrl;
        } else if (value.length == 0) {

        } else if (value.length > 1) {
          attachUrl = "<a class='attachment' href='javascript:void(0)' title='查看附件列表'><i class='fa fa-list-ol'></i></a>";
          return attachUrl;
        }
      }
      // $.ajax({//这种同步加载行不通，会混乱。异步又无法传出返回值data
      // type:"get",//这里是否一定要用post？？？
      // url:"/project/product/attachment/"+row.Id,
      // data: {CatalogId:row.Id},
      // dataType:'json',
      // async:false,//必须加这个异步为否定，即同步，否则bb传不出去
      // success:function(data,status){//数据提交成功时返回数据
      // $.each(data,function(i,d){
      //     $("#cars").append('<option value="' + data[i].Username + '"></option>');
      // });
      //         if (data.length==1){
      //           bb= '<a href="'+data[0].Link+'/'+data[0].Title+'" title="下载" target="_blank"><i class="fa fa-paperclip"></i></a>';
      //         }else if(data.length==0){

      //         }else if(data.length>1){
      //           bb= '<a class="attachment" href="javascript:void(0)" title="查看附件列表"><i class="fa fa-list-ol"></i></a>';
      //         } 
      //   }
      // });
      // return bb; 
      // return '<a class="attachment" href="javascript:void(0)" title="attachment"><i class="fa fa-paperclip"></i></a>';
    }

    function setPdf(value, row, index) {
      if (value) {
        if (value.length == 1) {
          pdfUrl = '<a href="/pdf?id=' + value[0].Id + '" title="打开pdf" target="_blank"><i class="fa fa-file-pdf-o"></i></a>';
          return pdfUrl;
        } else if (value.length == 0) {

        } else if (value.length > 1) {
          pdfUrl = "<a class='pdf' href='javascript:void(0)' title='查看pdf列表'><i class='fa fa-list-ol'></i></a>";
          return pdfUrl;
        }
      }
    }

    function setDocState(value, row, index) {
      if (value.Name) {
        return "<a href='/cms/#/flow/documentdetail2?docid=" + row.ProdDoc.DocumentId + "&dtid=" + row.ProdDoc.DocTypeId + "'target='_blank'>" + value.Name + "</a>";
      }
    }

    window.actionEvents = {
      'click .article': function(e, value, row, index) {
        var site = /http:\/\/.*?\//.exec(value[1].Link); //非贪婪模式 
        if (site) {
          $('#articles').bootstrapTable('refresh', { url: '/project/product/syncharticles?site=' + site + '&id=' + row.Id });
        } else {
          $('#articles').bootstrapTable('refresh', { url: '/project/product/articles/' + row.Id });
        }
        $('#modalarticle').modal({
          show: true,
          backdrop: 'static'
        });
      },
      'click .attachment': function(e, value, row, index) {
        // for(var i=0;i<value.length;i++)
        // alert(value[i].Link);
        // var ret=/http:(.*)\:/.exec(value[i].Link);//http://127.0.0.1:
        var site = /http:\/\/.*?\//.exec(value[1].Link); //非贪婪模式 
        if (site) { //跨域
          // alert("1");
          // $.getJSON(ret+'project/product/attachment/'+row.Id,function(){
          // $('#attachs').bootstrapTable('load', randomData());
          // })
          $('#attachs').bootstrapTable('refresh', { url: '/project/product/synchattachment?site=' + site + '&id=' + row.Id });
          // $('#attachs').bootstrapTable('refresh', {url:site+'project/product/attachment/'+row.Id});
        } else {
          // alert("2");
          $('#attachs').bootstrapTable('refresh', { url: '/project/product/attachment/' + row.Id });
        }
        $('#modalattach').modal({
          show: true,
          backdrop: 'static'
        });
      },

      'click .pdf': function(e, value, row, index) {
        var site = /http:\/\/.*?\//.exec(value[1].Link); //非贪婪模式 
        if (site) { //跨域
          $('#pdfs').bootstrapTable('refresh', { url: '/project/product/synchpdf?site=' + site + '&id=' + row.Id });
        } else {
          $('#pdfs').bootstrapTable('refresh', { url: '/project/product/pdf/' + row.Id });
        }
        $('#modalpdf').modal({
          show: true,
          backdrop: 'static'
        });
      },
    };

    //最后面弹出文章列表中用的_根据上面的click，弹出模态框，给模态框中的链接赋值
    function setArticlecontent(value, row, index) {
      articleUrl = '<a href="' + value + '" title="下载" target="_blank"><i class="fa fa-file-text-o"></i></a>';
      return articleUrl;
    }
    //最后面弹出附件列表中用的<a href="'+value+
    function setAttachlink(value, row, index) {
      attachUrl = '<a href="/downloadattachment?id=' + row.Id + '" title="下载" target="_blank"><i class="fa fa-paperclip"></i></a>';
      return attachUrl;
    }
    //最后面弹出pdf列表中用的'&file='+value+
    function setPdflink(value, row, index) {
      pdfUrl = '<a href="/pdf?id=' + row.Id + '" title="下载" target="_blank"><i class="fa fa-file-pdf-o"></i></a>';
      return pdfUrl;
    }

    // 批量上传
    $("#addButton").click(function() {
      // if ({{.role}}!=1){
      //   alert("权限不够！"+{{.role}});
      //   return;
      // }
      if ({{.RoleAdd }} != "true") {
        alert("权限不够！");
        return;
      }
      $("input#pid").remove();
      var th1 = "<input id='pid' type='hidden' name='pid' value='" + {{.Id }} + "'/>"
      $(".modal-body").append(th1);

      $('#modalTable').modal({
        show: true,
        backdrop: 'static'
      });
    })

    $(document).ready(function() {
      $list1 = $('#thelist');
      $btn = $('#ctlBtn');
      state = 'pending';
      // $('#modalTable').on('shown.bs.modal',function(e){
      var allMaxSize = 500;
      var uploader = WebUploader.create({
        // 不压缩image
        resize: false,
        fileSingleSizeLimit: 20 * 1024 * 1024, //限制大小20M，单文件
        fileSizeLimit: allMaxSize * 1024 * 1024, //限制大小500M，所有被选文件，超出选择不上
        // swf文件路径fex-team-webuploader/dist
        swf: '/static/js/Uploader.swf',
        // 文件接收服务端。
        server: '/project/product/addattachment',
        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#picker',
        // 只允许选择规定文件类型。
        accept: {
          title: 'Images',
          extensions: 'png,jpg,jpeg,gif,bmp,flv,swf,mkv,avi,rm,rmvb,mpeg,mpg,ogg,ogv,mov,wmv,mp4,webm,mp3,wav,mid,rar,zip,tar,gz,7z,bz2,cab,iso,doc,docx,xls,xlsx,ppt,pptx,pdf,txt,md,xml,dwg,dgn,txt',
          mimeTypes: '*/*'
        }
      });
      /**
       * 验证文件格式以及文件大小
       */
      uploader.on("error", function(type) {
        if (type == "F_DUPLICATE") {
          alert("请不要重复选择文件！");
        } else if (type == "Q_EXCEED_SIZE_LIMIT") {
          alert("所选附件总大小不可超过" + allMaxSize + "M！多分几次传吧！");
        } else if (type == "Q_TYPE_DENIED") {
          alert("请上传图片、视频、文档、图纸、压缩等格式文件");
        } else if (type == "F_EXCEED_SIZE") {
          alert("单个文件大小不能超过10M");
        }
      });

      // 当有文件添加进来的时候
      uploader.on('fileQueued', function(file) {
        $list1.append('<div id="' + file.id + '" class="item">' +
          '<h4 class="info">' + file.name + '</h4>' +
          '<p class="state">等待上传...</p>' +
          '</div>');
      });

      //传递参数——成果id
      uploader.on('startUpload', function() { //uploadBeforeSend——这个居然不行？
        // if (prodlabel){
        var pid = $('#pid').val();
        var prodlabel = $('#prodlabel').val();
        var prodprincipal = $('#prodprincipal').val();
        uploader.option('formData', {
          "pid": pid,
          "prodlabel": prodlabel,
          "prodprincipal": prodprincipal
        });
      });

      // 文件上传过程中创建进度条实时显示。
      uploader.on('uploadProgress', function(file, percentage) {
        var $li = $('#' + file.id),
          $percent = $li.find('.progress .progress-bar');
        // 避免重复创建
        if (!$percent.length) {
          $percent = $('<div class="progress progress-striped active">' +
            '<div class="progress-bar" role="progressbar" style="width: 0%">' +
            '</div>' +
            '</div>').appendTo($li).find('.progress-bar');
        }
        $li.find('p.state').text('上传中');
        $percent.css('width', percentage * 100 + '%');
      });

      uploader.on('uploadSuccess', function(file) {
        $('#' + file.id).find('p.state').text('已上传');
      });

      uploader.on('uploadError', function(file) {
        $('#' + file.id).find('p.state').text('上传出错');
      });

      uploader.on('uploadComplete', function(file) {
        $('#' + file.id).find('.progress').fadeOut();
        $('#table0').bootstrapTable('refresh', { url: '/article/getlist/' + {{.Id }}});
      });

      uploader.on('all', function(type) {
        if (type === 'startUpload') {
          state = 'uploading';
        } else if (type === 'stopUpload') {
          state = 'paused';
        } else if (type === 'uploadFinished') {
          state = 'done';
        }
        if (state === 'uploading') {
          $btn.text('暂停上传');
        } else {
          $btn.text('开始上传');
        }
      });

      $btn.on('click', function() {
        if (state === 'uploading') {
          uploader.stop();
        } else {
          uploader.upload();
        }
      });

      $('#picker').mouseenter(function() {
        uploader.refresh();
      })

      $('#modalTable').on('hide.bs.modal', function() {
        $list1.text("");
        // uploader.destroy();//销毁uploader
      })
      // });
    })

    // 多附件模式
    $("#addButton1").click(function() {
      // if ({{.role}}!=1){
      //   alert("权限不够！");
      //   return;
      // }
      if ({{.RoleAdd }} != "true") {
        alert("权限不够！");
        return;
      }
      $("input#pid").remove();
      var th1 = "<input id='pid' type='hidden' name='pid' value='" + {{.Id }} + "'/>"
      $(".modal-body").append(th1);
      $('#modalTable1').modal({
        show: true,
        backdrop: 'static'
      });
    })

    $(document).ready(function() {
      $list = $('#thelist1');
      $btn = $('#ctlBtn1');
      state = 'pending';
      $('#modalTable1').on('shown.bs.modal', function(e) {
        var uploader = WebUploader.create({
          // 不压缩image
          resize: false,
          // swf文件路径fex-team-webuploader/dist
          swf: '/static/js/Uploader.swf',
          // 文件接收服务端。
          server: '/project/product/addattachment2',
          // 选择文件的按钮。可选。
          // 内部根据当前运行是创建，可能是input元素，也可能是flash.
          pick: '#picker1'
        });

        // 当有文件添加进来的时候
        uploader.on('fileQueued', function(file) {
          $list.append('<div id="' + file.id + '" class="item">' +
            '<h4 class="info">' + file.name + '</h4>' +
            '<p class="state">等待上传...</p>' +
            '</div>');
        });

        //传递参数——成果id
        uploader.on('startUpload', function() { //uploadBeforeSend——这个居然不行？
          var pid = $('#pid').val();
          var prodcode = $('#prodcode').val();
          var prodname = $('#prodname').val();
          var prodlabel = $('#prodlabel1').val();
          var prodprincipal = $('#prodprincipal1').val();
          var relevancy = $('#relevancy1').val();
          // var html = ue.getContent();
          // alert(html);
          uploader.option('formData', {
            "pid": pid,
            "prodcode": prodcode,
            "prodname": prodname,
            "prodlabel": prodlabel,
            "prodprincipal": prodprincipal,
            "relevancy": relevancy
            // 'content':html,
            // {'tnumber':a,'title':b,'categoryid':c,'category':d,'content':e}
          });
        });

        // 文件上传过程中创建进度条实时显示。
        uploader.on('uploadProgress', function(file, percentage) {
          var $li = $('#' + file.id),
            $percent = $li.find('.progress .progress-bar');
          // 避免重复创建
          if (!$percent.length) {
            $percent = $('<div class="progress progress-striped active">' +
              '<div class="progress-bar" role="progressbar" style="width: 0%">' +
              '</div>' +
              '</div>').appendTo($li).find('.progress-bar');
          }
          $li.find('p.state').text('上传中');
          $percent.css('width', percentage * 100 + '%');
        });

        uploader.on('uploadSuccess', function(file) {
          $('#' + file.id).find('p.state').text('已上传');
        });

        uploader.on('uploadError', function(file) {
          $('#' + file.id).find('p.state').text('上传出错');
        });

        uploader.on('uploadComplete', function(file) {
          $('#' + file.id).find('.progress').fadeOut();
          $('#table0').bootstrapTable('refresh', { url: '/article/getlist/' + {{.Id }}});
        });

        uploader.on('all', function(type) {
          if (type === 'startUpload') {
            state = 'uploading';
          } else if (type === 'stopUpload') {
            state = 'paused';
          } else if (type === 'uploadFinished') {
            state = 'done';
          }
          if (state === 'uploading') {
            $btn.text('暂停上传');
          } else {
            $btn.text('开始上传');
          }
        });

        $btn.on('click', function() {
          var prodcode = $('#prodcode').val();
          var prodname = $('#prodname').val();
          if (prodcode && prodname) {
            if (state === 'uploading') {
              uploader.stop();
            } else {
              uploader.upload();
            }
          } else {
            alert("编号和名称不能为空" + prodcode + prodname);
          }
        });

        $('#modalTable1').on('hide.bs.modal', function() {
          $list.text("");
          uploader.destroy(); //销毁uploader
        })
      });
    })

    //****添加文章
    $("#addButton2").click(function() {

      {{/*if ({{.RoleAdd }} != "true") {*/}}
      {{/*  alert("权限不够！");*/}}
      {{/*  return;*/}}
      {{/*}*/}}
      if({{.Id}} == 0){
        alert("请在左侧选择类型!");
        return;
      }
      $("input#pid").remove();
      var th1 = "<input id='pid' type='text' name='pid' value='" + {{.Id }} + "'/>"
      $(".modal-body").append(th1);

      $('#modalTable2').modal({
        show: true,
        backdrop: 'static'
      });
    })

    // 编辑成果信息
    $("#editorProdButton").click(function() {
      var selectRow = $('#table0').bootstrapTable('getSelections');
      if (selectRow.length < 1) {
        alert("请先勾选成果！");
        return;
      }
      if (selectRow.length > 1) {
        alert("请不要勾选一个以上成果！");
        return;
      }
      if (selectRow[0].Uid === {{.Uid }} || {{.RoleUpdate }} == "true") {
        if (selectRow[0].Attachmentlink[0]) { //||selectRow[0].Pdflink[0].Link||selectRow[0].Articlecontent[0].Link)
          var site = /http:\/\/.*?\//.exec(selectRow[0].Attachmentlink[0].Link); //非贪婪模式 
        }
        if (selectRow[0].Articlecontent[0]) {
          var site = /http:\/\/.*?\//.exec(selectRow[0].Articlecontent[0].Link); //非贪婪模式 
        }
        if (selectRow[0].Pdflink[0]) {
          var site = /http:\/\/.*?\//.exec(selectRow[0].Pdflink[0].Link); //非贪婪模式 
        }
        if (site) {
          alert("同步成果不允许！");
          return;
        }

        $("input#cid").remove();
        var th1 = "<input id='cid' type='hidden' name='cid' value='" + selectRow[0].Id + "'/>"
        $(".modal-body").append(th1); //这里是否要换名字$("p").remove();
        $("#prodcode3").val(selectRow[0].Code);
        $("#prodname3").val(selectRow[0].Title);
        $("#prodlabel3").val(selectRow[0].Label);
        $("#prodprincipal3").val(selectRow[0].Principal);
        var value = selectRow[0].Relevancy
        var relevancy3
        if (value) {
          if (value.length == 1) { //'<a href="/project/product/article/'
            var array = value[0].Relevancy.split(",")
            var relevarray = new Array()
            for (i = 0; i < array.length; i++) {
              relevarray[i] = array[i];
            }
            relevancy3 = relevarray.join(",");
          } else if (value.length > 1) {
            var relevarray = new Array()
            for (i = 0; i < value.length; i++) {
              relevarray[i] = value[i].Relevancy;
            }
            relevancy3 = relevarray.join(",");
          }
        }
        $("#relevancy3").val(relevancy3);
        $('#modalProdEditor').modal({
          show: true,
          backdrop: 'static'
        });
      } else {
        alert("权限不够！" + selectRow[0].Uid);
        return;
      }
    })

    // 编辑成果附件——删除附件、文章或追加附件
    var selectrowid;
    $("#editorAttachButton").click(function() {
      // if ({{.role}}!=1){
      //   alert("权限不够！");
      //   return;
      // }
      var selectRow = $('#table0').bootstrapTable('getSelections');
      if (selectRow.length < 1) {
        alert("请先勾选成果！");
        return;
      }
      if (selectRow.length > 1) {
        alert("请不要勾选一个以上成果！");
        return;
      }

      if ({{.Uid }} == 0) {
        alert("权限不足！");
        return;
      }

      if (selectRow[0].Uid === {{.Uid }} || {{.RoleDelete }} == "true") {

        if (selectRow[0].Attachmentlink[0]) { //||selectRow[0].Pdflink[0].Link||selectRow[0].Articlecontent[0].Link)
          var site = /http:\/\/.*?\//.exec(selectRow[0].Attachmentlink[0].Link); //非贪婪模式 
        }
        if (selectRow[0].Articlecontent[0]) {
          var site = /http:\/\/.*?\//.exec(selectRow[0].Articlecontent[0].Link); //非贪婪模式 
        }
        if (selectRow[0].Pdflink[0]) {
          var site = /http:\/\/.*?\//.exec(selectRow[0].Pdflink[0].Link); //非贪婪模式 
        }
        if (site) {
          alert("同步成果不允许！");
          return;
        }
        selectrowid = selectRow[0].Id;
        $("input#pid").remove();
        var th1 = "<input id='pid' type='hidden' name='pid' value='" + selectRow[0].Id + "'/>"
        $(".modal-body").append(th1); //这里是否要换名字$("p").remove();
        $('#attachments').bootstrapTable('refresh', { url: '/project/product/allattachments/' + selectRow[0].Id }); //取得所有附件列表和文章列表
        $('#modalAttachEditor').modal({
          show: true,
          backdrop: 'static'
        });

      } else {
        alert("权限不够！" + selectRow[0].Uid);
        return;
      }
    })

    $(document).ready(function() {
      var uploader;
      $('#modalAttachEditor').on('shown.bs.modal', function() {
        // var $ = jQuery,
        $list2 = $('#thelist2'),
          $btn = $('#ctlBtn2'),
          state = 'pending',
          // uploader;
          uploader = WebUploader.create({
            // 不压缩image
            resize: false,
            // swf文件路径fex-team-webuploader/dist
            swf: '/static/js/Uploader.swf',
            // 文件接收服务端。
            server: '/project/product/updateattachment',
            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#picker2'
          });
        // 当有文件添加进来的时候
        uploader.on('fileQueued', function(file) {
          $list2.append('<div id="' + file.id + '" class="item">' +
            '<h4 class="info">' + file.name + '</h4>' +
            '<p class="state">等待上传...</p>' +
            '</div>');
        });

        //传递参数——成果id
        uploader.on('startUpload', function() { //uploadBeforeSend——这个居然不行？
          var pid = $('#pid').val();
          uploader.option('formData', {
            "pid": pid,
          });
        });

        // 文件上传过程中创建进度条实时显示。
        uploader.on('uploadProgress', function(file, percentage) {
          var $li = $('#' + file.id),
            $percent = $li.find('.progress .progress-bar');
          // 避免重复创建
          if (!$percent.length) {
            $percent = $('<div class="progress progress-striped active">' +
              '<div class="progress-bar" role="progressbar" style="width: 0%">' +
              '</div>' +
              '</div>').appendTo($li).find('.progress-bar');
          }
          $li.find('p.state').text('上传中');
          $percent.css('width', percentage * 100 + '%');
        });

        uploader.on('uploadSuccess', function(file) {
          $('#' + file.id).find('p.state').text('已上传');
        });

        uploader.on('uploadError', function(file) {
          $('#' + file.id).find('p.state').text('上传出错');
        });

        uploader.on('uploadComplete', function(file) {
          $('#' + file.id).find('.progress').fadeOut();
          $('#attachments').bootstrapTable('refresh', { url: '/project/product/allattachments/' + selectrowid });
          $('#table0').bootstrapTable('refresh', { url: '/article/getlist/' + {{.Id }}});
        });

        uploader.on('all', function(type) {
          if (type === 'startUpload') {
            state = 'uploading';
          } else if (type === 'stopUpload') {
            state = 'paused';
          } else if (type === 'uploadFinished') {
            state = 'done';
          }
          if (state === 'uploading') {
            $btn.text('暂停上传');
          } else {
            $btn.text('开始上传');
          }
        });

        $btn.on('click', function() {
          if (state === 'uploading') {
            uploader.stop();
          } else {
            uploader.upload();
          }
        });
      })

      $('#modalAttachEditor').on('hide.bs.modal', function() {
        $list2.text("");
        uploader.destroy(); //销毁uploader
      })
    })

    // 删除
    $("#deleteButton").click(function() {
      var selectRow = $('#table0').bootstrapTable('getSelections');
      if (selectRow.length <= 0) {
        alert("请先勾选成果！");
        return false;
      }
      console.log(selectRow)
      if (confirm("确定删除吗？一旦删除将无法恢复！")) {
        var id = $.map(selectRow, function(row) {
          return row.Id;
        })
        console.log(id)
        var ids = "";
        for (var i = 0; i < selectRow.length; i++) {
          if (i == 0) {
            ids = selectRow[i].Id;
          } else {
            ids = ids + "," + selectRow[i].Id;
          }
        }
        console.log(ids)
        $.ajax({
          type: "post",
          url: "/project/product/delarticle",
          data: { ids: ids },
          success: function(data, status) {
            if (data != "ok") {
              alert("无权限删除");
            } else {
              alert("删除“" + data + "”成功！(status:" + status + ".)");

            }
            //刷新
            $('#table0').bootstrapTable('refresh', { url: '/article/getlist/' + {{.Id }}});

          }
        });
      }

    })

    // 成果流程
    $("#flowButton").click(function() {
      var selectRow = $('#table0').bootstrapTable('getSelections');
      if (selectRow.length <= 0) {
        alert("请先勾选成果！");
        return false;
      }
      //问题：如果多选，而其中有自己的，也有自己不具备权限的********
      if ({{.Uid }} == 0) {
        alert("权限不足！");
        return;
      }

      if (selectRow[0].Uid === {{.Uid }} || {{.RoleFlow }} == "true") {
        if (selectRow[0].Attachmentlink[0]) { //||selectRow[0].Pdflink[0].Link||selectRow[0].Articlecontent[0].Link)
          var site = /http:\/\/.*?\//.exec(selectRow[0].Attachmentlink[0].Link); //非贪婪模式 
        }
        if (selectRow[0].Articlecontent[0]) {
          var site = /http:\/\/.*?\//.exec(selectRow[0].Articlecontent[0].Link); //非贪婪模式 
        }
        if (selectRow[0].Pdflink[0]) {
          var site = /http:\/\/.*?\//.exec(selectRow[0].Pdflink[0].Link); //非贪婪模式 
        }
        if (site) {
          alert("同步成果不允许！");
          return;
        }

        var title = $.map(selectRow, function(row) {
          return row.Title;
        })

        var ids = "";
        for (var i = 0; i < selectRow.length; i++) {
          if (i == 0) {
            ids = selectRow[i].Id;
          } else {
            ids = ids + "," + selectRow[i].Id;
          }
        }
        $("div#flowattachment").remove();
        $("div#flowdocname").remove();
        // var th1="<input id='pid' type='hidden' name='pid' value='" +{{.Id}}+"'/>"
        var th1 = "<div id='flowattachment' class='form-group must'><label class='col-sm-3 control-label'>成果id</label><div class='col-sm-7'><input type='tel' class='form-control' id='flowdata_attachment' name='flowdata_attachment' value=" + ids + "></div></div>"
        var th2 = "<div id='flowdocname' class='form-group must'><label class='col-sm-3 control-label'>成果名称</label><div class='col-sm-7'><input type='tel' class='form-control' id='flowdata_docname' name='flowdata_docname' value=" + title + "></div></div>"
        $(".modal-body-content").append(th1);
        $(".modal-body-content").append(th2);

        // $("#doctype").append('<option value="a">项目模板</option>');
        $.ajax({
          type: "get",
          url: "/v1/admin/flowtypelist?page=1&limit=10",
          success: function(data, status) {
            $.each(data.doctypes, function(i, d) {
              $("#doctype").append('<option value="' + d.ID + '">' + d.Name + '</option>');
            });
          },
        });
        $.ajax({
          type: "get",
          url: "/v1/admin/flowaccesscontextlist?page=1&limit=10",
          success: function(data, status) {
            $.each(data.accesscontexts, function(i, d) {
              $("#accesscontext").append('<option value="' + d.ID + '">' + d.Name + '</option>');
            });
          },
        });
        $.ajax({
          type: "get",
          url: "/v1/admin/flowgrouplist?page=1&limit=10",
          success: function(data, status) {
            $.each(data.groups, function(i, d) {
              $("#group").append('<option value="' + d.ID + '">' + d.Name + '</option>');
            });
          },
        });

        $('#modalFlow').modal({
          show: true,
          backdrop: 'static'
        });

      } else {
        alert("权限不够！" + selectRow[0].Uid);
        return;
      }
    })

    // 新建dwg文件
    $("#newdwgButton").click(function() {
      if ({{.RoleNewDwg }} != "true") {
        alert("权限不够！");
        return;
      }
      $("input#pid").remove();
      var th1 = "<input id='pid' type='hidden' name='pid' value='" + {{.Id }} + "'/>"
      $(".modal-body").append(th1);
      $('#modalNewDwg').modal({
        show: true,
        backdrop: 'static'
      });
    })

    // 分享成果
    $("#shareButton").click(function() {
      var selectRow = $('#table0').bootstrapTable('getSelections');
      if (selectRow.length < 1) {
        alert("请先勾选成果！");
        return;
      }
      if (selectRow[0].Uid === {{.Uid }} || {{.RoleGet }} == "true") {
        $("div#flowattachment").remove();
        $("div#flowdocname").remove();
        $('#modalShareExpireTime').modal({
          show: true,
          backdrop: 'static'
        });
      } else {
        alert("权限不够！" + selectRow[0].Uid);
        return;
      }
    })

    //分享生成
    function createShare() {
      var selectRow = $('#table0').bootstrapTable('getSelections');
      var ids = "";
      var expireInfinity = "";
      var expireTime = "";
      for (var i = 0; i < selectRow.length; i++) {
        if (i == 0) {
          ids = selectRow[i].Id;
        } else {
          ids = ids + "," + selectRow[i].Id;
        }
      }
      // ?matterUuids=1&expireInfinity=true&expireTime=1
      var expiretime = $('#expiretime').val();
      console.log(expireTime)
      if (expiretime == "INFINITY") {
        expireInfinity = "true";
        expireTime = moment().format('YYYY-MM-DD HH:mm:ss'); //getdate()
      } else if (expiretime == "HOUR") {
        expireInfinity = "false"
        expireTime = moment().add(1, 'hours').format('YYYY-MM-DD HH:mm:ss');
      } else if (expiretime == "DAY") {
        expireInfinity = "false"
        expireTime = moment().add(1, 'days').format('YYYY-MM-DD HH:mm:ss');
      } else if (expiretime == "WEEK") {
        expireInfinity = "false"
        expireTime = moment().add(1, 'weeks').format('YYYY-MM-DD HH:mm:ss');
      } else if (expiretime == "MONTH") {
        expireInfinity = "false"
        expireTime = moment().add(1, 'months').format('YYYY-MM-DD HH:mm:ss');
      } else if (expiretime == "YEAR") {
        expireInfinity = "false"
        expireTime = moment().add(1, 'years').format('YYYY-MM-DD HH:mm:ss');
      }
      $.ajax({
        type: "post",
        url: "/v1/share/create",
        data: { matterUuids: ids, expireInfinityStr: expireInfinity, expireTimeStr: expireTime },
        success: function(data, status) {
          $('#modalShareExpireTime').modal('hide');

          $("input#cid").remove();
          // var th1 = "<input id='cid' type='hidden' name='cid' value='" + selectRow[0].Id + "'/>"
          // $(".modal-body").append(th1); //这里是否要换名字$("p").remove();
          document.getElementById("sharetitle").innerText = data.data.name;
          document.getElementById("username").innerText = data.data.username;
          // document.getElementById("uuid").innerText='https://zsj.itdos.com/share/detail/'+data.data.uuid;
          // document.getElementById("uuid").append('<a title="复制链接" class="mr15"><i class="fa fa-copy"></i></a>');
          document.getElementById("uuid").innerHTML = '<span id="copyuuid">https://zsj.itdos.com/v1/share/detail/' + data.data.uuid + '</span><a title="复制链接" class="mr15" data-clipboard-target="#copyuuid"><i class="fa fa-copy"></i></a>'
          document.getElementById("code").innerHTML = '<span id="copycode">' + data.data.code + '</span><a title="复制提取码" class="mr15" data-clipboard-target="#copycode"><i class="fa fa-copy"></i></a>';

          document.getElementById("expireTime").innerText = moment(data.data.expireTime).format('YYYY-MM-DD HH:mm:ss')
          $('#modalShare').modal({
            show: true,
            backdrop: 'static'
          });
        },
      });
    }

    new ClipboardJS('.mr15', {
      container: document.getElementById('copyuuid')
    });
    new ClipboardJS('.mr15', {
      container: document.getElementById('copycode')
    });

    function copyuuid() {
      var clipboard = new ClipboardJS("#btncopy", {
        text: function() {
          //寻找被激活的那个div pre元素,同时获取它下面的内容
          return '链接:' + $("span#copyuuid").text() + ' 提取码:' + $("span#copycode").text();
        }
      });
      clipboard.on('success', function(e) {
        alert("复制成功，去粘贴试试吧！");
        //可执行其他代码操作
      });
      clipboard.on('error', function(e) {
        alert("复制失败！请手动复制")
      });
    }

    // var clipboard = new ClipboardJS(".mr15",{
    //     text : function(){
    //         //寻找被激活的那个div pre元素,同时获取它下面的内容
    //         return $("span#copyuuid").text();
    //     }
    // });

    // clipboard.on('success',function(e){
    //     alert("已复制到粘贴板！");
    //     console.log(e);
    // });

    // clipboard.on('error',function(e){
    //     console.log(e);
    // });


    function getdate() {
      var nowdate = new Date();
      //用yyyy-MM-dd HH:mm:ss的格式输出
      var year = nowdate.getFullYear(); //年
      var month = nowdate.getMonth() > 9 ? nowdate.getMonth() : "0" + nowdate.getMonth(); //月
      var day = nowdate.getDate() > 9 ? nowdate.getDate() : "0" + nowdate.getMonth(); //日
      var hours = nowdate.getHours() > 9 ? nowdate.getHours() : "0" + nowdate.getHours(); //时
      var minutes = nowdate.getMinutes() > 9 ? nowdate.getMinutes() : "0" + nowdate.getMinutes(); //分
      var seconds = nowdate.getSeconds() > 9 ? nowdate.getSeconds() : "0" + nowdate.getSeconds(); //秒

      var mydate = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;

      return mydate;
    }
    </script>
    <!-- 添加文章 -->
    <div class="form-horizontal">
      <div class="modal fade" id="modalTable2">
        <div class="modal-dialog" style="width: 100%" id="modalDialog2">
          <div class="modal-content">
            <div class="modal-header" style="background-color: #FF5722;">
              <button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
              </button>
              <h3 class="modal-title">添加文章</h3>
            </div>
            <div class="modal-body">
              <div class="modal-body-content">
                <div class="form-group must" style="float: left;width: 50%;">
                  <label class="col-sm-3 control-label" style="padding-left:10px;">标题</label>
                  <div class="col-sm-7">
                    <input type="tel" class="form-control" id="subtext1" name="subtext1"></div>
                </div>
              </div>
              <label class="control-label">文章正文:</label>
              <div id="editor" style="width: 100%;padding: 10px">
                <div id='edit' style="margin-top: 30px;">
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
              <button type="button" class="btn btn-primary" onclick="save2()">保存</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- 文章列表 -->
    <div class="form-horizontal">
      <div class="modal fade" id="modalarticle">
        <div class="modal-dialog" id="modalDialog3">
          <div class="modal-content">
            <div class="modal-header" style="background-color: #8bc34a">
              <button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
              </button>
              <h3 class="modal-title">文章列表</h3>
            </div>
            <div class="modal-body">
              <div class="modal-body-content">
                <!-- <div id="pdfs" style="display:none"> -->
                <!-- <h3>工程目录分级</h3> -->
                <table id="articles" data-toggle="table" data-page-size="5" data-page-list="[5, 25, 50, All]" data-unique-id="id" data-pagination="true" data-side-pagination="client" data-click-to-select="true">
                  <thead>
                    <tr>
                      <th data-width="10" data-checkbox="true"></th>
                      <th data-formatter="index1">#</th>
                      <th data-field="Title">名称</th>
                      <th data-field="Subtext">副标题</th>
                      <th data-field="Link" data-formatter="setArticlecontent">查看</th>
                      <th data-field="Created" data-formatter="localDateFormatter">建立时间</th>
                      <th data-field="Updated" data-formatter="localDateFormatter">修改时间</th>
                    </tr>
                  </thead>
                </table>
                <!-- </div> -->
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 分享过期时间选择 -->
    <div class="form-horizontal">
      <div class="modal fade" id="modalShareExpireTime">
        <div class="modal-dialog" id="modalDialog10">
          <div class="modal-content">
            <div class="modal-header" style="background-color: #8bc34a">
              <button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
              </button>
              <h3 class="modal-title">分享</h3>
            </div>
            <div class="modal-body">
              <div class="modal-body-content">
                <div class="form-group must">
                  <label class="col-sm-3 control-label">有效期</label>
                  <div class="col-sm-7">
                    <select name="expiretime" id="expiretime" class="form-control" required placeholder="选择有效期：">
                      <option value="HOUR">1小时</option>
                      <option value="DAY" selected>1天</option>
                      <option value="WEEK">1周</option>
                      <option value="MONTH">1个月</option>
                      <option value="YEAR">1年</option>
                      <option value="INFINITY">永远有效</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary btn-sm mr5" onclick="createShare()">分享</button>
              <button type="button" class="btn btn-default  btn-sm mr5" data-dismiss="modal">关闭</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- 分享结果信息 -->
    <div class="form-horizontal">
      <div class="modal fade" id="modalShare">
        <div class="modal-dialog" id="modalDialog11">
          <div class="modal-content">
            <div class="modal-header" style="background-color: #8bc34a">
              <button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
              </button>
              <h3 class="modal-title"><img src="/static/eyeblue/img/archive.77d78eb7.svg" class="share-icon">分享成果信息</h3>
            </div>
            <div class="modal-body">
              <div class="modal-body-content">
                <!-- <div class="container"> -->
                <dl class="dl-horizontal">
                  <dt><span class="italic"><i class="fa fa-check text-success"></i></span>分享成功：</dt>
                  <dd id="sharetitle"></dd>
                  <dt>分享者：</dt>
                  <dd id="username" value=""></dd>
                  <dt>失效时间：</dt>
                  <dd id="expireTime"></dd>
                  <dt>链接:</dt>
                  <dd id="uuid"></dd>
                  <dt>提取码：</dt>
                  <dd id="code"></dd>
                </dl>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary copy" id="btncopy" onclick="copyuuid()">复制链接+提取码</button>
              <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- <script type="text/javascript" src="/static/froala/js/jquery.min.1.11.0.js"></script> -->
  <script type="text/javascript" src="/static/froala/js/codemirror.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/xml.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/froala_editor.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/align.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/char_counter.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/code_beautifier.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/code_view.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/colors.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/draggable.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/emoticons.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/entities.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/file.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/font_size.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/font_family.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/fullscreen.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/image.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/image_manager.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/line_breaker.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/inline_style.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/link.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/lists.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/paragraph_format.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/paragraph_style.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/quick_insert.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/quote.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/table.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/save.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/url.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/video.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/help.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/print.min.js"></script>
  <!-- <script type="text/javascript" src="/static/froala/js/third_party/spell_checker.min.js"></script> -->
  <script type="text/javascript" src="/static/froala/js/plugins/special_characters.min.js"></script>
  <script type="text/javascript" src="/static/froala/js/plugins/word_paste.min.js"></script>
  <script src="/static/froala/js/languages/zh_cn.js"></script>
  <script>
  // $(function(){
  //   $('#edit').froalaEditor()
  // });
  $(function() {
    //超大屏幕'fullscreen',
    var toolbarButtons = ['bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', 'fontFamily', 'fontSize', '|', 'color', 'emoticons', 'inlineStyle', 'paragraphStyle', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', 'insertHR', '-', 'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'insertTable', 'undo', 'redo', 'clearFormatting', 'selectAll', 'html', 'help'];
    //大屏幕
    var toolbarButtonsMD = ['bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', '|', 'fontFamily', 'fontSize', 'color', 'inlineStyle', 'paragraphStyle', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', '-', 'quote', 'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'insertTable', '|', 'specialCharacters', 'insertHR', 'undo', 'redo', 'clearFormatting', '|', 'html', 'help'];
    //小屏幕'fullscreen',
    var toolbarButtonsSM = ['bold', 'italic', 'underline', 'fontFamily', 'fontSize', 'insertLink', 'insertImage', 'insertTable', 'undo', 'redo'];
    //手机
    var toolbarButtonsXS = ['bold', 'italic', 'fontFamily', 'fontSize', 'undo', 'redo'];
    var pid = $('#pid').val();
    //编辑器初始化并赋值 
    $('#edit').froalaEditor({
      placeholderText: '请输入内容',
      charCounterCount: true, //默认
      // charCounterMax         : -1,//默认
      saveInterval: 0, //不自动保存，默认10000
      // theme                    : "red",
      height: "300px",
      toolbarBottom: false, //默认
      toolbarButtonsMD: toolbarButtons, //toolbarButtonsMD,
      toolbarButtonsSM: toolbarButtonsMD, //toolbarButtonsSM,
      toolbarButtonsXS: toolbarButtonsXS,
      toolbarInline: false, //true选中设置样式,默认false
      imageUploadMethod: 'POST',
      heightMin: 450,
      charCounterMax: 3000,
      // imageUploadURL: "uploadImgEditor",
      imageParams: { postId: "123" },
      params: {
        acl: '01',
        AWSAccessKeyId: '02',
        policy: '03',
        signature: '04',
      },
      autosave: true,
      autosaveInterval: 2500,
      saveURL: 'hander/FroalaHandler.ashx',
      saveParams: { postId: '1' },
      spellcheck: false,
      imageUploadURL: '/uploadimg', //上传到本地服务器
      imageUploadParams: { pid: '{{.Id}}' },
      imageDeleteURL: 'lib/delete_image.php', //删除图片
      imagesLoadURL: 'lib/load_images.php', //管理图片
      videoUploadURL: '/uploadvideo',
      videoUploadParams: { pid: '{{.Id}}' },
      fileUploadURL: '/uploadimg',
      fileUploadParams: { pid: '{{.Id}}' },
      enter: $.FroalaEditor.ENTER_BR,
      language: 'zh_cn',
      // toolbarButtons: ['bold', 'italic', 'underline', 'paragraphFormat', 'align','color','fontSize','insertImage','insertTable','undo', 'redo']
    });
  })

  //添加文章
  function save2() {
    // var radio =$("input[type='radio']:checked").val();
    var projectid = $('#pid').val();
    var prodcode = $('#prodcode1').val();
    var prodname = $('#prodname1').val();
    var subtext = $('#subtext1').val();
    var prodprincipal = $('#prodprincipal2').val();
    var prodlabel = $('#prodlabel2').val();
    var relevancy = $('#relevancy2').val();
    var html = $('div#edit').froalaEditor('html.get'); //$('#edit')[0].childNodes[1].innerHTML;
    // $('#myModal').on('hide.bs.modal', function () {  
    if (prodname && prodcode) {
      $.ajax({
        type: "post",
        url: "/project/product/addarticle",
        data: { pid: projectid, code: prodcode, title: prodname, subtext: subtext, label: prodlabel, content: html, principal: prodprincipal, relevancy: relevancy }, //父级id
        success: function(data, status) {
          alert("添加“" + data + "”成功！(status:" + status + ".)");
          $('#modalTable2').modal('hide');
          $('#table0').bootstrapTable('refresh', { url: '/article/getlist/' + {{.Id }}});
        },
      });
    } else {
      alert("请填写编号和名称！");
      return;
    }
  }


  // 编辑成果信息
  function updateprod() {
    // var radio =$("input[type='radio']:checked").val();
    var projectid = $('#cid').val();
    var prodcode = $('#prodcode3').val();
    var prodname = $('#prodname3').val();
    var prodlabel = $('#prodlabel3').val();
    var prodprincipal = $('#prodprincipal3').val();
    var relevancy = $('#relevancy3').val();
    if (prodname && prodcode) {
      $.ajax({
        type: "post",
        url: "/project/product/updateproduct",
        data: { pid: projectid, code: prodcode, title: prodname, label: prodlabel, principal: prodprincipal, relevancy: relevancy }, //父级id
        success: function(data, status) {
          alert("添加“" + data + "”成功！(status:" + status + ".)");
          $('#modalProdEditor').modal('hide');
          $('#table0').bootstrapTable('refresh', { url: '/article/getlist/' + {{.Id }}});
        },
      });
    } else {
      alert("请填写编号和名称！");
      return;
    }
  }
  // 删除附件
  $("#deleteAttachButton").click(function() {
    // if ({{.role}}!=1){
    //   alert("权限不够！");
    //   return;
    // }
    if ({{.RoleDelete }} != "true") {
      alert("权限不够！");
      return;
    }
    var selectRow = $('#attachments').bootstrapTable('getSelections');
    if (selectRow.length <= 0) {
      alert("请先勾选！");
      return false;
    }

    if ({{.RoleDelete }} != "true") {
      alert("权限不够！" + selectRow[0].Uid);
      return;
    }

    if (confirm("确定删除吗？一旦删除将无法恢复！")) {
      var title = $.map(selectRow, function(row) {
        return row.Title;
      })
      var ids = "";
      for (var i = 0; i < selectRow.length; i++) {
        if (i == 0) {
          ids = selectRow[i].Id;
        } else {
          ids = ids + "," + selectRow[i].Id;
        }
      }
      $.ajax({
        type: "post",
        url: "/project/product/deleteattachment",
        data: { ids: ids },
        success: function(data, status) {
          alert("删除“" + data + "”成功！(status:" + status + ".)");
          //删除已选数据
          $('#attachments').bootstrapTable('remove', {
            field: 'Title',
            values: title
          });
        }
      });
    }
  })

  //******表格追加项目同步ip中的数据*******
  $(function() {
    $('#synchIP').click(function() {
      // alert("ha ");
      $.ajax({
        type: "get",
        url: "/project/synchproducts/" + {{.Id }},
        // data: {ids:ids},
        success: function(data, status) {
          alert("同步成功！(status:" + status + ".)");
          //追加数据
          $('#table0').bootstrapTable('append', data);
          $('#table0').bootstrapTable('scrollTo', 'bottom');
        }
      });
    });
  });
  // $(document).ready(function() {
  //   $('#table0').bootstrapTable({
  //     // onLoadSuccess: function(){
  //       onPostBody: function(){
  //       alert("加载成功");
  //     $('#table0').bootstrapTable('append', randomData());
  //     $('#table0').bootstrapTable('scrollTo', 'bottom'); 
  //          return false;
  //       }
  //     });
  // });
  function randomData() {
    var startId = ~~(Math.random() * 100),
      rows = [];
    for (var i = 0; i < 10; i++) {
      rows.push({
        Id: startId + i,
        Code: startId + i,
        Title: 'test' + (startId + i),
        // id: startId + i,
        // name: 'test' + (startId + i),
        // price: '$' + (startId + i)
      });
    }
    return rows;
  }

  //勾选后输入框可用
  function station_select1() {
    if (box1.checked) {
      document.getElementById("relevancy1").disabled = false;
    } else {
      document.getElementById("relevancy1").disabled = true;
    }
  }

  function station_select2() {
    if (box2.checked) {
      document.getElementById("relevancy2").disabled = false;
    } else {
      document.getElementById("relevancy2").disabled = true;
    }
  }

  $(document).ready(function() {
    $("#modalDialog").draggable({ handle: ".modal-header" }); //为模态对话框添加拖拽
    $("#modalDialog1").draggable({ handle: ".modal-header" });
    $("#modalDialog2").draggable({ handle: ".modal-header" });
    $("#modalDialog3").draggable({ handle: ".modal-header" });
    $("#modalDialog4").draggable({ handle: ".modal-header" });
    $("#modalDialog5").draggable({ handle: ".modal-header" });
    $("#modalDialog6").draggable({ handle: ".modal-header" });
    $("#modalDialog7").draggable({ handle: ".modal-header" });
    $("#modalDialog8").draggable({ handle: ".modal-header" });
    $("#modalDialog9").draggable({ handle: ".modal-header" });
    $("#modalDialog10").draggable({ handle: ".modal-header" });
    $("#modalDialog11").draggable({ handle: ".modal-header" });
    // $("#modalNewDwg").draggable({ handle: ".modal-header" });
    // $("#modalFlow").draggable({ handle: ".modal-header" });
    $("#myModal").css("overflow", "hidden"); //禁止模态对话框的半透明背景滚动
  })
  </script>
</body>

</html>