{{define "navbar"}}
  <!-- navbar-inverse一个带有黑色背景白色文本的导航栏
  固定在页面的顶部，向 .navbar class 添加 class .navbar-fixed-top
  为了防止导航栏与页面主体中的其他内容
  的顶部相交错，需要向 <body> 标签添加内边距，内边距的值至少是导航栏的高度。
  -->
  <style type="text/css">
    a.navbar-brand {
      display: none;
    }

    @media (max-width: 960px) {
      a.navbar-brand {
        display: inline-block;
      }
    }
  </style>
  <nav class="navbar navbar-default navbar-static-top" style="margin-bottom: 5px;" role="navigation">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#target-menu">
        <span class="sr-only">qieh</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a id="11" class="navbar-brand">水利设计</a>
    </div>
    <div class="collapse navbar-collapse" id="target-menu">
      <ul class="nav navbar-nav">
        <li {{if .IsIndex}} class="active" {{end}}>
          <a href="/index">首页</a>
        </li>
        <li {{if .IsProject}}class="active"{{end}}>
          <a href="/project/0">资料</a>
        </li>
        <li {{if .IsArticle}}class="active"{{end}}>
          <a href="/article/">文章</a>
        </li>
        <!-- **********定制导航条菜单开始******** -->
        <li {{if .IsNav1}} class="dropdown active" {{end}}>
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            试验段 <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li {{if .IsNav1}} class="active" {{end}}>
              <a href="/project/25002">设计</a>
            </li>
            <li>
              <a href="/project/25005">建设</a>
            </li>
            <li>
              <a href="/project/25004">监理</a>
            </li>
            <li>
              <a href="/project/25003">施工</a>
            </li>
          </ul>
        </li>

        <!-- **********定制导航条菜单结束******** -->
        <li {{if .IsOnlyOffice}} class="active" {{end}}>
          <a href="/onlyoffice">OnlyOffice</a>
        </li>
        <form class="navbar-form navbar-left" role="search" method="get" action="/search">
        <div class="form-group">
          <input type="text" class="form-control" class="search-query span2" placeholder="Search Products" name="keyword" id="keyword"></div>
        <input type="hidden" name="productid" id="productid" value="{{.Category.Id}}">
        <button type="submit" class="btn btn-default" id="search">Submit</button>
        </form>

        <li {{if .IsBook}} class="active" {{end}}>
          <a href="/mindoc" title="创作你的书籍" target="_blank">BOOK</a>
        </li>
      </ul>
      <div class="pull-right">
        <ul class="nav navbar-nav navbar-right">
          {{if .IsLogin}}
            {{if .IsAdmin}}
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{.Username}} <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="/admin" title="管理">进入后台</a></li>
                  <li><a href="/cms/#/flow/usertobeprocessed" title="邮箱">邮箱</a></li>
                  <li><a href="javascript:void(0)" id="login">重新登录</a></li>
                  <li><a href="/v1/wx/ssologin" title="单点登录">SSO单点登陆</a></li>
                  <li><a href="/project/25001/gettimeline" title="大事记">大事记</a></li>
                  <li><a href="/project/25001/getcalendar" title="项目日历">项目日历</a></li>
                  <li><a href="/calendar" title="日程安排">日程安排</a></li>
                  <li><a href="javascript:void(0)" onclick="logout()">退出</a></li>
                </ul>
              </li>
            {{else}}
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{.Username}} <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="/cms/#/flow/usertobeprocessed" title="邮箱">邮箱</a></li>
                  <li><a href="/user" title="用户资料">用户资料</a></li>
                  <li><a href="javascript:void(0)" id="login">重新登录</a></li>
                  <li><a href="/v1/wx/ssologin" title="单点登录">SSO单点登陆</a></li>
                  <li><a href="/project/25001/gettimeline" title="大事记">大事记</a></li>
                  <li><a href="/project/25001/getcalendar" title="项目日历">项目日历</a></li>
                  <li><a href="/calendar" title="日程安排">日程安排</a></li>
                  <li><a href="javascript:void(0)" onclick="logout()">退出</a></li>
                </ul>
              </li>
            {{end}}
          {{else}}
            {{if .IsAdmin}}
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{.Username}} <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="/admin" title="管理">进入后台</a></li>
                  <li><a href="/cms/#/flow/usertobeprocessed" title="邮箱">邮箱</a></li>
                  <li><a href="javascript:void(0)" id="login">重新登录</a></li>
                  <li><a href="/v1/wx/ssologin" title="单点登录">SSO单点登陆</a></li>
                  <li><a href="/project/25001/gettimeline" title="大事记">大事记</a></li>
                  <li><a href="/project/25001/getcalendar" title="项目日历">项目日历</a></li>
                  <li><a href="/calendar" title="日程安排">日程安排</a></li>
                  <li><a href="javascript:void(0)" onclick="logout()">退出</a></li>
                </ul>
              </li>
            {{else}}
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{.Username}} <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="javascript:void(0)" id="login">登陆</a></li>
                  <li><a href="/v1/wx/ssologin" title="单点登录">SSO单点登陆</a></li>
                </ul>
              </li>
            {{end}}
          {{end}}
          <li {{if .IsWiki}} class="active" {{end}}>
            <a href="/wiki">Wiki</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- 登录模态框 -->
  <div class="form-horizontal">
    <div class="modal fade" id="modalNav">
      <div class="modal-dialog" id="modalDialog">
        <div class="modal-content">
          <div class="modal-header" style="background-color: #8bc34a">
            <button type="button" class="close" data-dismiss="modal">
              <span aria-hidden="true">&times;</span>
            </button>
            <h3 class="modal-title">登录</h3>
            <label id="status"></label>
          </div>
          <div class="modal-body">
            <div class="modal-body-content">
              <div class="form-group" style="width: 100%;">
                <label class="col-sm-3 control-label">用户名 或 邮箱</label>
                <div class="col-sm-7">
                  <input id="uname" name="uname" type="text" value="" class="form-control" placeholder="Enter account" list="cars" onkeypress="getKey()"></div>
              </div>
              <div class="form-group" style="width: 100%;">
                <label class="col-sm-3 control-label">密码</label>
                <div class="col-sm-7">
                  <input id="pwd" name="pwd" type="password" value="" class="form-control" placeholder="Password" onkeypress="getKey()"></div>
              </div>
              <div class="form-group" style="width: 100%;">
                <label class="col-sm-3 control-label"><input type="checkbox">自动登陆</label>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-primary" onclick="login()">登录</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    // 弹出登录模态框
    $("#login").click(function() {
      $('#modalNav').modal({
        show: true,
        backdrop: 'static'
      });
    })

    //登陆功能
    function login() {
      var uname = document.getElementById("uname");
      if (uname.value.length == 0) {
        alert("请输入账号");
        return
      }
      var pwd = document.getElementById("pwd");
      if (pwd.value.length == 0) {
        alert("请输入密码");
        return
      }

      $.ajax({
        type: 'post',
        url: '/loginpost',
        data: {
          "uname": $("#uname").val(),
          "pwd": $("#pwd").val()
        },
        success: function(result) {
          if (result.islogin == 0) {
            $("#status").html("登陆成功");
            $('#modalNav').modal('hide');
            window.location.reload();
          } else if (result.islogin == 1) {
            $("#status").html("用户名或密码错误！")
          } else if (result.islogin == 2) {
            $("#status").html("密码错误")
          }
        }
      })
    }
    //登出功能
    function logout() {
      $.ajax({
        type: 'get',
        url: '/logout',
        data: {},
        success: function(result) {
          if (result.islogin) {
            // $("#status").html("登出成功");
            alert("登出成功");
            window.location.reload();
          } else {
            // $("#status").html("登出失败");
            alert("登出失败")
          }
        }
      })
    }

    function getKey() {
      if (event.keyCode == 13) {
        login()
      }
    }
  </script>
{{end}}
