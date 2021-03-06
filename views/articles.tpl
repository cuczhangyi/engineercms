<!-- 具体一个项目的侧栏，右侧为project_products.tpl,显示任意侧栏下的成果 -->
<!DOCTYPE html>
{{template "header"}}
<title>软件培训-EngiCMS</title>
<script src="/static/js/bootstrap-treeview.js"></script>
<link rel="stylesheet" type="text/css" href="/static/css/bootstrap-treeview.css" />

  <meta charset="utf-8">
  <link rel="stylesheet" href="https://unpkg.com/ionicons@4.5.5/dist/css/ionicons.min.css">
  <link rel="stylesheet" href="/static/css/jquery.mCustomScrollbar.min.css">
  <link rel="stylesheet" href="/static/css/custom.css">
  <link rel="stylesheet" type="text/css" href="/static/font-awesome-4.7.0/css/font-awesome.min.css" />
  <script src="/static/js/jquery.mCustomScrollbar.concat.min.js"></script>
  <script src="/static/js/custom.js"></script>
  <!-- <style type="text/css">
    @import 'https://unpkg.com/ionicons@4.5.5/dist/css/ionicons.min.css';
    
    body,
    html {
      margin: 0;
      padding: 0;
      height: 100%;
      width: 100%;
      font-family: sans-serif;
    }
    
    .sidebar {
      float: left;
      width: 100px;
      height: 100%;
      margin-left: -100px;
      background: #2c3e50;
      overflow: hidden;
      transition: 0.8s all;
    }
    
    .side {
      margin-left: 0;
    }
    
    .sidebar ul {
      margin: 0;
      padding: 0;
    }
    
    .sidebar ul li {
      list-style: none;
    }
    
    .sidebar ul li a {
      text-decoration: none;
      color: white;
      height: 80px;
      width: 100%;
      font-size: 40px;
      line-height: 80px;
      text-align: center;
      display: block;
      transition: 0.6s all;
    }
    
    .sidebar ul li a:hover {
      background: #34495e;
    }
    
    .btn {
      float: left;
      padding: 0 10px;
      font-size: 40px;
      text-decoration: none;
      color: #2c5e50;
      font-family: ionicons;
      cursor: pointer;
    }
    
    .btn:before {
      content: '\f32a';
    }
    
    .btnc:before {
      content: '\f2c0';
    }
  </style> -->
</head>

<div class="container-fill">{{template "navbar" .}}</div>
<body>
  <div class="page-wrapper toggled">
    <nav id="sidebar" class="sidebar-wrapper">
      <div class="sidebar-content mCustomScrollbar _mCS_1 mCS-autoHide desktop">
        <div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" tabindex="0" style="max-height: none;">
          <div id="mCSB_1_container" class="mCSB_container" dir="ltr">
            <a href="#" id="toggle-sidebar"> <i class="fa fa-bars"></i>
            </a>
            <div class="sidebar-brand">
              <a href="#">pro sidebar</a>
            </div>
            <div class="sidebar-menu">
              <ul id="tree"></ul>
            </div>
          </div>
        </div>
      </div>
    </nav>
    <main class="page-content">
      <div class="breadcrumbs">
        <ol class="breadcrumb" style="margin-bottom: 2px;" split="&gt;">
          <li>
            <i class="fa fa-home" aria-hidden="true"></i>文章列表
          </li>
        </ol>
      </div>
      <div class="container-fluid">
        <iframe src="/article/list/0" name='iframepage' id="iframepage" frameborder="0" width="100%" scrolling="no" marginheight="0" marginwidth="0" onload="this.height=800"></iframe>
      </div>
    </main>
  </div>
  
<script type="text/javascript">
  // $('.btn').on('click', function() {
  //   $('.btn').toggleClass('btnc');
  //   $('.sidebar').toggleClass('side');
  // })

  $(function() {
    $('#tree').treeview({
      data: [{{.json }}],
      levels: 2,
      showTags: true,
      loadingIcon: "fa fa-minus",
      lazyLoad: loaddata,
    });
    $('#tree').on('nodeSelected', function(event, data) {
      document.getElementById("iframepage").src = "/article/list/" + data.id;

      $.ajax({
        type: "get",
        url: "/article/navbar",
        success: function(res, status) {
          // $(".breadcrumb #nav").remove();
          // console.log(res)
          // for (i = 0; i < res.length; i++) {
          //   $(".breadcrumb").append('<li id="nav"><a href="javascript:gototree(' + res[i].Id + ')">' + res[i].Title + '</a></li>');
          // }
        }
      });
    });
    $("#btn").click(function(e) {
      var arr = $('#tree').treeview('getSelected');
      for (var key in arr) {
        c.innerHTML = c.innerHTML + "," + arr[key].id;
      }
    });
  })

  function loaddata(node, func) {
    $.ajax({
      type: "get",
      url: "/article/navbar",
      data: { id: node.id },
      success: function(data, status) {
        if (data) {
          func(data);
        }
      }
    });
  }

  function gototree(e) {
    document.getElementById("iframepage").src = "/article/list/" + e;
    var findCheckableNodess = function() {
      return $('#tree').treeview('findNodes', [e, 'id']);
    };
    var checkableNodes = findCheckableNodess();
    $('#tree').treeview('toggleNodeSelected', [checkableNodes, { silent: true }]);
    $('#tree').treeview('toggleNodeExpanded', [checkableNodes, { silent: true }]);
    $('#tree').treeview('revealNode', [checkableNodes, { silent: true }]);
  }

  function reinitIframe() {
    var iframe = document.getElementById("iframepage");
    try {
      var bHeight = iframe.contentWindow.document.body.scrollHeight;
      var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
      var height = Math.max(bHeight, dHeight, 800);
      iframe.height = height;
    } catch (ex) {}
  }
  window.setInterval("reinitIframe()", 200);
  </script>
</body>

</html>