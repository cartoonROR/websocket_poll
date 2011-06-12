
/* ============= submit for vote ====================*/

  $('#submit-poll').live({
    click: function(){
      var select_poll = $('.selete-poll:checked').val();
      var key = $('#title-name').data('key');
      if(select_poll){
        $.ajax({
          url: "save",
          type: "POST",
          data: ({key:key,data:select_poll,vote:"vote"}),
          success: function(data){
              $('#show-poll-list').remove();
              var obj = new Array();
              for(var i = 0;i<data[0].length;i++){
              obj[i]=[data[0][i].sub_poll.name,data[0][i].sub_poll.point];
            }
               $('#show-poll').show();
              $.jqplot('show-poll', [obj], {
              seriesDefaults:{
                renderer:$.jqplot.PieRenderer,
                rendererOptions: {
                  showDataLabels: true,
                  dataLabelThreshold: 1,
                  dataLabelFormatString: '%.1f%%'
                }
              },
              legend: {
                show: true,
                placement: 'outside'
              }
            });
          }
        });
      }
    }
  });

/*============== sent message of websocket =====================*/

Socky.prototype.respond_to_message = function(data) {
    var obj = $.parseJSON(data);
    if($('#title-name').data("key") == obj[1]){
        var s = new Array();
            for(var i = 0;i<obj[0].length;i++){
              s[i]=[obj[0][i].sub_poll.name,obj[0][i].sub_poll.point];
            }

    if(obj[2]=="socky"){
            $('#show-poll').html("");
         $.jqplot('show-poll', [s], {
              seriesDefaults:{
                renderer:$.jqplot.PieRenderer,
                rendererOptions: {
                  showDataLabels: true,
                  dataLabelThreshold: 1,
                  dataLabelFormatString: '%.1f%%'
                }
              },
              legend: {
                show: true,
                placement: 'outside'
              }
            });
    }else{
        $('#show-poll').show();
    }
    }

};


  /*=================== add item for sub poll ==================*/
  $('#add-item').live({
    click: function(){
      var inputtxt = "<div class='box-sub-item sub-item-select' data-sub-poll-id=''><span><input type='text' class='name-item'></span><span class='save-item div-submit'>Save</span><span class='delete-item div-submit'>Delete</span></div>";
      $('#poll-list-item').append(inputtxt);
    }
  });
  /*================== delete item for sub poll =================*/
  $('.delete-item').live({
    click: function(){
      var id = $(this).parent().data('sub-poll-id');
      var delete_click = $(this);
      if(id !=""){
        $.ajax({
          url: "deleteitem",
          type: "POST",
          data: ({id:id}),
          success: function(data){
            delete_click.parent().remove();
          }
        });
      }else{
        delete_click.parent().remove();
      }
    }
  });
  /*================= save item for sub poll =====================*/
  $('.save-item').live({
    click: function(){
      var save_click = $(this);
      var name_item = $(this).parent().find('input').val();
      var id_poll = $('#poll-title').data("poll-id");
      var id_sub_item = $(this).parent().data('sub-poll-id');
      $.ajax({
        url: "saveitem",
        type: "POST",
        data: ({id:id_poll,name : name_item,item_id: id_sub_item}),
        success: function(data){
          save_click.parent().data('sub-poll-id',data.sub_poll.id).removeClass("sub-item-select");
        }
      });
    }
  });
   /*=============== event keydown on input text for sub poll ======*/
  $('.name-item').live({
      keydown: function(){
         $(this).parent().parent().addClass("sub-item-select");
      }
  });