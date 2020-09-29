<!-- iframe里组织结构代码表-->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Merit</title>
  <script type="text/javascript" src="/static/js/jquery-3.3.1.min.js"></script>
  <script type="text/javascript" src="/static/js/bootstrap.min.js"></script>
  <!-- <script src="/static/js/bootstrap-treeview.js"></script> -->
  <script type="text/javascript" src="/static/js/jquery.tablesorter.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/static/css/bootstrap.min.css"/>

  <link rel="stylesheet" type="text/css" href="/static/css/bootstrap-table.min.css"/>
  <!-- <link rel="stylesheet" type="text/css" href="/static/css/bootstrap-editable.css"/> -->

  <script type="text/javascript" src="/static/js/bootstrap-table.min.js"></script>
  <script type="text/javascript" src="/static/js/bootstrap-table-zh-CN.min.js"></script>
  <!-- <script type="text/javascript" src="/static/js/bootstrap-table-editable.min.js"></script> -->
  <!-- <script type="text/javascript" src="/static/js/bootstrap-editable.js"></script> -->
  <script type="text/javascript" src="/static/js/bootstrap-table-export.min.js"></script>

  <link rel="stylesheet" type="text/css" href="/static/font-awesome-4.7.0/css/font-awesome.min.css"/>
  <script src="/static/js/tableExport.js"></script>

</head>
<body>

<script type="text/javascript">
  function index1(value,row,index){
    // alert( "Data Loaded: " + index );
    return index+1
  }

  // 改变点击行颜色
  $(function(){
    // $("#table").bootstrapTable('destroy').bootstrapTable({
    //     columns:columns,
    //     data:json
    // });
    $("#table0").on("click-row.bs.table",function(e,row,ele){
      $(".info").removeClass("info");
      $(ele).addClass("info");
      rowid=row.Id;//全局变量
      rowname=row.Name;
      $("#rowtitle").html("分类-"+rowname);
      $("#details").show();
      $('#table1').bootstrapTable('refresh', {url:'/admin/articlecate/'+row.Id});
    });
    // $("#get").click(function(){
    //     alert("商品名称：" + getContent().TuanGouName);
    // })
  });
</script>

<div class="col-lg-12">
  <h3>分类列表</h3>
  <div id="toolbar1" class="btn-group">
    <button type="button" data-name="addButton" id="addButton" class="btn btn-default"> <i class="fa fa-plus">添加</i>
    </button>
    <button type="button" data-name="editorButton" id="editorButton" class="btn btn-default"> <i class="fa fa-edit">编辑</i>
    </button>
    <button type="button" data-name="deleteButton" id="deleteButton" class="btn btn-default">
      <i class="fa fa-trash">删除</i>
    </button>
  </div>

  <table id="table0"
         data-url="/admin/articlecate"
         data-search="true"
         data-show-refresh="true"
         data-show-toggle="true"
         data-show-columns="true"
         data-toolbar="#toolbar1"
         data-query-params="queryParams"
         data-sort-name="DepartName"
         data-sort-order="desc"
         data-page-size="5"
         data-page-list="[5, 25, 50, All]"
         data-unique-id="id"
         data-pagination="true"
         data-side-pagination="client"
         data-single-select="true"
         data-click-to-select="true"
  >
    <thead>
    <tr>
      <!-- radiobox data-checkbox="true"-->
      <th data-width="10" data-radio="true"></th>
      <th data-formatter="index1">#</th>
      <!-- <th data-field="Id">Id</th> -->
      <th data-field="Name">分类名称</th>
    </tr>
    </thead>
  </table>
  <!-- <div class="gridview2"></div> -->

  <script type="text/javascript">
    /*数据json*/
    var json =  [{"Id":"1","Title":"水利","Code":"SL"},
      {"Id":"2","Title":"电力","Code":"DL"},
      {"Id":"3","Title":"市政","Code":"CJ"},
      {"Id":"4","Title":"建筑","Code":"JG"},
      {"Id":"5","Title":"交通","Code":"JT"},
      {"Id":"6","Title":"境外","Code":"JW"}];
    /*初始化table数据*/
    $(function(){
      $("#table0").bootstrapTable({
        data:json,
        // onClickRow: function (row, $element) {
        // alert( "选择了行Id为: " + row.Id );
        // rowid=row.Id//全局变量
        // $('#table1').bootstrapTable('refresh', {url:'/admincategory?pid='+row.Id});
        // }
      });
    });

    $(document).ready(function() {
      $("#addButton").click(function() {
        $('#modalTable').modal({
          show:true,
          backdrop:'static'
        });
      })

      $("#editorButton").click(function() {
        var selectRow=$('#table0').bootstrapTable('getSelections');
        if (selectRow.length<1){
          alert("请先勾选分类！");
          return;
        }
        if (selectRow.length>1){
          alert("请不要勾选一个以上分类！");
          return;
        }
        $("input#cid").remove();
        var th1="<input id='cid' type='hidden' name='cid' value='" +selectRow[0].Id+"'/>"
        $(".modal-body").append(th1);//这里是否要换名字$("p").remove();
        $("#projcatename1").val(selectRow[0].Name);
        $('#modalTable1').modal({
          show:true,
          backdrop:'static'
        });
      })

      $("#deleteButton").click(function() {
        var selectRow=$('#table0').bootstrapTable('getSelections');
        if (selectRow.length<=0) {
          alert("请先勾选分类！");
          return false;
        }
        var title=$.map(selectRow,function(row){
          return row.Name;
        })
        var ids="";
        for(var i=0;i<selectRow.length;i++){
          if(i==0){
            ids=selectRow[i].Id;
          }else{
            ids=ids+","+selectRow[i].Id;
          }
        }
        $.ajax({
          type:"post",
          url:"/admin/articlecate/deletearticlecate",
          data: {ids:ids},
          success:function(data,status){
            alert("删除“"+data+"”成功！(status:"+status+".)");
            //删除已选数据
            $('#table0').bootstrapTable('remove',{
              field:'Name',
              values:title
            });
          }
        });
      })
    })

  </script>

  <!-- 添加分类代码 -->
  <div class="container form-horizontal">
    <div class="modal fade" id="modalTable">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">
              <span aria-hidden="true">&times;</span>
            </button>
            <h3 class="modal-title">添加分类</h3>
          </div>
          <div class="modal-body">
            <div class="modal-body-content">
              <div class="form-group must">
                <label class="col-sm-3 control-label">分类名称</label>
                <div class="col-sm-7">
                  <input type="text" class="form-control" id="projcatename" name="projcatename"></div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-primary" onclick="save()">保存</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    function save(){
      // var radio =$("input[type='radio']:checked").val();
      var projcatename = $('#projcatename').val();
      // $('#myModal').on('hide.bs.modal', function () {
      if (projcatename){
        $.ajax({
          type:"post",
          url:"/admin/articlecate/addarticlecate",
          data: {name:projcatename},
          success:function(data,status){
            alert("添加“"+data+"”成功！(status:"+status+".)");
          }
        });
      }
      // $(function(){$('#myModal').modal('hide')});
      $('#modalTable').modal('hide');
      $('#table0').bootstrapTable('refresh', {url:'/admin/articlecate'});
      // "/category/modifyfrm?cid="+cid
      // window.location.reload();//刷新页面
    }

    function update(){
      // var radio =$("input[type='radio']:checked").val();
      var projcatename1 = $('#projcatename1').val();
      var cid = $('#cid').val();
      // $('#myModal').on('hide.bs.modal', function () {
      if (projcatename1){
        $.ajax({
          type:"post",
          url:"/admin/articlecate/updatearticlecate",
          data: {cid:cid,name:projcatename1},
          success:function(data,status){
            alert("添加“"+data+"”成功！(status:"+status+".)");
          }
        });
      }
      // $(function(){$('#myModal').modal('hide')});
      $('#modalTable1').modal('hide');
      $('#table0').bootstrapTable('refresh', {url:'/admin/articlecate'});
      // "/category/modifyfrm?cid="+cid
      // window.location.reload();//刷新页面
    }
  </script>
  <!-- 修改分类代码 -->
  <div class="container" class="form-horizontal">
    <!-- <form > -->
    <div class="modal fade" id="modalTable1">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">
              <span aria-hidden="true">&times;</span>
            </button>
            <h3 class="modal-title">修改分类</h3>
          </div>
          <div class="modal-body">
            <div class="modal-body-content">
              <div class="form-group must">
                <label class="col-sm-3 control-label">分类</label>
                <div class="col-sm-7">
                  <input type="text" class="form-control" id="projcatename1"></div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-primary" onclick="update()">修改</button>
          </div>
        </div>
      </div>
    </div>
    <!-- </form> -->
  </div>
  <!-- onClickRow  click-row.bs.table  row, $element 当用户点击某一行的时候触发，参数包括：
  row：点击行的数据，
  $element：tr 元素，
  field：点击列的 field 名称 -->
  <script type="text/javascript">
    /*初始化table数据*/
    /*数据json*/
    function format_status(status,row,index) {
      if(status == 1){
        return '显示'
      }else if(status == 2){
        return  '隐藏'
      }else if(status == 0){
        return  '禁止'
      }
    }

    $(document).ready(function() {
      //添加分类
      $("#addButton1").click(function() {
        $("input#pid").remove();
        var th1="<input id='pid' type='hidden' name='pid' value='" +rowid+"'/>"
        $(".modal-body").append(th1);
        $('#modalTable2').modal({
          show:true,
          backdrop:'static'
        });
      })
      //编辑分类
      $("#editorButton1").click(function() {
        var selectRow3=$('#table1').bootstrapTable('getSelections');
        if (selectRow3.length<1){
          alert("请先勾选分类！");
          return;
        }
        if (selectRow3.length>1){
          alert("请不要勾选一个以上分类！");
          return;
        }
        $("input#cid").remove();
        var th2="<input id='cid' type='hidden' name='cid' value='" +selectRow3[0].Id+"'/>"
        $(".modal-body").append(th2);//这里是否要换名字$("p").remove();
        $("#projcatename3").val(selectRow3[0].Name);
        $('#modalTable3').modal({
          show:true,
          backdrop:'static'
        });
      })
      //删除分类
      $("#deleteButton1").click(function() {
        var selectRow=$('#table1').bootstrapTable('getSelections');
        if (selectRow.length<=0) {
          alert("请先勾选分类！");
          return false;
        }
        var titles=$.map(selectRow,function(row){
          return row.Name;
        })
        var ids="";
        for(var i=0;i<selectRow.length;i++){
          if(i==0){
            ids=selectRow[i].Id;
          }else{
            ids=ids+","+selectRow[i].Id;
          }
        }
        $.ajax({
          type:"post",
          url:"/admin/articlecate/deletearticlecate",
          data: {ids:ids},
          success:function(data,status){
            alert("删除“"+data+"”成功！(status:"+status+".)");
            //删除已选数据
            $('#table1').bootstrapTable('remove',{
              field:'Name',
              values:titles
            });
          }
        });
      })
      // ******试验提交选择的表格************
      $("#submitButton1").click(function() {
        var selectRow3=$('#table1').bootstrapTable('getSelections');
        // var obj = selectRow3.parseJSON();
        // var obj = jQuery.parseJSON(selectRow3);
        console.log(selectRow3[0].Code);
        if (selectRow3.length<1){
          alert("请先勾选目录！");
          return;
        }
        var obj = JSON.stringify(selectRow3);
        alert(selectRow3);
        alert(obj);
        console.log(obj);
        // var ids=$.map(selectRow3,function(row){
        //     return row.Id;
        //   })
        // alert(ids);
        var ids="";
        for(var i=0;i<selectRow3.length;i++){
          if(i==0){
            ids=selectRow3[i].Id;
          }else{
            ids=ids+","+selectRow3[i].Id;
          }

        }
        $.ajax({
          type:"post",
          url:"/project/category/addcategory",
          data: {rows:selectRow3},
          success:function(data,status){
            alert("添加“"+data+"”成功！(status:"+status+".)");
          }
        });
      })
    })

  </script>

  <!-- 分类 -->
  <toolbar id="btn_toolbar1" class="toolbar">
    <div class="btn-group">
      <button type="button" data-name="addButton1" id="addButton1" class="btn btn-default" data-target="modal"><i class="fa fa-plus" aria-hidden="true"></i>添加</button>
      <button type="button" data-name="editorButton1" id="editorButton1" class="btn btn-default" data-target="modal"><i class="fa fa-edit" aria-hidden="true"></i>编辑</button>
      <button type="button" data-name="deleteButton1" id="deleteButton1" class="btn btn-default" data-target="default"><i class="fa fa-trash" aria-hidden="true"> </i>删除</button>
    </div>
  </toolbar>
  <!-- data-query-params="queryParams" data-content-type="application/json"-->
  <!-- 显示分类 -->
  <div id="details" style="display:none">
    <h3 id="rowtitle"></h3>
    <!-- data-url="/admin/category/2" 没有了这个，当然table1表格无法支持刷新了！！！data-show-refresh="true"-->
    <table id="table1"
           data-toggle="table"
           data-search="true"
           data-show-toggle="true"
           data-show-columns="true"
           data-toolbar="#btn_toolbar1"
           data-sort-name="Grade"
           data-page-size="5"
           data-page-list="[5, 25, 50, All]"
           data-unique-id="id"
           data-pagination="true"
           data-side-pagination="client"
           data-click-to-select="true">
      <thead>
      <tr>
        <th data-width="10" data-checkbox="true"></th>
        <th data-formatter="index1">#</th>
        <th data-field="Name">名称</th>
      </tr>
      </thead>
    </table>
  </div>
  <script type="text/javascript">
    // 改变点击行颜色
    $(function(){
      // $("#table").bootstrapTable('destroy').bootstrapTable({
      //     columns:columns,
      //     data:json
      // });
      $("#table1").on("click-row.bs.table",function(e,row,ele){
        $(".info").removeClass("info");
        $(ele).addClass("info");
        rowid=row.Id;//全局变量
        rowname=row.Name;
        $("#rowtitle").html("分类-"+rowname);
        $("#details").show();
        $('#table2').bootstrapTable('refresh', {url:'/admin/articlecate/'+row.Id});
      });
      // $("#get").click(function(){
      //     alert("商品名称：" + getContent().TuanGouName);
      // })
    });
  </script>
  <!-- 添加分类 -->
  <div class="container">
    <form  class="form-horizontal">
      <div class="modal fade" id="modalTable2">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
              </button>
              <h3 class="modal-title">添加分类</h3>
            </div>
            <div class="modal-body">
              <div class="modal-body-content">
                <div class="form-group must">
                  <label class="col-sm-3 control-label">分类名称</label>
                  <div class="col-sm-7">
                    <input type="text" class="form-control" id="catename"></div>
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
    </form>
  </div>
  <script type="text/javascript">
    function save2(){
      // var radio =$("input[type='radio']:checked").val();
      var catename = $('#catename').val();
      var parentid = $('#pid').val();
      // $('#myModal').on('hide.bs.modal', function () {
      if (catename)
      {
        $.ajax({
          type:"post",
          url:"/admin/articlecate/addarticlecate",
          data: {pid:parentid,name:catename},
          success:function(data,status){
            alert("添加“"+data+"”成功！(status:"+status+".)");
          }
        });
      }
      // $(function(){$('#myModal').modal('hide')});
      $('#modalTable2').modal('hide');
      $('#table1').bootstrapTable('refresh', {url:'/admin/articlecate/'+parentid});
    }
    function update2(){
      // var radio =$("input[type='radio']:checked").val();
      var projcatename3 = $('#projcatename3').val();
      var cid = $('#cid').val();
      if (projcatename3)
      {
        $.ajax({
          type:"post",
          url:"/admin/articlecate/updatearticlecate",
          data: {cid:cid,name:projcatename3},
          success:function(data,status){
            alert("添加“"+data+"”成功！(status:"+status+".)");
          }
        });
      }
      // $(function(){$('#myModal').modal('hide')});
      $('#modalTable3').modal('hide');
      // alert("添加“"+rowid);
      $('#table1').bootstrapTable('refresh', {url:'/admin/articlecate/'+rowid});
    }

  </script>
  <!-- 修改分类 -->
  <div class="container">
    <form class="form-horizontal">
      <div class="modal fade" id="modalTable3">
        <div class="modal-dialog">
          <div  class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
              </button>
              <h3 class="modal-title">修改分类</h3>
            </div>
            <div class="modal-body">
              <div class="modal-body-content">
                <div class="form-group must">
                  <label class="col-sm-3 control-label">分类名称</label>
                  <div class="col-sm-7">
                    <input type="text" class="form-control" id="projcatename3"></div>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
              <button type="submit" class="btn btn-primary" onclick="update2()">修改</button>
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
  <br/>
  <br/>
</div>

</body>
</html>